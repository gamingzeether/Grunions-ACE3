#include "script_component.hpp"

#pragma hemtt flag pe23_ignore_has_include
#if __has_include("\z\ace\addons\grunionstweaks\script_component.hpp")
#define PATCH_SKIP "No Advanced Fatigue"
#endif

#ifdef PATCH_SKIP
ACE_PATCH_NOT_LOADED(ADDON,PATCH_SKIP)
#else

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"BaerMitUmlaut"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "ACE_Settings.hpp"
#include "CfgEden.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgMovesMaleSdr.hpp"
#include "CfgSounds.hpp"
#include "CfgVehicles.hpp"
#include "Dialog.hpp"

#endif
