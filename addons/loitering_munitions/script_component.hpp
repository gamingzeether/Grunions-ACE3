#define COMPONENT loitering_munitions
#define COMPONENT_BEAUTIFIED Loitering Munitions
#include "\z\ace\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_LOITERING_MUNITIONS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_LOITERING_MUNITIONS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOITERING_MUNITIONS
#endif

#include "\z\ace\addons\main\script_macros.hpp"

#define STATE_GAINALT 0
#define STATE_LOITER  1
#define STATE_ATTACK  2
