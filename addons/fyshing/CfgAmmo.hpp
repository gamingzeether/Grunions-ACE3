
class CfgAmmo {

    class Chemlight_base;
    
    class ACE_Fysh: Chemlight_base {
        timeToLive = 900;
        model = "\A3\animals_f\Fishes\tuna_F";
        effectsSmoke = "";
        EGVAR(advanced_throwing,torqueMagnitude) = 2;
        //SmokeShellSoundHit1[] = {QPATHTOF(sounds\fyshing.ogg),2,1,50};
        //grenadeFireSound[] = {"SmokeShellSoundHit1",0.5,};
        explosionTime = 5;
    };
};
