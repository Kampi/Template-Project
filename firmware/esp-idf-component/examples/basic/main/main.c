#include <esp_err.h>
#include <esp_log.h>

#include <${GIT_REPO_LOWER}.h>

static const char *TAG = "main";

void app_main(void)
{
    ESP_ERROR_CHECK(${GIT_REPO_LOWER}_init());

    ESP_LOGI(TAG, "Component version: %s", ${GIT_REPO_LOWER}_get_version());
}
