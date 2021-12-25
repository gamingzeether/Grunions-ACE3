class CfgWeapons {
    class MissileLauncher;
    class GVAR(launch_Hero120): MissileLauncher {
        scope = 2;
        displayName = CSTRING(Hero120_displayName);
        magazines[] = { QGVAR(1Rnd_Hero120) };
        
        sounds[] = {"StandardSound"};
        class StandardSound {
            soundSetShot[] = {"Static_Launcher_Titan_ATAA_Shot_SoundSet","Static_Launcher_Titan_ATAA_Tail_SoundSet"};
        };
    };
    
    class EGVAR(csw,staticATCarry);
    class GVAR(carry_Hero120): EGVAR(csw,staticATCarry) {
        displayName = CSTRING(Hero120_carry_displayName);
        
        class ace_csw {
            type = "weapon";
            deployTime = 15;
            pickupTime = 20;
            class assembleTo {
                EGVAR(csw,mortarBaseplate) = QGVAR(Hero120_static);
            };
        };
    };
};
