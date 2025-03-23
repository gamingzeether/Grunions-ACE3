class CfgAmmo {
    class B_12Gauge_HD_Pellets_Submunition;
    class GVAR(ammo_shot): B_12Gauge_HD_Pellets_Submunition {
        submunitionAmmo = QGVAR(ammo_pellet);
        submunitionConeAngle = 0.5;
        submunitionConeType[] = { "poissondisc", 8 };
    };
    class B_20mm;
    class GVAR(ammo_pellet): B_20mm {
        hit = 1;
        indirectHitRange = 4;
    };
};
