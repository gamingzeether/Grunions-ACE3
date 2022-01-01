
class CfgWeapons {
    class GrenadeLauncher;
    class Throw: GrenadeLauncher {
        muzzles[] += {QGVAR(muzzle), GVAR(muzzle_explosive)};

        class ThrowMuzzle;
        
        class GVAR(muzzle): ThrowMuzzle {
            magazines[] = {QGVAR(fysh)};
        };
        class GVAR(muzzle_explosive): ThrowMuzzle {
            magazines[] = {QGVAR(fysh_explosive)};
        };
    };
    
    class ACE_VMM3;
    class GVAR(fyshingRod): ACE_VMM3 {
        displayName = CSTRING(fyshingRod_displayName);
        descriptionShort = CSTRING(fyshingRod_description);
        
        GVAR(ropeLength) = 50;
    };
};
