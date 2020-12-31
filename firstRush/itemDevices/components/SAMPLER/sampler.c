#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "esp_event.h"
#include "nvs_flash.h"
#include "driver/spi_master.h"
#include "driver/gpio.h"
#include "esp_timer.h"
#include <math.h>
#include "wired.h"



#define ADC_HOST    HSPI_HOST

#define PIN_NUM_MISO 12
#define PIN_NUM_MOSI 13
#define PIN_NUM_CLK  14
#define PIN_NUM_CS   15

#define DFT_RANGE	 40
#define CLOCK_FREQ	 1000000
#define SOUND_FREQ	 20000

DRAM_ATTR uint8_t cmd_read[3] = {0xC0, 0x00, 0x00}; // Channel 0 single ended read sequence
DRAM_ATTR uint8_t receive[3];

DRAM_ATTR uint32_t results[DFT_RANGE];
DRAM_ATTR float frequencies[DFT_RANGE];
DRAM_ATTR uint8_t idx = 0;
DRAM_ATTR uint32_t spi_counter = 0;
DRAM_ATTR uint32_t spi_counter_saved = 0;
DRAM_ATTR uint32_t dft_counter = 0;
DRAM_ATTR TaskHandle_t adc_spi_task_handle, dft_task_handle;

esp_timer_handle_t periodic_timer;
spi_transaction_t transfer;
spi_device_handle_t spi;
//lets believe in this shit

uint8_t dev_id;

void periodic_timer_callback(void* arg);
void adc_spi_task(void *pvParameters);
void dft_task(void *pvParameters);
float mean(float* arr, int len);

void init_sampler(uint8_t dev_idd) {

    dev_id = dev_idd;
    // TIMER
    const esp_timer_create_args_t periodic_timer_args = {
              .callback = &periodic_timer_callback,
              /* name is optional, but may help identify the timer when debugging */
              .name = "periodic"
    };

    ESP_ERROR_CHECK(esp_timer_create(&periodic_timer_args, &periodic_timer));
    /* The timer has been created but is not running yet */

    //SPI
    esp_err_t ret;
	spi_bus_config_t spiBusCfg={
			.miso_io_num=PIN_NUM_MISO,
			.mosi_io_num=PIN_NUM_MOSI,
			.sclk_io_num=PIN_NUM_CLK,
			.quadwp_io_num=-1,
			.quadhd_io_num=-1,
			.max_transfer_sz=18
			// TODO interrupt flags
	};
	spi_device_interface_config_t devCfg={
			.clock_speed_hz=3200000, // 3.2 MHz max allowed is 3.6 MHz
			.mode=3,
			.spics_io_num=PIN_NUM_CS,
			.queue_size=1, // Not sure whether this should be 0 or 1
			.cs_ena_posttrans=1
	};
	memset(&transfer, 0, sizeof(spi_transaction_t));
	transfer.length = 18;
	transfer.tx_buffer = cmd_read;
	transfer.rx_buffer = receive;

	ret = spi_bus_initialize(ADC_HOST, &spiBusCfg, 0);
	ESP_ERROR_CHECK(ret);
	ret=spi_bus_add_device(ADC_HOST, &devCfg, &spi);
	ESP_ERROR_CHECK(ret);
}

void startSampler(){

	xTaskCreatePinnedToCore(adc_spi_task, "ADC", 1000, NULL, 2, &adc_spi_task_handle, 1);
	xTaskCreatePinnedToCore(dft_task, "DFT", 3000, NULL, 3, &dft_task_handle, 0);

    ESP_ERROR_CHECK(esp_timer_start_periodic(periodic_timer, 1000000));

}


void adc_spi_task(void *pvParameters){

	vTaskSuspendAll();
    esp_err_t ret;
	int64_t now, prev = esp_timer_get_time();
	for(;;){
		now = esp_timer_get_time();
		ret = spi_device_polling_transmit(spi, &transfer);
		results[idx] = ((uint32_t)(receive[1]) << 2) + (receive[2] >> 6);
		frequencies[idx] = CLOCK_FREQ / (float)(now - prev);
		idx++; if(idx == DFT_RANGE) idx=0;
		prev = now;
		spi_counter++;
		xTaskNotifyGive(dft_task_handle);
		taskYIELD();
	}

}

void periodic_timer_callback(void* arg)
{
	// nothing
	//printf("%d\t%d\n", spi_counter, dft_counter);
    spi_counter_saved = spi_counter;
	spi_counter = 0; dft_counter = 0;
}

void dft_task(void *pvParameters){
	float fSample, omega, sumCos, sumSin, dft;
	uint32_t notification;
    int mode = 3;
    int i = 0;

    float fSampleStationary = 0;
    float fSampleSwitchThreshold = 100;

    float cosfTable[DFT_RANGE];
    float sinfTable[DFT_RANGE];

    int printInterval = 1000;

    float dftRegisterThreshold = 800;
    int64_t dftRegisterInterval = 2000;
    int64_t registeredTime = 0;


	for(;;){
		notification = ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        i++;
        i = i % mode;
//		if(notification > 1) printf("error %\n");
        if(i == 0){
            if(spi_counter_saved > fSampleStationary + fSampleSwitchThreshold || spi_counter_saved < fSampleStationary - fSampleSwitchThreshold){
                fSampleStationary = spi_counter_saved;
                omega = 2 * M_PI * SOUND_FREQ / fSampleStationary;
                for(int i = 0; i < DFT_RANGE; i++){
                    cosfTable[i] =  cosf(omega * i);
                    sinfTable[i] = sinf(omega * i);
                }                
            }
            
            sumCos = 0; sumSin = 0;
            for(int i = 0; i < DFT_RANGE; i++){
                sumCos +=  cosfTable[i] *  (float)(results[i]);
                sumSin +=  sinfTable[i] *  (float)(results[i]);
            }

            dft = sqrtf(sumCos * sumCos + sumSin * sumSin);
            dft_counter++;
            if(dft > dftRegisterThreshold){
                int64_t currentTime = esp_timer_get_time();
                if(currentTime - registeredTime > dftRegisterInterval){
                    registeredTime = currentTime;
                     send_own_register(dev_id, currentTime);
                }
            }
                //printf("dft is %f\n", dft);
            taskYIELD();
        }

	}
}

float mean(float* arr, int len){
	float mn = 0;
	for(int i = 0; i < len; i++){
		mn += arr[i];
	}
	return mn / len;
}































