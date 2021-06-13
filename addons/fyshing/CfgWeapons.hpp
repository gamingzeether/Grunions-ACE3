
class CfgWeapons {

    class GrenadeLauncher;
    class Throw: GrenadeLauncher {
        muzzles[] += {"ACE_Fysh_Muzzle", "ACE_Fysh_ExplosiveMuzzle"};

        class ThrowMuzzle;
        
        class ACE_Fysh_Muzzle: ThrowMuzzle {
            magazines[] = {"ACE_Fysh"};
        };
        class ACE_Fysh_ExplosiveMuzzle: ThrowMuzzle {
            magazines[] = {"ACE_FyshExplosive"};
        };
    };
};
