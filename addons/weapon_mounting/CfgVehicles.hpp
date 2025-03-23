#define MACRO_ATTACH_WEAPON \
class ACE_Actions { \
    class ACE_MainActions { \
        class GVAR(mountWeapon) { \
            displayName = CSTRING(mountAction_displayName); \
            condition = QUOTE(true); \
            insertChildren = QUOTE(_this call FUNC(mountWeaponActions)); \
            icon = ""; \
        }; \
    }; \
};

class CfgVehicles {
    class LandVehicle;
    class Car: LandVehicle {
        MACRO_ATTACH_WEAPON
    };
    class Car_F;
    class Quadbike_01_base_F: Car_F {
        GVAR(mountingPositions)[] = { {0.5,1,-0.3} };
        unitInfoType = "RscUnitInfoTank";
        GVAR(aimRestrictions)[] = { 0, 10, 45, 35 };
        GVAR(controller) = "driver";
        GVAR(turret)[] = {-1};
        GVAR(launchersAllowed) = 0;
    };
    class Kart_01_Base_F: Car_F {
        GVAR(mountingPositions)[] = { {0, 1, -0.5} };
        unitInfoType = "RscUnitInfoTank";
        GVAR(aimRestrictions)[] = { 0, 10, 45, 35 };
        GVAR(controller) = "driver";
        GVAR(turret)[] = {-1};
        GVAR(launchersAllowed) = 0;
    };
    class StaticWeapon: LandVehicle {
        MACRO_ATTACH_WEAPON
    };
    class Static_Designator_01_base_F: StaticWeapon {
        GVAR(mountingPositions)[] = { {0.2,0,0.1} };
        GVAR(aimRestrictions)[] = { 0, 0, -1, -1 };
        GVAR(controller) = "GUNNER";
        GVAR(turret)[] = {0};
        GVAR(launchersAllowed) = 0;
        GVAR(memPoint) = "maingun";
    };
    
    class Air;
    class Helicopter: Air {
        MACRO_ATTACH_WEAPON
    };
    class Helicopter_Base_F;
    class UAV_01_base_F: Helicopter_Base_F {
        GVAR(mountingPositions)[] = { {0,0,-0.3} };
        GVAR(aimRestrictions)[] = { 0, -45, -1, 50 };
        GVAR(controller) = "GUNNER";
        GVAR(turret)[] = {0};
        GVAR(launchersAllowed) = 1;
    };
    
    // CSW bags
    class Weapon_Bag_Base;
    class B_HMG_01_weapon_F: Weapon_Bag_Base {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticHGMG_Icon.paa);
        GVAR(weapon) = "HMG_01";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 1.1;
    };
    class B_HMG_01_high_weapon_F;
    class B_HMG_02_high_weapon_F: Weapon_Bag_Base {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticHGMG_Icon.paa);
        GVAR(weapon) = "HMG_M2";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 1.1;
    };
    class B_HMG_02_weapon_F: Weapon_Bag_Base {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticHGMG_Icon.paa);
        GVAR(weapon) = "HMG_M2";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 1.1;
    };
    class B_GMG_01_A_weapon_F: B_HMG_01_weapon_F {
        GVAR(weapon) = "GMG_20mm";
        GVAR(scale) = 1.3;
    };
    class B_GMG_01_high_weapon_F: B_HMG_01_high_weapon_F {
        GVAR(weapon) = "GMG_20mm";
        GVAR(scale) = 1.3;
    };
    class B_GMG_01_weapon_F: B_HMG_01_weapon_F {
        GVAR(weapon) = "GMG_20mm";
        GVAR(scale) = 1.3;
    };
    class B_Mortar_01_weapon_F: Weapon_Bag_Base {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticMortarTube_Icon.paa);
        GVAR(weapon) = "mortar_82mm";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 2;
    };
};
