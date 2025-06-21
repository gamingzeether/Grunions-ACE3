#define COMPONENT zeeth_experimental
#include "\z\ace\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_APR_FOOLS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ZEETH_EXPERIMENTAL
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ZEETH_EXPERIMENTAL
#endif

#include "\z\ace\addons\main\script_macros.hpp"

#define SMARTPISTOL_CONE 0.5
#define SMARTPISTOL_LOCKTHRESHOLD 1
#define SMARTPISTOL_LOCKDISTANCE 150

#define JETPACK_STRAFESPEED 4
#define JETPACK_READYCOLOR 0.2, 0.8, 0.8, 0.8
#define JETPACK_COOLDOWNCOLOR 0.3, 0.8, 0.5, 0.8
