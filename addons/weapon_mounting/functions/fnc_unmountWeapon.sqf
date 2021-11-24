#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Removes a mounted weapon
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 * 2: CfgWeapons classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [quadbike, ACE_player, "MMG_01_base_F"] call ace_weapon_mounting_fnc_unmountWeapon
 *
 * Public: Yes
*/

params ["_vehicle", "_unit", "_weapon"];

[
    5,
    _this,
    {
        params ["_args", "_timeElapsed", "_time", "_exitCode"];
        _args params ["_vehicle", "_unit", "_weapon"];
        
        // Remove actions
        private _dummyName = format [QGVAR(dummy_%1), _weapon];
        [_vehicle, 0, [_dummyName, QGVAR(reload)]] call EFUNC(interact_menu,removeActionFromObject);
        [_vehicle, 0, [_dummyName, QGVAR(unload)]] call EFUNC(interact_menu,removeActionFromObject);
        [_vehicle, 0, [_dummyName, QGVAR(unmount)]] call EFUNC(interact_menu,removeActionFromObject);
        [_vehicle, 0, [_dummyName]] call EFUNC(interact_menu,removeActionFromObject);
        
        // End PFH if it is currently running
        private _handle = _vehicle getVariable [QGVAR(pfhHandle), -1];
        [_handle] call CBA_fnc_removePerFrameHandler;
        _vehicle setVariable [QGVAR(pfhHandle), -1];
        
        // Remove events
        _vehicle removeEventHandler ["Fired", _vehicle getVariable QGVAR(eventFired)];
        _vehicle removeEventHandler ["GetIn", _vehicle getVariable QGVAR(eventGetIn)];
        _vehicle removeEventHandler ["GetOut", _vehicle getVariable QGVAR(eventGetOut)];
        _vehicle removeEventHandler ["SeatSwitched", _vehicle getVariable QGVAR(eventSeatSwitched)];
        _vehicle removeMPEventHandler ["MPKilled", _vehicle getVariable QGVAR(eventMPKilled)];
        
        // Remove weapon
        _vehicle removeWeaponTurret [_weapon, [-1]];
        private _weaponModel = _vehicle getVariable QGVAR(mountedWeapon);
        [_unit, _weaponModel getVariable QGVAR(originalWeapon), true] call CBA_fnc_addWeapon;
        deleteVehicle _weaponModel;
        
        // Reset variables
        _vehicle setVariable [QGVAR(freePositions), nil, true];
        _vehicle setVariable [QGVAR(compatMags), nil, true];
        _vehicle setVariable [QGVAR(mountedWeapon), nil, true];
        _vehicle setVariable [QGVAR(eventFired), nil, true];
        _vehicle setVariable [QGVAR(eventGetIn), nil, true];
        _vehicle setVariable [QGVAR(eventGetOut), nil, true];
        _vehicle setVariable [QGVAR(eventSeatSwitched), nil, true];
        _vehicle setVariable [QGVAR(eventMPKilled), nil, true];
    },
    {},
    format [LLSTRING(unmount_title), getText (configFile >> "CfgWeapons" >> _weapon >> "displayName")]
] call EFUNC(common,progressBar);
