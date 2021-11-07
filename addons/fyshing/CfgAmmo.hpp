
class CfgAmmo {

    class Chemlight_base;
    class GVAR(fysh): Chemlight_base {
        timeToLive = 900;
        model = "\A3\animals_f\Fishes\Tuna_F";
        effectsSmoke = "";
        EGVAR(advanced_throwing,torqueMagnitude) = 2;
        //SmokeShellSoundHit1[] = {QPATHTOF(sounds\fyshing.ogg),2,1,50};
        //grenadeFireSound[] = {"SmokeShellSoundHit1",0.5,};
        explosionTime = 5;
    };
    
    class GrenadeHand;
    class GVAR(fysh_explosive): GrenadeHand {
        timeToLive = 900;
        model = "\A3\animals_f\Fishes\Salema_porgy_F";
        EGVAR(advanced_throwing,torqueMagnitude) = 4;
        //SmokeShellSoundHit1[] = {QPATHTOF(sounds\fyshing.ogg),2,1,50};
        //grenadeFireSound[] = {"SmokeShellSoundHit1",0.5,};
        explosionTime = 20;
    };
};
