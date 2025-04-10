class CfgMagazines {

    class SmokeShell;
    class GVAR(fysh): SmokeShell {
        author = ECSTRING(common,ACETeam);
        ammo = QGVAR(fysh);
        displayName = CSTRING(Fysh_DisplayName);
        displayNameShort = CSTRING(Fysh_DisplayName);
        descriptionShort = CSTRING(Fysh_DescriptionShort);
        model = "\A3\animals_f\Fishes\Tuna_F";
        picture = QPATHTOF(UI\ace_fyshing_fysh_ca.paa);
        ACE_Attachable = QGVAR(fysh);
    };
    
    class GVAR(fysh_explosive): SmokeShell {
        author = ECSTRING(common,ACETeam);
        ammo = QGVAR(fysh_explosive);
        displayName = CSTRING(FyshExplosive_DisplayName);
        displayNameShort = CSTRING(FyshExplosive_DisplayName);
        descriptionShort = CSTRING(Fysh_DescriptionShort);
        model = "\A3\animals_f\Fishes\Salema_porgy_F";
        picture = QPATHTOF(UI\ace_fyshing_fysh_ca.paa);
    };
    
    class GVAR(fysh_loitering): SmokeShell {
        author = ECSTRING(common,ACETeam);
        ammo = QGVAR(fysh_loitering_throw);
        displayName = CSTRING(FyshLoitering_DisplayName);
        displayNameShort = CSTRING(FyshLoitering_DisplayName);
        descriptionShort = CSTRING(Fysh_DescriptionShort);
        mass = 20;
        model = "\A3\animals_f\Fishes\ornate_F";
        picture = QPATHTOF(UI\ace_fyshing_fysh_ca.paa);
    };
    
    class ACE_40mm_Pike;
    class ACE_40mm_PikeFysh: ACE_40mm_Pike {
        displayName = CSTRING(pike_magazine_displayName);
        displayNameShort = "Pike SALH";
        ammo = QGVAR(pike_ammo_gl);
        model = "\A3\animals_f\Fishes\CatShark_F";
        count = 3;
        mass = 34;
    };
    
    class UGL_FlareWhite_F;
    class ACE_40mm_Flyshchette: UGL_FlareWhite_F {
        displayName = CSTRING(Flyshchette_Magazine_displayName);
        displayNameShort = CSTRING(Flyshchette_Magazine_displayNameShort);
        ammo = QGVAR(flyshette);
        count = 1;
        initSpeed = 270;
        mass = 3;
        model = "\A3\animals_f\Fishes\ornate_F.p3d";
    };
};
