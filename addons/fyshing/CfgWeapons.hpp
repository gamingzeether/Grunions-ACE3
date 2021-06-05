
class CfgWeapons {

    class GrenadeLauncher;
    class Throw: GrenadeLauncher {
        muzzles[] += {"ACE_FyshMuzzle"};

        class ThrowMuzzle;
        
        class ACE_FyshMuzzle: ThrowMuzzle {
            magazines[] = {"ACE_Fysh"};
        };
    };
};
