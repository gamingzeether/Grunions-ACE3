#define COMPONENT gps
#include "\z\ace\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_GPS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_GPS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_GPS
#endif

#include "\z\ace\addons\main\script_macros.hpp"

#define MARKER_MIN_DISTANCE 30

#define TURN_STRAIGHT 0
#define TURN_LEFT 1
#define TURN_RIGHT 2

#define SPEEDWARN_NONE 0
#define SPEEDWARN_SLOW 1
#define SPEEDWARN_SLOWER 2
