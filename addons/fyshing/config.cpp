
#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {"ACE_Fysh"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common", "ace_pike", "ace_loitering_munitions"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"gamingzeether"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "ACE_GuidanceConfig.hpp"
#include "CfgAmmo.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgMagazines.hpp"
#include "CfgMagazineWells.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
