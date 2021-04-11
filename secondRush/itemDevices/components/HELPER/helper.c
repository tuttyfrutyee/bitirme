#include "helper.h"



int64_t globalDelta;

int dump_command;

esp_mqtt_client_handle_t mqttC;

SemaphoreHandle_t xSemaphore_smallMeasurementQueue;
SemaphoreHandle_t xSemaphore_bigMeasurementQueue;
MeasurementQueue * smallMeasurementQueue;
MeasurementQueue * bigMeasurementQueue;

SemaphoreHandle_t xSemaphore_windowQueue;
MeasurementQueue * windowQueue;

SemaphoreHandle_t xSemaphore_inButterQueue;
SemaphoreHandle_t xSemaphore_outButterQueue;
ButterQueue * inButterQueue;
ButterQueue * outButterQueue;




void initHelper(){

    dump_command = 0;
    
    xSemaphore_smallMeasurementQueue = xSemaphoreCreateBinary();    
    xSemaphoreGive(xSemaphore_smallMeasurementQueue);    
    smallMeasurementQueue = createMeasurementQueue(SMALL_QUEUE_SIZE);

    if(TEST_SAMPLER){
        xSemaphore_bigMeasurementQueue = xSemaphoreCreateBinary();    
        xSemaphoreGive(xSemaphore_bigMeasurementQueue);    
        bigMeasurementQueue = createMeasurementQueue(BIG_QUEUE_SIZE);
    }

    xSemaphore_windowQueue = xSemaphoreCreateBinary();    
    xSemaphoreGive(xSemaphore_windowQueue);    
    windowQueue = createMeasurementQueue(WINDOW_SIZE);

    xSemaphore_inButterQueue = xSemaphoreCreateBinary();    
    xSemaphoreGive(xSemaphore_inButterQueue);    
    xSemaphore_outButterQueue = xSemaphoreCreateBinary();    
    xSemaphoreGive(xSemaphore_outButterQueue);    

    inButterQueue = createButterQueue(BUTTER_FILTER_DEGREE);
    outButterQueue = createButterQueue(BUTTER_FILTER_DEGREE);

}