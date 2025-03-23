#include "script_component.hpp"

#pragma hemtt flag pe23_ignore_has_include
#if __has_include("\z\ace\addons\grunionstweaks\script_component.hpp")
#define PATCH_SKIP "No Nightvision"
#endif

#ifdef PATCH_SKIP
ACE_PATCH_NOT_LOADED(ADDON,PATCH_SKIP)
#else

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {
            "ACE_NVG_Gen1",
            "ACE_NVG_Gen1_Brown",
            "ACE_NVG_Gen1_Green",
            "ACE_NVG_Gen2_Black",
            "ACE_NVG_Gen2_Brown",
            "ACE_NVG_Gen2",
            /*"ACE_NVG_Gen3",*/
            "ACE_NVG_Gen4_Black",
            "ACE_NVG_Gen4_Black_WP",
            "ACE_NVG_Gen4",
            "ACE_NVG_Gen4_WP",
            "ACE_NVG_Gen4_Green",
            "ACE_NVG_Gen4_Green_WP",
            "ACE_NVG_Wide_Black",
            "ACE_NVG_Wide",
            "ACE_NVG_Wide_Green"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"commy2", "KoffeinFlummi", "PabstMirror"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgIRLaserSettings.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "ACE_Settings.hpp"
#include "RscTitles.hpp"
#include "ACE_Arsenal_Stats.hpp"

#endif
