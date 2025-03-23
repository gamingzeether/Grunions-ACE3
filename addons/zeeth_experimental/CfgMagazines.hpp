class CfgMagazines {
    class 16Rnd_9x21_Mag;
    class GVAR(12Rnd_SmartPistol_Mag): 16Rnd_9x21_Mag {
        ammo = QGVAR(SmartPistol_Ammo);
        count = 12;
        descriptionShort = CSTRING(SmartPistol_Mag_Description);
        displayname = CSTRING(SmartPistol_Mag_DisplayName);
    };
    
    class Titan_AT;
    class GVAR(1Rnd_Phoenix_Mag): Titan_AT {
        ammo = QGVAR(Phoenix_Ammo);
        descriptionShort = CSTRING(Phoenix_Mag_Description);
        displayName = CSTRING(Phoenix_Mag_DisplayName);
    };
    class 100Rnd_65x39_caseless_mag_Tracer;
    class GVAR(InfRnd_65x39_caseless_mag_Tracer): 100Rnd_65x39_caseless_mag_Tracer {
        displayName = CSTRING(MagOfHolding_DisplayName);
        descriptionShort = CSTRING(MagOfHolding_Description);
        count = 1e4;
        lastRoundsTracer = 1e4;
    };
};
