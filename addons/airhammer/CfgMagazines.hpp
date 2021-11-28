class CfgMagazines {
    class PylonWeapon_300Rnd_20mm_shells;
    class GVAR(100Rnd_mag): PylonWeapon_300Rnd_20mm_shells {
        pylonWeapon = QGVAR(airhammer);
        ammo = QGVAR(ammo_shot);
        count = 100;
        displayName = CSTRING(weapon_displayName);
    };
};
