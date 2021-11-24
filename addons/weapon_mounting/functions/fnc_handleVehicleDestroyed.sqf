#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles vehicle being destroyed
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [quadbike] call ace_weapon_mounting_fnc_handleVehicleDestroyed
 *
 * Public: No
 */

params ["_vehicle"];

if (!local _vehicle) exitWith {};

_mountedWeapon = _vehicle getVariable [QGVAR(mountedWeapon), objNull];
deleteVehicle _mountedWeapon;

private _handle = _vehicle getVariable [QGVAR(pfhHandle), -1];
[_handle] call CBA_fnc_removePerFrameHandler;
_vehicle setVariable [QGVAR(pfhHandle), -1];
