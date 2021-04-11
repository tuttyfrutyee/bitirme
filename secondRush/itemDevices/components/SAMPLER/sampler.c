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

#include "helper.h"
#include "queueMeasurement.h"


#define ADC_HOST    HSPI_HOST

#define PIN_NUM_MISO 12
#define PIN_NUM_MOSI 13
#define PIN_NUM_CLK  14
#define PIN_NUM_CS   15

#define DFT_RANGE	 20
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
DRAM_ATTR TaskHandle_t adc_spi_task_handle, dumper_task_handle, dft_task_handle;

esp_timer_handle_t periodic_timer;
spi_transaction_t transfer;
spi_device_handle_t spi;
//lets believe in this shit

uint8_t dev_id;

void periodic_timer_callback(void* arg);
void adc_spi_task(void *pvParameters);
void dumper_task(void *pvParameters);
void dft_task(void *pvParameters);
float mean(float* arr, int len);

#define SAMPLER_DUMP    "/" STRINGIFY(ROOM_ID) "/" STRINGIFY(DEVICE_ID) "/samplerDump"



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

	xTaskCreatePinnedToCore(adc_spi_task, "ADC", 1024 * 10, NULL, 6, &adc_spi_task_handle, tskNO_AFFINITY);

    if(TEST_SAMPLER)
	    xTaskCreate(dumper_task, "dumper", 1024 * 60, NULL, 6, &dumper_task_handle);

}

void sampler_mqttHandler(int commandId){

    switch (commandId)
    {

    case 0: // DUMP_DATA
        printf("Hello from sampler mqttHanlder - DUMP_DATA \n");
        xSemaphoreTake(xSemaphore_bigMeasurementQueue, portMAX_DELAY);                
        dump_command = 1;
        xSemaphoreGive(xSemaphore_bigMeasurementQueue);          

        break;

    case 1: // DETECT_DUMP_FALSE
        /* code */
        break;

    case 2: // DETECT_DUMP_TRUE
        /* code */
        break;                
    
    default:
        break;
    }
}

void dumper_task(void *pvParameters){
    for(;;){

        xSemaphoreTake(xSemaphore_smallMeasurementQueue, portMAX_DELAY);
        xSemaphoreTake(xSemaphore_bigMeasurementQueue, portMAX_DELAY);        

        while(!isMeasurementQueueEmpty(smallMeasurementQueue)){
            pushToMeasurementQueue(bigMeasurementQueue, popFromMeasurementQueue(smallMeasurementQueue));
        }

        if(dump_command == 1){
            dump_command = 0;

            int messageLength = getSizeOfMeasurementQueue(bigMeasurementQueue) * 10;
            char toSend[messageLength + 1];

            int i = 0;
            while(!isMeasurementQueueEmpty(bigMeasurementQueue)){
                
                Measurement * measurement = popFromMeasurementQueue(bigMeasurementQueue);
                
                char* timeStamp = (char*) &(measurement->timeStamp);
                char* voltage = (char*) &(measurement->voltage);

                for(int j = 0; j < 8; j++)
                    toSend[i * 10 + j] = timeStamp[j];
                
                for(int j = 0; j < 2; j++)
                    toSend[i * 10 + 8 + j] = voltage[j];

                free(measurement);  

                i++;
            }

            printf("Sending %d bytes, beholdd!!!\n", i * 10);


            esp_mqtt_client_publish(mqttC, SAMPLER_DUMP, toSend, messageLength, 1, 0); //(char*)mlx90640To, 0, 1, 0);


        }


        xSemaphoreGive(xSemaphore_smallMeasurementQueue);  
        xSemaphoreGive(xSemaphore_bigMeasurementQueue);          

        vTaskDelay( 1 / portTICK_PERIOD_MS);    
    }
}


void adc_spi_task(void *pvParameters){

	//vTaskSuspendAll();
    int i = 0;
    esp_err_t ret;
	int64_t now, prev = esp_timer_get_time();
	for(;;){
		now = esp_timer_get_time();

        uint16_t randomNumber = (uint16_t) esp_random();

        Measurement* fakeMeasurement = (Measurement*) calloc(1, sizeof(Measurement));
        fakeMeasurement->timeStamp = now;
        fakeMeasurement->voltage = randomNumber;


        xSemaphoreTake(xSemaphore_smallMeasurementQueue, portMAX_DELAY);
        pushToMeasurementQueue(smallMeasurementQueue, fakeMeasurement);
        xSemaphoreGive(xSemaphore_smallMeasurementQueue);

        uint64_t afterNow = esp_timer_get_time();
        if(afterNow - prev < 1/SAMPLING_RATE * 1000000){
            vTaskDelay( (1/SAMPLING_RATE  * 1000000 - (afterNow - prev))   / 1000.0 / portTICK_PERIOD_MS);
        }

/*         if(i % 1000 == 0)
            printf("Sampling rate = %f\n", 1.0/((esp_timer_get_time()-prev)/1000000.0) ); */


        prev = now;

        i++;

		//ret = spi_device_polling_transmit(spi, &transfer);

/* 		results[idx] = ((uint32_t)(receive[1]) << 2) + (receive[2] >> 6);
		frequencies[idx] = CLOCK_FREQ / (float)(now - prev);
		idx++; if(idx == DFT_RANGE) idx=0;
		prev = now;
		spi_counter++;
		xTaskNotifyGive(dft_task_handle); */


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

    float dftRegisterThreshold = 1200;
    int64_t dftRegisterInterval = 25000;
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
                     //printf("vuhuuvv adc you know\n");
                     //printf("dft is %f\n", dft);
                     //send_own_register(dev_id, currentTime);
                }
            }
            if(spi_counter % printInterval == 0)
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































