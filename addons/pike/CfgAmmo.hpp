class CfgAmmo {
    class FlareBase;
    class GVAR(ammo_gl): FlareBase {
        model = QPATHTOF(models\ace_pike_ammo.p3d);
        lightColor[] = {0, 0, 0, 0};
        smokeColor[] = {0, 0, 0, 0};
        timeToLive = 1;
        
        //allow mode change
        class ace_missileguidance {
            enabled = 1;
            
            defaultAttackProfile = "pike";
            attackProfiles[] = { "pike", "LIN" };
            showHintOnCycle = 1;
        };
    };

    class MissileBase;
    class GVAR(ammo_rocket): MissileBase {
        irLock = 0;
        laserLock = 0;
        airLock = 0;
        manualControl = 0;

        timeToLive = 60;

        model = QPATHTOF(models\ace_pike_ammo.p3d);
        maxSpeed = 150;
        thrust = 15;
        thrustTime = 8;
        initTime = 0;
        airFriction = 0.1;

        hit = 50;
        indirectHit = 15;
        indirectHitRange = 8;

        CraterEffects = "ImpactEffectsMedium";
        explosionEffects = "ATRocketExplosion";
        effectsMissileInit = "RocketBackEffectsRPG";
        effectsMissile = "missile3";
        soundFly[] = {"A3\Sounds_F\arsenal\weapons\Launchers\NLAW\Fly_NLAW",0.562341,1.5,700};

        submunitionAmmo = "ammo_Penetrator_MRAAWS_HEAT55";
        submunitionDirectionType = "SubmunitionModelDirection";
        submunitionInitSpeed = 500;
        submunitionParentSpeedCoef = 0;
        submunitionInitialOffset[] = { 0, 0, -0.2 };
        triggerOnImpact = 1;

        // Begin ACE guidance Configs
        class ace_missileguidance {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = {"LOAL"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "pike";
            attackProfiles[] = { "pike", "LIN" };
        };
    };
};
