class CfgWeapons {
    class hgun_P07_F;
    class GVAR(SmartPistol_Weapon): hgun_P07_F {
        scope = 2;
        displayname = CSTRING(SmartPistol_Weapon_DisplayName);
        magazines[] = { QGVAR(12Rnd_SmartPistol_Mag) };
        magazineWell[] = { QGVAR(SmartPistol_9x21) };
        class Library {
            libTextDesc = CSTRING(SmartPistol_Weapon_LibDescription);
        };
    };
    
    class launch_B_Titan_F;
    class GVAR(Phoenix_Weapon): launch_B_Titan_F {
        scope = 2;
        canLock = 0;
        descriptionShort = CSTRING(Phoenix_Weapon_Description);
        displayname = CSTRING(Phoenix_Weapon_DisplayName);
        magazines[] = { QGVAR(1Rnd_Phoenix_Mag) };
        magazineWell[] = { QGVAR(Phoenix_Magwell) };
        modes[] = { "Single" };
        uiPicture = "\a3\weapons_f\data\ui\icon_at_ca.paa";
        class Library {
            libTextDesc = CSTRING(Phoenix_Weapon_LibDescription);
        };
    };
};
