class CfgWeapons {
    class Pistol;
    class Pistol_Base_F: Pistol {
        class WeaponSlotsInfo;
    };
    
    class GVAR(ContainerWeaponBase): Pistol_Base_F {
        optics = 0;
        magazines[] = {};
        modes[] = {};
        cursor = "EmptyCursor";
        cursorAim = "EmptyCursor";
        GVAR(capacity) = 0;
        GVAR(vehicle) = "";
    };
    
    class GVAR(5LContainer_Empty): GVAR(ContainerWeaponBase) {
        GVAR(empty) = QGVAR(5LContainer_Empty);
        GVAR(full) = QGVAR(5LContainer_Full);
        GVAR(capacity) = 5;
        GVAR(vehicle) = "Land_Canteen_F";
        
        model = "\A3\Structures_F_EPA\Items\Food\Canteen_F.p3d";
        scope = 2;
        displayName = CSTRING(5LContainer_Empty_DisplayName);
        picture = QPATHTOF(data\5LContainer_ca.paa);
        class WeaponSlotsInfo: WeaponSlotsInfo {
            mass = 50;
            class CowsSlot {};
            class MuzzleSlot {};
        };
    };
    class GVAR(5LContainer_Full): GVAR(5LContainer_Empty) {
        scope = 1;
        displayName = CSTRING(5LContainer_Full_DisplayName);
    };
};
