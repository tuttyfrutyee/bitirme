#include "driver/gpio.h"
#include "driver/uart.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "saver.h"
#include "string.h"

#define ESP_INTR_FLAG_DEFAULT 0

#define UART_1    UART_NUM_1
#define UART_1_RX GPIO_NUM_16
#define UART_1_TX GPIO_NUM_17

#define UART_2    UART_NUM_2
#define UART_2_RX GPIO_NUM_21
#define UART_2_TX GPIO_NUM_22

#define INT_OUT   GPIO_NUM_18
#define INT_IN    GPIO_NUM_19

#define ESP_INTR_FLAG_DEFAULT 0
#define PACKAGE_LEN   9

static const int RX_BUF_SIZE = 1024;

int64_t delta_time;
static xQueueHandle gpio_evt_queue = NULL;

static void gpio_task_example(void* arg);
void forward_register_up(char* data, uint32_t len);
void listen_register_down(int dev_id);
static void IRAM_ATTR gpio_isr_handler(void* arg);
static void gpio_task_example(void* arg);

void init_syncher(int dev_id){

    // common to all
    uart_config_t uart_config = {
        .baud_rate = 115200,
        .data_bits = UART_DATA_8_BITS,
        .parity = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
        .source_clk = UART_SCLK_APB,
    };

    switch (dev_id)
    {
    gpio_config_t io_conf;
    // MASTER DEVICE
    case 0:
        uart_driver_install(UART_1, RX_BUF_SIZE * 2, 0, 0, NULL, 0);
        uart_param_config(UART_1, &uart_config);
        uart_set_pin(UART_1, UART_1_TX, UART_1_RX, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
        
        //disable interrupt
        io_conf.intr_type = GPIO_PIN_INTR_DISABLE;
        //set as output mode
        io_conf.mode = GPIO_MODE_OUTPUT;
        //bit mask of the pins that you want to set,e.g.GPIO18/19
        io_conf.pin_bit_mask = (1ULL << INT_OUT);
        //disable pull-down mode
        io_conf.pull_down_en = 0;
        //disable pull-up mode
        io_conf.pull_up_en = 0;
        //configure GPIO with the given settings
        gpio_config(&io_conf);
        break;
    
    // MIDDLE DEVICE
    case 1:
        uart_driver_install(UART_1, RX_BUF_SIZE * 2, 0, 0, NULL, 0);
        uart_param_config(UART_1, &uart_config);
        uart_set_pin(UART_1, UART_1_TX, UART_1_RX, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
        
        uart_driver_install(UART_2, RX_BUF_SIZE * 2, 0, 0, NULL, 0);
        uart_param_config(UART_2, &uart_config);
        uart_set_pin(UART_2, UART_2_TX, UART_2_RX, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
        
        //disable interrupt
        io_conf.intr_type = GPIO_PIN_INTR_DISABLE;
        //set as output mode
        io_conf.mode = GPIO_MODE_OUTPUT;
        //bit mask of the pins that you want to set,e.g.GPIO18/19
        io_conf.pin_bit_mask = (1ULL << INT_OUT);
        //disable pull-down mode
        io_conf.pull_down_en = 0;
        //disable pull-up mode
        io_conf.pull_up_en = 0;
        //configure GPIO with the given settings
        gpio_config(&io_conf);

        io_conf.intr_type = GPIO_PIN_INTR_POSEDGE;
        //bit mask of the pins, use GPIO here
        io_conf.pin_bit_mask = (1ULL << INT_IN);
        //set as input mode
        io_conf.mode = GPIO_MODE_INPUT;
        //enable pull-up mode
        io_conf.pull_up_en = 1;
        io_conf.pull_down_en = 0;
        gpio_config(&io_conf);
        //install gpio isr service
        gpio_install_isr_service(ESP_INTR_FLAG_DEFAULT);
        //hook isr handler for specific gpio pin
        gpio_isr_handler_add(INT_IN, gpio_isr_handler, (void*) INT_IN);
        gpio_evt_queue = xQueueCreate(10, sizeof(int64_t));
        break;

    // TAIL DEVICE
    case 2:
        uart_driver_install(UART_1, RX_BUF_SIZE * 2, 0, 0, NULL, 0);
        uart_param_config(UART_1, &uart_config);
        uart_set_pin(UART_1, UART_1_TX, UART_1_RX, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
                
        io_conf.intr_type = GPIO_PIN_INTR_POSEDGE;
        //bit mask of the pins, use GPIO here
        io_conf.pin_bit_mask = (1ULL << INT_IN);
        //set as input mode
        io_conf.mode = GPIO_MODE_INPUT;
        //enable pull-up mode
        io_conf.pull_up_en = 1;
        io_conf.pull_down_en = 0;
        gpio_config(&io_conf);
        //install gpio isr service
        gpio_install_isr_service(ESP_INTR_FLAG_DEFAULT);
        //hook isr handler for specific gpio pin
        gpio_isr_handler_add(INT_IN, gpio_isr_handler, (void*) INT_IN);
        gpio_evt_queue = xQueueCreate(10, sizeof(int64_t));       
        break;

    default:
        break;
    }
}

void start_syncher(int dev_id){
    int64_t time;
    switch (dev_id)
    {
    case 0:
        for(;;){
            gpio_set_level(INT_OUT, 0);
            vTaskDelay(500 / portTICK_RATE_MS);
            time = esp_timer_get_time();
		    uart_write_bytes(UART_1, (const char*)(&time), sizeof(time));
            gpio_set_level(INT_OUT, 1);
            vTaskDelay(500 / portTICK_RATE_MS);
        }
        break;

    case 1:
        break;
    
    case 2:
        break;

    default:
        break;
    }
}


void forward_register_up(char* data, uint32_t len) {
    uart_write_bytes(UART_1, data, len);
}

void listen_register_down(int dev_id){
    uint8_t package[PACKAGE_LEN];
    int64_t temp_time;
    switch (dev_id)
    {
    case 0:
        for(;;){
            uart_read_bytes(UART_1, package, PACKAGE_LEN, portMAX_DELAY);
            saveRegister( *(int64_t*)(&(package[1])), package[0], 20000);
        }
        break;

    case 1:
        for(;;){
            uart_read_bytes(UART_2, package, PACKAGE_LEN, portMAX_DELAY);
            temp_time = *(int64_t*)(package + 1);
            temp_time += delta_time;
            memcpy(package + 1, (const char*)(&temp_time), sizeof(int64_t));
            forward_register_up((char*)(package), PACKAGE_LEN);
        }
        break;
    
    default:
        break;
    }
}

static void IRAM_ATTR gpio_isr_handler(void* arg) {
	int64_t time = esp_timer_get_time();
	gpio_intr_disable(INT_IN);
	BaseType_t higher = pdFALSE;
    xQueueSendFromISR(gpio_evt_queue, &time, &higher);
    if(higher == pdTRUE) portYIELD_FROM_ISR();
}

static void gpio_task_example(void* arg) {
    int64_t int_time, upper_time;
    for(;;) {
        xQueueReceive(gpio_evt_queue, &int_time, portMAX_DELAY);
        uart_read_bytes(UART_1, (uint8_t *)(&upper_time), sizeof(int64_t), portMAX_DELAY);
        delta_time = upper_time - int_time;
    	gpio_intr_enable(INT_IN);
    }
}

void send_own_register(uint8_t dev_id, int64_t time) {
    if(dev_id != 0) {
        char package[PACKAGE_LEN];
        time += delta_time;
        package[0] = dev_id;
        memcpy(package + 1, (const char*)(&time), sizeof(int64_t));
        forward_register_up(package, PACKAGE_LEN);
    }
    else {
        saveRegister(time, dev_id, 20000 );
    }
}





















