class CfgAmmo {
    class B_9x21_Ball_Tracer_Red;
    class GVAR(SmartPistol_Ammo): B_9x21_Ball_Tracer_Red {};
    
    class M_NLAW_AT_F;
    class GVAR(Phoenix_Ammo): M_NLAW_AT_F {
        initTime = 0.5;
        effectsMissile = "missile1";
        maxSpeed = 50;
        timeToLive = 10;
        thrust = 10;
        thrustTime = 10;
    };
};
