#define COMPONENT weapon_mounting
#include "\z\ace\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS
// #define DRAW_AIM_DIR

#ifdef DEBUG_ENABLED_WEAPON_MOUNTING
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_FYSHING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_WEAPON_MOUNTING
#endif

#include "\z\ace\addons\main\script_macros.hpp"

#define WEAPONMOUNTING_TYPE_FAIL -1
#define WEAPONMOUNTING_TYPE_LAUNCHER 0
#define WEAPONMOUNTING_TYPE_BACKPACK 1
