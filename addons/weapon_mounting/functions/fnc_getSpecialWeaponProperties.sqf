#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Returns properties of special weapon
 *
 * Arguments:
 * 0: Classname <STRING>
 *
 * Return Value:
 * Properties <ARRAY>
 *  0: Display name <STRING>
 *  1: Icon path <STRING>
 *  2: Weapon classname <STRING>
 *  3: Model path <STRING>
 *  4: Scale <NUMBER>
 *  5: Type of weapon <NUMBER>
 *
 * Example:
 * ["B_Mortar_01_weapon_F"] call ace_weapon_mounting_fnc_getSpecialWeaponProperties
 *
 * Public: No
 */

params ["_sWeapon"];

private _backpackConfig = (configFile >> "CfgVehicles" >> _sWeapon);
private _weaponConfig = (configFile >> "CfgWeapons" >> _sWeapon);

private _properties = [];
if (isClass (_weaponConfig) && {getNumber (_weaponConfig >> QGVAR(enabled)) == 1}) then {
    private _weapon = getText (_weaponConfig >> QGVAR(weapon));
    
    _properties pushBack getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
    _properties pushBack getText (_weaponConfig >> "picture");
    _properties pushBack _weapon;
    _properties pushBack getText (_weaponConfig >> QGVAR(model));
    _properties pushBack getNumber (_weaponConfig >> QGVAR(scale));
    _properties pushBack TYPE_LAUNCHER;
} else {
    if (isClass (_backpackConfig) && {getNumber (_backpackConfig >> QGVAR(enabled)) == 1} && {getNumber (_backpackConfig >> "isBackpack") == 1}) then {
        private _weapon = getText (_backpackConfig >> QGVAR(weapon));
        
        _properties pushBack getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
        _properties pushBack getText (_backpackConfig >> QGVAR(picture));
        _properties pushBack _weapon;
        _properties pushBack getText (_backpackConfig >> QGVAR(model));
        _properties pushBack getNumber (_backpackConfig >> QGVAR(scale));
        _properties pushBack TYPE_BACKPACK;
    } else {
        _properties = ["", "", "", "", -1, TYPE_FAIL];
    };
};

_properties
