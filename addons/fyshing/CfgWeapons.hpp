
class CfgWeapons {
    class GrenadeLauncher;
    class Throw: GrenadeLauncher {
        muzzles[] += {QGVAR(muzzle_nonexplosive), GVAR(muzzle_explosive), GVAR(muzzle_loitering)};

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
};
