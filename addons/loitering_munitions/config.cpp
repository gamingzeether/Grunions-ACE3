#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {QGVAR(Hero120_static)};
        weapons[] = {QGVAR(launch_Hero120)};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_missileguidance", "ace_csw", "ace_huntir"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"GamingZeether"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "ACE_GuidanceConfig.hpp"
#include "CfgAmmo.hpp"
#include "CfgGroups.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgMagazines.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "Dialog.hpp"
