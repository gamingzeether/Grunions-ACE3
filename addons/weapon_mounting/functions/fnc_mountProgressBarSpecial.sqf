#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Starts progress bar for mounting a special weapon
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <UNIT>
 * 2: Args <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [quadbike, ACE_player, "B_Mortar_01_weapon_F"] call ace_weapon_mounting_fnc_mountProgressBar
 *
 * Public: No
 */

params ["_vehicle", "_unit", "_args"];
_args params ["_weaponOriginal", "_weapon", "_model", "_scale", "_type"];

[
    5,
    [_vehicle, _unit, _weaponOriginal, _weapon, _model, _scale, _type],
    {
        params ["_args", "_timeElapsed", "_time", "_exitCode"];
        _args params ["_vehicle", "_unit", "_weaponOriginal", "_weapon", "_model", "_scale", "_type"];
        
        // Remove item
        private _exit = false;
        switch _type do {
            case TYPE_LAUNCHER: {
                if (!([_unit, _weaponOriginal] call CBA_fnc_removeWeapon)) then {
                    _exit = true;
                };
            };
            case TYPE_BACKPACK: {
                if (backpack _unit == _weaponOriginal) then {
                    removeBackpack _unit;
                } else {
                    _exit = true;
                };
            };
        };
        if (_exit) exitWith {};
        
        [_weapon, _vehicle, [], _model, _scale, _weaponOriginal] call FUNC(mountWeapon);
    },
    {},
    format [LLSTRING(mount_title), getText (configFile >> "CfgWeapons" >> _weapon >> "displayName")]
] call EFUNC(common,progressBar);
