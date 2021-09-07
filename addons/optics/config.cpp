#include "script_component.hpp"

#pragma hemtt flag pe23_ignore_has_include
#if __has_include("\z\ace\addons\norealisticnames\script_component.hpp")
#define PATCH_SKIP "No Optics"
#endif

#ifdef PATCH_SKIP
ACE_PATCH_NOT_LOADED(ADDON,PATCH_SKIP)
#else


class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {
            "ACE_optic_Hamr_2D",
            "ACE_optic_Hamr_PIP",
            "ACE_optic_Arco_2D",
            "ACE_optic_Arco_PIP",
            "ACE_optic_MRCO_2D",
            //"ACE_optic_MRCO_PIP",
            "ACE_optic_SOS_2D",
            "ACE_optic_SOS_PIP",
            "ACE_optic_LRPS_2D",
            "ACE_optic_LRPS_PIP"
            //"ACE_optic_DMS"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"Taosenai","KoffeinFlummi","commy2"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

#include "CfgOpticsEffect.hpp"
#include "CfgRscTitles.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "CfgJointRails.hpp"

#include "CfgPreloadTextures.hpp"

#endif
