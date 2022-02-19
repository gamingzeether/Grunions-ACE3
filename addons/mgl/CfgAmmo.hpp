class CfgAmmo {
    class RocketBase;
    class ACE_R_40mm_HE: RocketBase {
        // Just copied from G_40mm_HE
        EGVAR(frag,charge) = 32;
        EGVAR(frag,classes)[] = {"ace_frag_tiny_HD"};
        EGVAR(frag,enabled) = 1;
        EGVAR(frag,force) = 1;
        EGVAR(frag,gurney_c) = 2700;
        EGVAR(frag,gurney_k) = "1/2";
        EGVAR(frag,metal) = 200;
        EGVAR(rearm,caliber) = 39;
        EGVAR(vehicle_damage,incendiary) = 0.1;
        
        ACE_caliber = 80;
        CraterEffects = "GrenadeCrater";
        fuseDistance = 15;
        hit = 80;
        indirectHit = 8;
        indirectHitRange = 6;
        model = "\A3\weapons_f\ammo\UGL_slug";
        multiSoundHit[] = {"soundHit1",0.25,"soundHit2",0.25,"soundHit3",0.25,"soundHit4",0.25};
        soundHit1[] = {"A3\Sounds_F\arsenal\explosives\Grenades\Explosion_gng_grenades_01",3.16228,1,1500};
        soundHit2[] = {"A3\Sounds_F\arsenal\explosives\Grenades\Explosion_gng_grenades_02",3.16228,1,1500};
        soundHit3[] = {"A3\Sounds_F\arsenal\explosives\Grenades\Explosion_gng_grenades_03",3.16228,1,1500};
        soundHit4[] = {"A3\Sounds_F\arsenal\explosives\Grenades\Explosion_gng_grenades_04",3.16228,1,1500};
        SoundSetExplosion[] = {"GrenadeHe_Exp_SoundSet","GrenadeHe_Tail_SoundSet","Explosion_Debris_SoundSet"};
        thrustTime = 0;
        typicalSpeed = 185;
        visibleFire = 1;
        visibleFireTime = 3;
        warheadName = "HE";
        whistleDist = 16;
        
        class CamShakeExplode {
            distance = 74.5964;
            duration = 1.2;
            frequency = 20;
            power = 8;
        };
        class HitEffects {
            object = "ImpactConcrete";
            vehicle = "ImpactMetal";
        };
    };
};
