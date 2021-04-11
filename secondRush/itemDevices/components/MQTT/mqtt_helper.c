#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
#include "freertos/queue.h"

#include "lwip/sockets.h"
#include "lwip/dns.h"
#include "lwip/netdb.h"

#include "esp_log.h"
#include "esp_event.h"
#include "tcpip_adapter.h"
#include "mqtt_client.h"
#include "mqtt_helper.h"
#include "string.h"

#include "helper.h"



static const char *TAG = "MQTT HELPER";

// EXTERN MQTT HANDLERS
extern void sampler_mqttHandler(int commandId);

#define SAMPLER_COMMAND_TOPIC    "/" STRINGIFY(ROOM_ID) "/" STRINGIFY(DEVICE_ID) "/samplerCommand"
#define SYNCH_TOPIC      "/" STRINGIFY(ROOM_ID) "/" STRINGIFY(DEVICE_ID-1) "/synch"


esp_err_t mqtt_event_handler_cb(esp_mqtt_event_handle_t event)
{
    esp_mqtt_client_handle_t client = event->client;
    int msg_id;
    // your_context_t *context = event->context;
    switch (event->event_id) {
        case MQTT_EVENT_CONNECTED:
            
            ESP_LOGI(TAG, "MQTT_EVENT_CONNECTED");

            // SAMPLER

            // connect to /room_id/device_id/sampler
            esp_mqtt_client_subscribe(client, SAMPLER_COMMAND_TOPIC, 0);            


            // SYNCHER
            if(DEVICE_ID > 0){
                esp_mqtt_client_subscribe(client, SYNCH_TOPIC, 0);
            }

            break;
        case MQTT_EVENT_DISCONNECTED:
            ESP_LOGI(TAG, "MQTT_EVENT_DISCONNECTED");
            vTaskDelay(400 / portTICK_PERIOD_MS);
            mqttStartASync(&mqtt_event_handler_cb);
            break;
        case MQTT_EVENT_SUBSCRIBED:
            ESP_LOGI(TAG, "MQTT_EVENT_SUBSCRIBED, msg_id=%d", event->msg_id);
            break;
        case MQTT_EVENT_UNSUBSCRIBED:
            ESP_LOGI(TAG, "MQTT_EVENT_UNSUBSCRIBED, msg_id=%d", event->msg_id);
            break;
        case MQTT_EVENT_PUBLISHED:
            ESP_LOGI(TAG, "MQTT_EVENT_PUBLISHED, msg_id=%d", event->msg_id);
            

            //ESP_LOGI(TAG, "sent publish successful, msg_id=%d", msg_id);                        
            break;
        case MQTT_EVENT_DATA:
            ESP_LOGI(TAG, "MQTT_EVENT_DATA");

            char topic[100];
            sprintf(topic, "%.*s", event->topic_len, event->topic);

            if(strcmp(topic, SAMPLER_COMMAND_TOPIC) == 0){
                char strCmd[5];
                sprintf(strCmd, "%.*s", event->data_len, event->data);
                sampler_mqttHandler(atoi(strCmd));
            }

            printf("TOPIC=%.*s\r\n", event->topic_len, event->topic);
            printf("DATA=%.*s\r\n", event->data_len, event->data);

            break;
        case MQTT_EVENT_ERROR:
            ESP_LOGI(TAG, "MQTT_EVENT_ERROR");
            break;
        default:               
            ESP_LOGI(TAG, "Other event id:%d", event->event_id);
            break;
    }
    return ESP_OK;
}


static void mqtt_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
    ESP_LOGD(TAG, "Event dispatched from event loop base=%s, event_id=%d", base, event_id);
    mqtt_event_handler_cb(event_data);
}

static esp_mqtt_client_handle_t mqtt_app_start(void)
{
    
    esp_mqtt_client_config_t mqtt_cfg = {
        .uri = BROKER_URL,
    };

    esp_mqtt_client_handle_t client = esp_mqtt_client_init(&mqtt_cfg);
    esp_mqtt_client_register_event(client, ESP_EVENT_ANY_ID, mqtt_event_handler, client);
    esp_mqtt_client_start(client);
    return client;
}

void mqttStartASync(){ //accepts a callback from main function to handlee mqtt events
    mqttC = mqtt_app_start();
}