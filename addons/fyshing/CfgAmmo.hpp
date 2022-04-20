
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
    
    class EGVAR(pike,ammo_gl);
    class GVAR(pike_ammo_gl): EGVAR(pike,ammo_gl) {
        model = "\A3\animals_f\Fishes\CatShark_F";
        EGVAR(pike,replaceWith) = QGVAR(pike_ammo_rocket);
    };
    
    class EGVAR(pike,ammo_rocket);
    class GVAR(pike_ammo_rocket): EGVAR(pike,ammo_rocket) {
        model = "\A3\animals_f\Fishes\CatShark_F";
        submunitionAmmo = "";
        indirectHit = 8;
        indirectHitRange = 5;
    };
};
