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

#include "bluetoothh.h"
#include "saver.h"
#include "sampler.h"
#include "wired.h"

#define DEV_ID 0

void app_main(void)
{
    init_sampler();
    init_wired(DEV_ID);
    if(DEV_ID == 0) {
        initBluetoothAndStartRecieve();
        startSaver();
    }
    startSampler(DEV_ID);
    printf("started Sampler \n");
}
