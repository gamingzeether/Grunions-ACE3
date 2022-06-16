#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles player changing seats, entering a vehicle, or leaving a vehicle
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 * 1: Changed UAV (Default: false) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_weapon_mounting_fnc_onVehicleChanged
 *
 * Public: No
 */

params ["_unit", ["_isUAV", false]];

if (_unit != ACE_player) exitWith {};

private _vehicle = ACE_player;
private _newRole = "";
if (_isUAV) then {
    _vehicle = getConnectedUAV ACE_player;
    _newRole = UAVControl _vehicle select 1;
} else {
    _vehicle = vehicle ACE_player;
    _newRole = assignedVehicleRole ACE_player select 0;
};
private _vehicleRole = GVAR(controllers) get typeOf _vehicle;

if (!isNil "_vehicleRole" && {((_isUAV && local gunner _vehicle) || {_newRole isEqualTo _vehicleRole}) && {_vehicle != ACE_player}}) then {
    private _mountedWeapon = _vehicle getVariable [QGVAR(mountedWeapon), objNull];
    if (isNull _mountedWeapon) exitWith {};
    GVAR(runPFH) = true;
    GVAR(vehicle) = _vehicle;
} else {
    // Exiting
    if (isNil "_vehicleRole" || {_newRole isNotEqualTo _vehicleRole}) then {
        GVAR(runPFH) = false;
    };
};
