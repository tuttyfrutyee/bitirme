#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "queueMeasurement.h"


MeasurementQueue* createMeasurementQueue(int maxCapacity){
    MeasurementQueue* willReturn = (MeasurementQueue*)calloc(1, sizeof(MeasurementQueue));
    
    willReturn->maxCapacity = maxCapacity;
    willReturn->front = 0;
    willReturn->rear = 0;
    willReturn->queueBank = (Measurement**) calloc(maxCapacity, sizeof(Measurement*));

    return willReturn;
}

int isMeasurementQueueFull(MeasurementQueue* queue){
    return ((queue->rear + 1) % queue->maxCapacity) == queue->front;
}

int isMeasurementQueueEmpty(MeasurementQueue* queue){
    return queue->rear == queue->front;
}

int pushToMeasurementQueue(MeasurementQueue* queue, Measurement* measurement){

    if(isMeasurementQueueFull(queue)){
        free((queue->queueBank)[queue->front]);
        queue->front = (queue->front + 1) % queue->maxCapacity;
    }


    (queue->queueBank)[queue->rear] = measurement;


    queue->rear = (queue->rear + 1) % queue->maxCapacity;


    return 1; 

}

int getSizeOfMeasurementQueue(MeasurementQueue* queue){
    if(queue->rear > queue->front)
        return queue->rear - queue->front;
    return queue->maxCapacity - (queue->front - queue->rear);
}


Measurement* popFromMeasurementQueue(MeasurementQueue* queue){
    if(isMeasurementQueueEmpty(queue)){
        printf("Error, queue is empty, can not pop anymore\n");
        return 0;
    }

    Measurement* willReturn = (queue->queueBank)[queue->front];

    queue->front = (queue->front + 1) % queue->maxCapacity;

    return willReturn;
}