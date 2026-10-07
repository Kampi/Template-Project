#include <esp_log.h>

#include "${GIT_REPO_LOWER}.h"

#define STRINGIFY_(Value)   #Value
#define STRINGIFY(Value)    STRINGIFY_(Value)

static const char *TAG = "${GIT_REPO_LOWER}";

esp_err_t ${GIT_REPO_LOWER}_init(void)
{
    ESP_LOGI(TAG, "Initialize version %s", ${GIT_REPO_LOWER}_get_version());

    return ESP_OK;
}

const char *${GIT_REPO_LOWER}_get_version(void)
{
    return STRINGIFY(${GIT_REPO_UPPER}_LIB_MAJOR) "." STRINGIFY(${GIT_REPO_UPPER}_LIB_MINOR) "."
           STRINGIFY(${GIT_REPO_UPPER}_LIB_BUILD);
}
