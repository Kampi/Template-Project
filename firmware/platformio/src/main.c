#include <stdbool.h>
#include <stdint.h>

#include <esp_log.h>

#include <freertos/FreeRTOS.h>
#include <freertos/task.h>

#include <app_utils.h>

#include "main.h"

static const char *TAG = "main";

// cppcheck-suppress unusedFunction
void app_main(void)
{
    uint32_t Counter = 0;

    ESP_LOGI(TAG, "Firmware started");

    while (true) {
        Counter = AppUtils_Clamp(Counter + 1, 0, 100);
        ESP_LOGI(TAG, "Counter: %u", (unsigned int)Counter);

        vTaskDelay(pdMS_TO_TICKS(MAIN_LOOP_PERIOD_MS));
    }
}
