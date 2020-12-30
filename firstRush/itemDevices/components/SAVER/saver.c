#include "saver.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

int checkAngleStack = 0;
int checkRegisterStack = 0;

void saverMain(){

    while(1){

        if(checkAngleStack == 1){

            if(isAngleQueueFull()){
                
                while(!isAngleQueueEmpty()){
                    AngleEl* angleEl = popFromAngleQueue();
                    printf("$_%f_%d\n", angleEl->angle, angleEl->timeStamp);
                    free(angleEl);
                }

            }
            

            checkAngleStack = 0;
        }
        else if(checkRegisterStack == 1){

            if(isRegisterQueueFull()){

                

            }            

            checkRegisterStack = 0;
        }
        else
            vTaskDelay(10 / portTICK_RATE_MS);
        


    }

}

void saveAngle(float angle, int64_t timeStamp){
    AngleEl *el = malloc(sizeof(AngleEl));
    el->angle = angle;
    el->timeStamp = timeStamp;
    pushToAngleQueue(el);
    checkAngleStack = 1;
}

void saveRegister(int64_t timeStamp, uint8_t itemId, float freq){
    RegisterEl *el = malloc(sizeof(RegisterEl));
    el->itemId = itemId;
    el->freq = freq;
    el->timeStamp = timeStamp;
    pushToRegisterQueue(el);
    checkRegisterStack = 1;
}


void startSaver(){
    xTaskCreatePinnedToCore(saverMain, "saverMain", 4096 * 2, NULL, 1, NULL, 0);
}

