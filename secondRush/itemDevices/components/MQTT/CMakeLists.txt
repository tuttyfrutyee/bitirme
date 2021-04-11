idf_component_register(SRCS "mqtt_helper.c" "wifi_helper.c"
                  INCLUDE_DIRS "include"
                  REQUIRES "nvs_flash" "mqtt" HELPER)