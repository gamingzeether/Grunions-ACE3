class CfgWeapons {
    class Binocular;
    class NVGoggles: Binocular {
        displayName = CSTRING(NVG_Gen3_brown);
        modelOptics = "";
        GVAR(border) = QPATHTOF(data\nvg_mask_binos_4096.paa);
        GVAR(bluRadius) = 0.15;
        NVG_GREEN_PRESET;
    };
    class ACE_NVGoggles_WP: NVGoggles {
        displayName = CSTRING(NVG_Gen3_brown_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class O_NVGoggles_hex_F: NVGoggles { // APEX NVG with multiple lenses (spider eyes)
        modelOptics = "";
        GVAR(border) = QPATHTOF(data\nvg_mask_quad_4096.paa); // Use quad tube mask
        GVAR(bluRadius) = 0.26;
    };
    class NVGogglesB_grn_F: NVGoggles { // APEX NVG/Thermal
        modelOptics = "\A3\weapons_f_exp\reticle\ENVG.p3d"; // use vanilla modelOptics so it will show in IR mode
    };
    class NVGogglesB_gry_F: NVGoggles {
        modelOptics = "\A3\weapons_f_exp\reticle\ENVG.p3d";
    };
    class NVGoggles_OPFOR: NVGoggles {
        modelOptics = "";
        displayName = CSTRING(NVG_Gen3_black);
    };
    class ACE_NVGoggles_OPFOR_WP: NVGoggles_OPFOR {
        displayName = CSTRING(NVG_Gen3_black_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class NVGoggles_INDEP: NVGoggles {
        modelOptics = "";
        displayName = CSTRING(NVG_Gen3_green);
    };
    class ACE_NVGoggles_INDEP_WP: NVGoggles_INDEP {
        displayName = CSTRING(NVG_Gen3_green_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class ACE_NVG_Gen1: NVGoggles_OPFOR {
        author = ECSTRING(common,ACETeam);
        displayName = CSTRING(NVG_Gen1);
        GVAR(generation) = 1;
    };
    class ACE_NVG_Gen2: NVGoggles_INDEP {
        author = ECSTRING(common,ACETeam);
        displayName = CSTRING(NVG_Gen2);
        GVAR(generation) = 2;
    };
    class ACE_NVG_Gen4_Black: NVGoggles_OPFOR {
        author = ECSTRING(common,ACETeam);
        displayName = CSTRING(NVG_Gen4_black);
        GVAR(generation) = 4;
    };
    class ACE_NVG_Gen4_Black_WP: ACE_NVG_Gen4_Black {
        displayName = CSTRING(NVG_Gen4_black_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class ACE_NVG_Gen4: NVGoggles {
        author = ECSTRING(common,ACETeam);
        displayName = CSTRING(NVG_Gen4);
        GVAR(generation) = 4;
    };
    class ACE_NVG_Gen4_WP: ACE_NVG_Gen4 {
        displayName = CSTRING(NVG_Gen4_brown_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class ACE_NVG_Gen4_Green: NVGoggles_INDEP {
        author = ECSTRING(common,ACETeam);
        displayName = CSTRING(NVG_Gen4_green);
        GVAR(generation) = 4;
    };
    class ACE_NVG_Gen4_Green_WP: ACE_NVG_Gen4_Green {
        displayName = CSTRING(NVG_Gen4_green_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class ACE_NVG_Wide_Black: NVGoggles_OPFOR {
        author = ECSTRING(common,ACETeam);
        modelOptics = QPATHTOF(models\ACE_nvg_wide_optics);
        displayName = CSTRING(NVG_Wide_black);
    };
    class ACE_NVG_Wide_Black_WP: ACE_NVG_Wide_Black {
        displayName = CSTRING(NVG_Wide_black_wP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class ACE_NVG_Wide: NVGoggles {
        author = ECSTRING(common,ACETeam);
        modelOptics = QPATHTOF(models\ACE_nvg_wide_optics);
        displayName = CSTRING(NVG_Wide_brown);
    };
    class ACE_NVG_Wide_WP: ACE_NVG_Wide {
        displayName = CSTRING(NVG_Wide_brown_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };
    class ACE_NVG_Wide_Green: NVGoggles_INDEP {
        author = ECSTRING(common,ACETeam);
        modelOptics = QPATHTOF(models\ACE_nvg_wide_optics);
        displayName = CSTRING(NVG_Wide_green);
    };
    class ACE_NVG_Wide_Green_WP: ACE_NVG_Wide_Green {
        displayName = CSTRING(NVG_Wide_green_WP);
        descriptionShort = CSTRING(NVG_WP_desc);
        NVG_WHITE_PRESET;
    };


    // Examples of different goggle effect types (scope=1)
    // These all function differently, but we have no models to go with them
    class ACE_NVG_Biocular: NVGoggles {
        scope = 1;
        modelOptics = "";
        author = ECSTRING(common,ACETeam);
        descriptionShort = "Biocular nightvision goggles";
        displayName = "NV Goggles (Bio)";
        GVAR(border) = QPATHTOF(data\nvg_mask_4096.paa);
        GVAR(bluRadius) = 0.13;
        GVAR(eyeCups) = 1;
    };
    class ACE_NVG_Monocular: NVGoggles {
        scope = 1;
        modelOptics = "";
        author = ECSTRING(common,ACETeam);
        descriptionShort = "Monocular nightvision goggles";
        displayName = "NV Goggles (Mono)";
        GVAR(border) = QPATHTOF(data\nvg_mask_4096.paa);
        GVAR(bluRadius) = 0.13;
    };
    class ACE_NVG_Binocular: NVGoggles {
        scope = 1;
        modelOptics = "";
        author = ECSTRING(common,ACETeam);
        descriptionShort = "Binocular nightvision goggles";
        displayName = "NV Goggles (Bino)";
        GVAR(border) = QPATHTOF(data\nvg_mask_binos_4096.paa);
        GVAR(bluRadius) = 0.15;
    };
    class ACE_NVG_Quadocular: NVGoggles {
        scope = 1;
        modelOptics = "";
        author = ECSTRING(common,ACETeam);
        descriptionShort = "Quadocular nightvision goggles";
        displayName = "NV Goggles (Quad)";
        GVAR(border) = QPATHTOF(data\nvg_mask_quad_4096.paa);
        GVAR(bluRadius) = 0.26;
    };
};
