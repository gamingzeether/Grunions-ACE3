#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = { QGVAR(airhammer) };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"gamingzeether"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgWeapons.hpp"
