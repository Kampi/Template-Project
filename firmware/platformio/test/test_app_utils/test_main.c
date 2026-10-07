#include <unity.h>

#include <app_utils.h>

void setUp(void)
{
}

void tearDown(void)
{
}

static void test_clamp_inside_range(void)
{
    TEST_ASSERT_EQUAL_UINT32(5, AppUtils_Clamp(5, 0, 10));
}

static void test_clamp_below_range(void)
{
    TEST_ASSERT_EQUAL_UINT32(2, AppUtils_Clamp(1, 2, 10));
}

static void test_clamp_above_range(void)
{
    TEST_ASSERT_EQUAL_UINT32(10, AppUtils_Clamp(11, 0, 10));
}

int main(void)
{
    UNITY_BEGIN();

    RUN_TEST(test_clamp_inside_range);
    RUN_TEST(test_clamp_below_range);
    RUN_TEST(test_clamp_above_range);

    return UNITY_END();
}
