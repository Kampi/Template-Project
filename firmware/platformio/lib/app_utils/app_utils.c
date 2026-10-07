#include "app_utils.h"

uint32_t AppUtils_Clamp(uint32_t Value, uint32_t Min, uint32_t Max)
{
    if (Value < Min) {
        return Min;
    }

    if (Value > Max) {
        return Max;
    }

    return Value;
}
