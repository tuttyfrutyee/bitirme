#include "stackk.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"


SemaphoreHandle_t xSemaphore_angle = NULL;
SemaphoreHandle_t xSemaphore_register = NULL;


// FOR ANGLE
#define MAXCAPACITY_ANGLE 50 //actually max capacity is maxCapacity - 1
int front_angle = 0, rear_angle = 0;
AngleEl** queue_angle[MAXCAPACITY_ANGLE];

//queue functions

int isAngleQueueFull(){
    return ((rear_angle+1) % MAXCAPACITY_ANGLE) == front_angle;
}

int isAngleQueueEmpty(){
    return (rear_angle == front_angle);
}

int getAngleQueueSize(){
    int size = (rear_angle - front_angle);
    if(size < 0)
        size += MAXCAPACITY_ANGLE;
    return size;
}

int pushToAngleQueue(AngleEl* element){
    
    xSemaphoreTake(xSemaphore_angle, portMAX_DELAY);

    if(isAngleQueueFull()){
        printf("Error : Queue is full, can not push anymore\n");
        return 0;
    }

    queue_angle[rear_angle] = element;    

    rear_angle = (rear_angle + 1) % MAXCAPACITY_ANGLE;

    xSemaphoreGive(xSemaphore_angle);

    return 1;
}

AngleEl* popFromAngleQueue(){

    xSemaphoreTake(xSemaphore_angle, portMAX_DELAY);

    if(isAngleQueueEmpty()){
        printf("Error . Queue is empty, can not pop anymore\n");
        return 0;
    }

    AngleEl* willReturn = queue_angle[front_angle];

    front_angle = (front_angle + 1) % MAXCAPACITY_ANGLE;

    xSemaphoreGive(xSemaphore_angle);


    return willReturn;

}

// FOR REGISTER STACK
#define MAXCAPACITY_REGISTER 1000 //actually max capacity is maxCapacity - 1
int front_register = 0, rear_register = 0;
RegisterEl** queue_register[MAXCAPACITY_REGISTER];

// queue functions

int isRegisterQueueFull(){
    return ((rear_register+1) % MAXCAPACITY_REGISTER) == front_register;
}

int isRegisterQueueEmpty(){
    return (rear_register == front_register);
}

int getRegisterQueueSize(){
    int size = (rear_register - front_register);
    if(size < 0)
        size += MAXCAPACITY_REGISTER;
    return size;
}

int pushToRegisterQueue(RegisterEl* element){

    xSemaphoreTake(xSemaphore_register, portMAX_DELAY);

    
    if(isRegisterQueueFull()){
        printf("Error : Queue is full, can not push anymore\n");
        return 0;
    }

    queue_angle[rear_register] = element;    

    rear_register = (rear_register + 1) % MAXCAPACITY_REGISTER;

    xSemaphoreGive(xSemaphore_register);

    return 1;
}

RegisterEl* popFromRegisterQueue(){

    xSemaphoreTake(xSemaphore_register, portMAX_DELAY);


    if(isRegisterQueueEmpty()){
        printf("Error . Queue is empty, can not pop anymore\n");
        return 0;
    }

    RegisterEl* willReturn = queue_angle[front_register];

    front_register = (front_register + 1) % MAXCAPACITY_REGISTER;

    xSemaphoreGive(xSemaphore_register);
    

    return willReturn;

}

void initStackk(){
    xSemaphore_angle = xSemaphoreCreateBinary();    
    xSemaphore_register = xSemaphoreCreateBinary();        
}



