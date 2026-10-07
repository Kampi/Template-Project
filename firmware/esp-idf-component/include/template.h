#ifndef ${GIT_REPO_UPPER}_H_
#define ${GIT_REPO_UPPER}_H_

#include <esp_err.h>

#ifdef __cplusplus
extern "C" {
#endif

/** @brief  Initialize the component.
 *  @return ESP_OK when successful
 */
esp_err_t ${GIT_REPO_LOWER}_init(void);

/** @brief  Get the version of the component.
 *  @return Version as string "major.minor.build"
 */
const char *${GIT_REPO_LOWER}_get_version(void);

#ifdef __cplusplus
}
#endif

#endif /* ${GIT_REPO_UPPER}_H_ */
