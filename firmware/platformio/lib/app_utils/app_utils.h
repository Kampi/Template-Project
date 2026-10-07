#ifndef APP_UTILS_H_
#define APP_UTILS_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/** @brief          Limit a value to a range.
 *  @param Value    Input value
 *  @param Min      Lower limit
 *  @param Max      Upper limit
 *  @return         Value limited to [Min, Max]
 */
uint32_t AppUtils_Clamp(uint32_t Value, uint32_t Min, uint32_t Max);

#ifdef __cplusplus
}
#endif

#endif /* APP_UTILS_H_ */
