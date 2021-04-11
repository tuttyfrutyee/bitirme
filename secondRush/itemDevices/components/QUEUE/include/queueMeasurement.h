#ifndef MEASUREMENT_QUEUE
#define MEASUREMENT_QUEUE

#include <stdint.h>


typedef struct Measurement
{
    int64_t timeStamp;
    uint16_t voltage;
} Measurement;

typedef struct MeasurementQueue {

    int maxCapacity; // what ever this is set, actual maxCapacity will be maxCapacity - 1

    int front;
    int rear;

    Measurement ** queueBank;

} MeasurementQueue;


MeasurementQueue* createMeasurementQueue(int maxCapacity);

int isMeasurementQueueFull(MeasurementQueue* queue);

int isMeasurementQueueEmpty(MeasurementQueue* queue);

int pushToMeasurementQueue(MeasurementQueue* queue, Measurement* measurement);

int getSizeOfMeasurementQueue(MeasurementQueue* queue);

Measurement* popFromMeasurementQueue(MeasurementQueue* queue);

#endif