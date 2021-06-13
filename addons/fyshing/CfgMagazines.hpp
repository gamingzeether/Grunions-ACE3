class CfgMagazines {

    class SmokeShell;
    class ACE_Fysh: SmokeShell {
        author = ECSTRING(common,ACETeam);
        ammo = "ACE_Fysh";
        displayName = CSTRING(Fysh_DisplayName);
        displayNameShort = CSTRING(Fysh_DisplayName);
        descriptionShort = CSTRING(Fysh_DescriptionShort);
        model = "\A3\animals_f\Fishes\Tuna_F";
        picture = QPATHTOF(UI\ace_fyshing_fysh_ca.paa);
        ACE_Attachable = "ACE_Fysh";
    };
    
    class ACE_FyshExplosive: SmokeShell {
        author = ECSTRING(common,ACETeam);
        ammo = "ACE_FyshExplosive";
        displayName = CSTRING(FyshExplosive_DisplayName);
        displayNameShort = CSTRING(FyshExplosive_DisplayName);
        descriptionShort = CSTRING(Fysh_DescriptionShort);
        model = "\A3\animals_f\Fishes\Salema_porgy_F";
        picture = QPATHTOF(UI\ace_fyshing_fysh_ca.paa);
    };
};
