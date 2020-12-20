/* Hello World Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/
#include <stdio.h>
#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "esp_spi_flash.h"

#include "driver/gpio.h"

#include "acceleration.h"
#include "mpu6050.h"
#include "i2c.h"
#include "i2c_imu.h"
#include "mpu6050.h"
#include "imugather.h"

#define IMUASSIGNEDPIN 14
#define flagActive 0 //this is flag related with ssDefaultAddr, it defines being pins active low or high.


void initGpioForImuAndSelect(int targetAssignedPin){

        gpio_pad_select_gpio(IMUASSIGNEDPIN);
        gpio_set_direction(IMUASSIGNEDPIN, GPIO_MODE_OUTPUT);
        gpio_set_level(IMUASSIGNEDPIN, flagActive);        
}

void initI2C(){
    int ret;
    ret = i2c_master_init(300000);
    if(ret == ESP_OK)
        printf("i2c is init well\n");
    else
        printf("something went wrong with i2c init\n");    
}

void app_main(void)
{
    initGpioForImuAndSelect(IMUASSIGNEDPIN);

    initI2C();

    IMU* babyImu = (IMU*) malloc(sizeof(IMU));
    babyImu->assignedPin = IMUASSIGNEDPIN;
    vTaskDelay(300 / portTICK_PERIOD_MS);
    //selfTest();
    vTaskDelay(300 / portTICK_PERIOD_MS);

    setConfigurations();

    float angle = 0;
    int32_t startTime = esp_timer_get_time();
    while(1){
        Acceleration acc = getAccelerations();
        babyImu->imu.acc = acc;
        // printAccelerationData(babyImu->imu);
         double deltaTime = (esp_timer_get_time() - startTime) / 1000.0 / 1000.0;
         angle += deltaTime * acc.radAccY;
         startTime = esp_timer_get_time();
         printf("angle : %f \n", angle);
    }


    printf("Hello world!\n");

    /* Print chip information */
    esp_chip_info_t chip_info;
    esp_chip_info(&chip_info);
    printf("This is %s chip with %d CPU cores, WiFi%s%s, ",
            CONFIG_IDF_TARGET,
            chip_info.cores,
            (chip_info.features & CHIP_FEATURE_BT) ? "/BT" : "",
            (chip_info.features & CHIP_FEATURE_BLE) ? "/BLE" : "");

    printf("silicon revision %d, ", chip_info.revision);

    printf("%dMB %s flash\n", spi_flash_get_chip_size() / (1024 * 1024),
            (chip_info.features & CHIP_FEATURE_EMB_FLASH) ? "embedded" : "external");

    printf("Minimum free heap size: %d bytes\n", esp_get_minimum_free_heap_size());

    for (int i = 10; i >= 0; i--) {
        printf("Restarting in %d seconds...\n", i);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
    printf("Restarting now.\n");
    fflush(stdout);
    esp_restart();
}
