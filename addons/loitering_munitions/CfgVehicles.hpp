class CfgVehicles {
    class StaticWeapon;
    class StaticMortar: StaticWeapon {
        class Turrets;
    };
    class Mortar_01_base_F: StaticMortar {
        class Turrets: Turrets {
            class MainTurret;
        };
    };
    class GVAR(Hero120_static): Mortar_01_base_F {
        scope = 2;
        displayname = CSTRING(Hero120_displayName);
        artilleryScanner = 0;
        
        class ace_csw {
            ammoLoadTime = 3;
            ammoUnloadTime = 3;
            desiredAmmo = 1;
            disassembleTurret = QEGVAR(csw,mortarBaseplate);
            disassembleWeapon = QGVAR(carry_Hero120);
            enabled = 1;
            magazineLocation = "_target selectionPosition 'usti hlavne'";
            proxyWeapon = QGVAR(launch_Hero120);
        };
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                magazines[] = {QGVAR(1Rnd_Hero120)};
                weapons[] = {QGVAR(launch_Hero120)};
            };
        };
    };
    
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(openDialog) {
                    displayName = CSTRING(openDialog);
                    condition = QUOTE(call FUNC(canOpenDialog));
                    statement = QUOTE(call FUNC(openDialog));
                    showDisabled = 0;
                    exceptions[] = {"isnotinside"};
                };
            };
        };
    };
};
