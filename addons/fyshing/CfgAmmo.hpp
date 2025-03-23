
class CfgAmmo {

    class Chemlight_base;
    class GVAR(fysh): Chemlight_base {
        timeToLive = 900;
        model = "\A3\animals_f\Fishes\Tuna_F";
        effectsSmoke = "";
        EGVAR(advanced_throwing,torqueMagnitude) = 2;
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
    
    class GVAR(fysh_loitering_throw): Chemlight_base {
        timeToLive = 900;
        model = "\A3\animals_f\Fishes\ornate_F";
        effectsSmoke = "";
        EGVAR(advanced_throwing,torqueMagnitude) = 0;
        explosionTime = 5;
    };
    class EGVAR(loitering_munitions,Hero120);
    class GVAR(fysh_loitering): EGVAR(loitering_munitions,Hero120) {
        initTime = 0.25;
        timeToLive = 60;
        thrust = 10;
        thrustTime = 60;
        
        model = "\A3\animals_f\Fishes\ornate_F";
        EGVAR(advanced_throwing,torqueMagnitude) = 0;
        
        CraterEffects = "ImpactEffectsMedium";
        explosionEffects = "ATRocketExplosion";
        effectsMissileInit = "RocketBackEffectsRPG";
        effectsMissile = "missile3";
        soundFly[] = {"A3\Sounds_F\arsenal\weapons\Launchers\NLAW\Fly_NLAW",0.562341,1.5,20};
        
        deleteParentWhenTriggered = 0;
        submunitionAmmo = "ammo_Penetrator_MRAAWS_HEAT55";
        submunitionDirectionType = "SubmunitionModelDirection";
        submunitionInitSpeed = 500;
        submunitionParentSpeedCoef = 0;
        submunitionInitialOffset[] = { 0, 0, -0.2 };
        triggerOnImpact = 1;
        
        indirectHit = 8;
        indirectHitRange = 6;
        
        class ace_missileguidance {
            enabled = 1;

            minDeflection = 0;
            maxDeflection = 0.01;
            incDeflection = 0.0005;

            canVanillaLock = 0;

            defaultSeekerType = "Fysh";
            seekerTypes[] = {"Fysh"};

            defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = {"LOAL"};

            seekerAngle = 60;
            seekerAccuracy = 1;

            seekerMinRange = 0;
            seekerMaxRange = 500;

            defaultAttackProfile = "loitering_munition";
            attackProfiles[] = {"loitering_munition"};
        };
        
        class ace_loitering_munitions {
            enabled = 1;
            
            loiterShooter = 1;
            noParams = 1;
            
            minTerrainHeight = 25;
            
            minLoiterRadius = 150;
            maxLoiterRadius = 150;
        };
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
    
    class B_12Gauge_Pellets_Submunition;
    class GVAR(flyshette): B_12Gauge_Pellets_Submunition {
        submunitionAmmo = QGVAR(flyshette_submunition);
        submunitionConeAngle = 1;
        submunitionConeType[] = { "poissondisc", 20 };
    };
    class B_12Gauge_Pellets_Submunition_Deploy;
    class GVAR(flyshette_submunition): B_12Gauge_Pellets_Submunition_Deploy {
        hit = 5;
    };
};
