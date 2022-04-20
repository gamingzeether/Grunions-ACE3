
#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {"ACE_Fysh"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common", "ace_pike"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"gamingzeether"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgAmmo.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgMagazines.hpp"
#include "CfgMagazineWells.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
