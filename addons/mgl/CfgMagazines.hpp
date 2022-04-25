
class CfgMagazines {
    class 1Rnd_HE_Grenade_shell;
    class ACE_6Rnd_40mm_HE: 1Rnd_HE_Grenade_shell {
        ammo = "ACE_R_40mm_HE";
        count = 6;
        descriptionShort = CSTRING(MGLMagazine_HE_descriptionShort);
        displayName = CSTRING(MGLMagazine_HE_displayName);
        displayNameShort = "HE Grenade";
        mass = 30; // 3 lbs
    };
};
