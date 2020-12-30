#include "esp_system.h"

typedef struct AngleEl {

    int32_t timeStamp;
    float angle; // 0 : low, 1 : high

} AngleEl;

int isAngleQueueFull();
int isAngleQueueEmpty();
int getAngleQueueSize();
int pushToAngleQueue(AngleEl* element);
AngleEl* popFromAngleQueue();


//STACK FOR REGISTER DATA


typedef struct RegisterEl {

    int32_t timeStamp;
    uint8_t itemId; // 0, 1, 2
    float freq; // identifier frequency

} RegisterEl;

int isRegisterQueueFull();
int isRegisterQueueEmpty();
int getRegisterQueueSize();
int pushToRegisterQueue(AngleEl* element);
AngleEl* popFromRegisterQueue();