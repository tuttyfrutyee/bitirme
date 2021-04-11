#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "queueButter.h"


ButterQueue* createButterQueue(int maxCapacity){
    ButterQueue* willReturn = (ButterQueue*)calloc(1, sizeof(ButterQueue));
    
    willReturn->maxCapacity = maxCapacity;
    willReturn->front = 0;
    willReturn->rear = 0;
    willReturn->queueBank = (Butter**) calloc(maxCapacity, sizeof(Butter*));

    return willReturn;
}

int isButterQueueFull(ButterQueue* queue){
    return ((queue->rear + 1) % queue->maxCapacity) == queue->front;
}

int isButterQueueEmpty(ButterQueue* queue){
    return queue->rear == queue->front;
}

int pushToButterQueue(ButterQueue* queue, Butter* butter){

    if(isButterQueueFull(queue)){
        free((queue->queueBank)[queue->front]);
        queue->front = (queue->front + 1) % queue->maxCapacity;
    }


    (queue->queueBank)[queue->rear] = butter;


    queue->rear = (queue->rear + 1) % queue->maxCapacity;


    return 1; 

}

int getSizeOfButterQueue(ButterQueue* queue){
    if(queue->rear > queue->front)
        return queue->rear - queue->front;
    return queue->maxCapacity - (queue->front - queue->rear);
}


Butter* popFromButterQueue(ButterQueue* queue){
    if(isButterQueueEmpty(queue)){
        printf("Error, butter queue is empty, can not pop anymore\n");
        return 0;
    }

    Butter* willReturn = (queue->queueBank)[queue->front];

    queue->front = (queue->front + 1) % queue->maxCapacity;

    return willReturn;
}