class CfgAmmo {
    class MissileBase;
    class GVAR(Hero120): MissileBase {
        initTime = 0.25;
        timeToLive = 660;
        thrust = 20;
        thrustTime = 600;
        
        multiSoundHit[] = {"soundHit1",0.34,"soundHit2",0.33,"soundHit3",0.33};
        soundFly[] = {"A3\Sounds_F\arsenal\weapons\Launchers\Titan\Fly_Titan",0.630957,1.5,300};
        soundHit1[] = {"A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_01",2.51189,1,2000};
        soundHit2[] = {"A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_02",2.51189,1,2000};
        soundHit3[] = {"A3\Sounds_F\arsenal\weapons\Launchers\Titan\Explosion_titan_missile_03",2.51189,1,2000};
        SoundSetExplosion[] = {"RocketsHeavy_Exp_SoundSet","RocketsHeavy_Tail_SoundSet","Explosion_Debris_SoundSet"};
        
        model = "\A3\Weapons_F_beta\Launchers\titan\titan_missile_at_fly";
        explosionEffects = "BombExplosion";
        
        deleteParentWhenTriggered = 0;
        submunitionAmmo = "ammo_Penetrator_Titan_AT";
        submunitionDirectionType = "SubmunitionModelDirection";
        submunitionInitSpeed = 2000;
        submunitionParentSpeedCoef = 0;
        submunitionInitialOffset[] = { 0, 0, -0.2 };
        triggerOnImpact = 1;
        
        indirectHit = 50;
        indirectHitRange = 4;
        
        class ace_missileguidance {
            enabled = 1;
            
            seekLastTargetPos = 1;

            minDeflection = 0;
            maxDeflection = 0.005;
            incDeflection = 0.0005;

            canVanillaLock = 0;

            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = {"LOAL"};

            seekerAngle = 95;
            seekerAccuracy = 1;

            seekerMinRange = 1;
            seekerMaxRange = 5000;

            defaultAttackProfile = "loitering_munition";
            attackProfiles[] = {"loitering_munition"};
        };
        class ADDON {
            enabled = 1;
            
            minTerrainHeight = 100;
            
            minLoiterRadius = 1000;
            maxLoiterRadius = 10000;
        };
    };
};
