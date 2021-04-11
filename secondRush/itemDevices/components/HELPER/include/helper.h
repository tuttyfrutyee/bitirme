#ifndef HELPER
#define HELPER




#include "queueButter.h"
#include "queueMeasurement.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
#include "mqtt_client.h"

// GENERAL

#define STRINGIFY2(X) #X
#define STRINGIFY(X) STRINGIFY2(X)

#define DEVICE_ID 0
#define ROOM_ID 0

void initHelper();

// CONTROL 

#define TEST_SAMPLER 1
#define TEST_SYNCHER 0

extern int dump_command;

// SAMPLER
#define SAMPLING_RATE 30000.0

// MQTT
#define BROKER_URL "mqtt://192.168.1.32"
extern esp_mqtt_client_handle_t mqttC;

// SYNC

extern int64_t globalDelta;

// QUEUES 

#define SMALL_QUEUE_SIZE 100
#define BIG_QUEUE_SIZE 3000
extern SemaphoreHandle_t xSemaphore_smallMeasurementQueue;
extern SemaphoreHandle_t xSemaphore_bigMeasurementQueue;
extern MeasurementQueue * smallMeasurementQueue;
extern MeasurementQueue * bigMeasurementQueue;


#define WINDOW_SIZE 20
extern SemaphoreHandle_t xSemaphore_windowQueue;
extern MeasurementQueue * windowQueue;


#define BUTTER_FILTER_DEGREE 10
extern SemaphoreHandle_t xSemaphore_inButterQueue;
extern SemaphoreHandle_t xSemaphore_outButterQueue;
extern ButterQueue * inButterQueue;
extern ButterQueue * outButterQueue;


#endif