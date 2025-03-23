
class CfgWeapons {
    class GrenadeLauncher;
    class Throw: GrenadeLauncher {
        muzzles[] += {QGVAR(muzzle_nonexplosive), QGVAR(muzzle_explosive), QGVAR(muzzle_loitering)};

        class ThrowMuzzle;
        
        class GVAR(muzzle_nonexplosive): ThrowMuzzle {
            magazines[] = {QGVAR(fysh)};
        };
        class GVAR(muzzle_explosive): ThrowMuzzle {
            magazines[] = {QGVAR(fysh_explosive)};
        };
        class GVAR(muzzle_loitering): ThrowMuzzle {
            magazines[] = {QGVAR(fysh_loitering)};
        };
    };
    
    class ACE_VMM3;
    class GVAR(fyshingRod): ACE_VMM3 {
        displayName = CSTRING(fyshingRod_displayName);
        descriptionShort = CSTRING(fyshingRod_description);
        
        GVAR(ropeLength) = 50;
    };
    
    class H_Cap_red;
    class ACE_H_Cap_Fysh: H_Cap_red {
        author = ECSTRING(common,ACETeam);
        displayName = CSTRING(cap_displayName);
        picture = "\A3\characters_f\Data\UI\icon_H_Cap_tan_CA.paa";
        hiddenSelectionsTextures[] = { QPATHTOF(data\capb_fysh_co.paa) };
        class ItemInfo {
            mass = 4;
            uniformModel = "\A3\Characters_F\common\capb.p3d";
            allowedSlots[] = { 801, 901, 701, 605 };
            modelSides[] = { 6 };
            scope = 0;
            type = 605;
            hiddenSelections[] = { "camo" };
        };
    };
};
