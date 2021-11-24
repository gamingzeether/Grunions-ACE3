class CfgWeapons {
    class HMG_127;
    class HMG_01: HMG_127 {
        magazines[] += { "ace_csw_50Rnd_127x108_mag", "ace_csw_100Rnd_127x99_mag_yellow", "ace_csw_100Rnd_127x99_mag_red", "ace_csw_100Rnd_127x99_mag_green", "ace_csw_100Rnd_127x99_mag" };
    };
    class HMG_M2: HMG_01 {
        magazines[] += { "ace_csw_50Rnd_127x108_mag", "ace_csw_100Rnd_127x99_mag_yellow", "ace_csw_100Rnd_127x99_mag_red", "ace_csw_100Rnd_127x99_mag_green", "ace_csw_100Rnd_127x99_mag" };
    };
    class GMG_F;
    class GMG_20mm: GMG_F {
        magazines[] += { "ace_csw_20Rnd_20mm_G_belt" };
    };
    class CannonCore;
    class mortar_82mm: CannonCore {
        magazines[] += { "ACE_1Rnd_82mm_Mo_HE", "ACE_1Rnd_82mm_Mo_HE_Guided", "ACE_1Rnd_82mm_Mo_HE_LaserGuided", "ACE_1Rnd_82mm_Mo_Illum", "ACE_1Rnd_82mm_Mo_Smoke" };
    };
    
    class Launcher_Base_F;
    class ace_csw_staticGMGCarry: Launcher_Base_F {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticHGMG_Icon.paa);
        GVAR(weapon) = "GMG_20mm";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 1.3;
    };
    class ace_csw_staticHMGCarry: Launcher_Base_F {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticHGMG_Icon.paa);
        GVAR(weapon) = "HMG_01";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 1.1;
    };
    class ace_csw_staticM2ShieldCarry: ace_csw_staticHMGCarry {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticHGMG_Icon.paa);
        GVAR(weapon) = "HMG_M2";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 1.1;
    };
    class ace_csw_staticMortarCarry: Launcher_Base_F {
        GVAR(enabled) = 1;
        GVAR(picture) = QPATHTOEF(csw,UI\StaticMortarTube_Icon.paa);
        GVAR(weapon) = "mortar_82mm";
        GVAR(model) = "\A3\Weapons_F\LongRangeRifles\GM6\GM6_F.p3d";
        GVAR(scale) = 2;
    };
};
