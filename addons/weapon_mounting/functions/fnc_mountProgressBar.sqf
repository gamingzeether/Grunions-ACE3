#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Starts progress bar for mounting weapon
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <UNIT>
 * 2: Weapon <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [quadbike, ACE_player, "MMG_01_base_F"] call ace_weapon_mounting_fnc_mountProgressBar
 *
 * Public: No
 */

params ["_vehicle", "_unit", "_weapon"];

[
    5,
    _this,
    {
        params ["_args", "_timeElapsed", "_time", "_exitCode"];
        _args params ["_vehicle", "_unit", "_weapon"];
        
        {
            _x params ["_xName", "_xCount", "_xLoaded", "_xType", "_xLocation"];
            
            if (_xLoaded && {_xLocation == _weapon}) then {
                [_unit, _xName, _xCount, true] call CBA_fnc_addMagazine;
            };
        } foreach (magazinesAmmoFull _unit);
        {
            [_unit, _x, true] call CBA_fnc_addItem;
        } foreach (_unit weaponAccessories _weapon);
        
        [_unit, _weapon] call CBA_fnc_removeWeapon;
        _weapon = ([_weapon] call CBA_fnc_weaponComponents) select 0;
        [QGVAR(mountWeapon), [_weapon, _vehicle]] call CBA_fnc_globalEvent;
    },
    {},
    format [LLSTRING(mount_title), getText (configFile >> "CfgWeapons" >> _weapon >> "displayName")]
] call EFUNC(common,progressBar);
