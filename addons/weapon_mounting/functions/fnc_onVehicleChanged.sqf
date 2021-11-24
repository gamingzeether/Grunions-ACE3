#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles player changing seats, entering a vehicle, or leaving a vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <UNIT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [quadbike, ACE_player] call ace_weapon_mounting_fnc_onVehicleChanged
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

if (_unit != ACE_player) exitWith {};
private _newRole = assignedVehicleRole _unit select 0;
private _handle = _vehicle getVariable [QGVAR(pfhHandle), -1];

if (_handle == -1) then {
    // Entering driver
    if (_newRole != "driver" || {vehicle _unit != _vehicle}) exitWith {};
    
    _handle = [FUNC(vehiclePFH), 0, [_vehicle]] call CBA_fnc_addPerFrameHandler;
    _vehicle setVariable [QGVAR(pfhHandle), _handle];
    
    private _mountedWeapon = _vehicle getVariable [QGVAR(mountedWeapon), objNull];
    if (isNull _mountedWeapon) exitWith {};
    
    private _playerID = owner _unit;
    if (_playerID != owner _mountedWeapon) then {
        _mountedWeapon setOwner _playerID;
    };
} else {
    // Exiting driver
    if (_newRole == "driver" && {vehicle _unit == _vehicle}) exitWith {};
    
    [_handle] call CBA_fnc_removePerFrameHandler;
    _vehicle setVariable [QGVAR(pfhHandle), -1];
};
