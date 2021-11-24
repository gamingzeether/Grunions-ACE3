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
        GVAR(mountingPositions)[] = { {0.5,0.7,-0.3} };
        unitInfoType = "RscUnitInfoTank";
    };
    
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
