#ifndef BUTTER_QUEUE
#define BUTTER_QUEUE

#include <stdint.h>


typedef struct Butter
{
    int64_t timeStamp;
    float value;
} Butter;

typedef struct ButterQueue {

    int maxCapacity; // what ever this is set, actual maxCapacity will be maxCapacity - 1

    int front;
    int rear;

    Butter ** queueBank;

} ButterQueue;


ButterQueue* createButterQueue(int maxCapacity);

int isButterQueueFull(ButterQueue* queue);

int isButterQueueEmpty(ButterQueue* queue);

int pushToButterQueue(ButterQueue* queue, Butter* butter);

int getSizeOfButterQueue(ButterQueue* queue);

Butter* popFromButterQueue(ButterQueue* queue);

#endif