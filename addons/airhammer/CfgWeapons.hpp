class CfgWeapons {
    class gatling_20mm;
    class Twin_Cannon_20mm: gatling_20mm {
        class manual;
    };
    
    class GVAR(airhammer): Twin_Cannon_20mm {
        displayName = CSTRING(weapon_displayName);
        magazines[] = { QGVAR(100Rnd_mag) };
        
        class manual: manual {
            reloadTime = 1;
            displayName = CSTRING(weapon_displayName);
            magazines[] = { QGVAR(100Rnd_mag) };
            soundContinuous = 0;
            class StandardSound {
                begin1[] = { "A3\Sounds_F\arsenal\weapons\UGL\UGL_01", 3, 1, 200 };
                begin2[] = { "A3\Sounds_F\arsenal\weapons\UGL\UGL_02", 3, 1, 200 };
                soundBegin[] = { "begin1", 0.5, "begin2", 0.5 };
            };
        };
    };
};
