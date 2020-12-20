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
#include "bluetoothh.h"

// FOR BLUETOOTH

/* Declare static functions */


// END FOR BLUETOOTH



// FOR I2C

#define IMUASSIGNEDPIN 14
#define flagActive 0 //this is flag related with ssDefaultAddr, it defines being pins active low or high.

// END FOR I2C




//FUNCTIONS

// FOR BLUETOOTH


// END FOR BLUETOOTH

// FOR I2C

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

// END FOR I2C

void app_main(void)
{

    // INITS
    float angleData = 0;
    initBluetoothAndStreamData(&angleData, sizeof(float));



    // I2C INITS
    initGpioForImuAndSelect(IMUASSIGNEDPIN);
    initI2C();    




    // FOR I2C AND IMU

    IMU* babyImu = (IMU*) malloc(sizeof(IMU));
    babyImu->assignedPin = IMUASSIGNEDPIN;
    vTaskDelay(300 / portTICK_PERIOD_MS);
    //selfTest();
    vTaskDelay(300 / portTICK_PERIOD_MS);

    setConfigurations();


    // ANGLE CALCULATION
    float angle = 0;
    int32_t startTime = esp_timer_get_time();
    while(1){
        Acceleration acc = getAccelerations();
        babyImu->imu.acc = acc;
        // printAccelerationData(babyImu->imu);
         double deltaTime = (esp_timer_get_time() - startTime) / 1000.0 / 1000.0;
         angle += deltaTime * acc.radAccY;
         startTime = esp_timer_get_time();
         //printf("angle : %f \n", angle);
    }

    


}
