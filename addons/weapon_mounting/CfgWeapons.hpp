class CfgWeapons {
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
