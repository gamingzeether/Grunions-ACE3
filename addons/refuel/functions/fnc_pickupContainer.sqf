#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Picks up a deployed fuel container
 *
 * Arguments:
 * 0: Container <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [container, ACE_player] call ace_fuelcontainer_fnc_pickupContainer
 *
 * Public: No
 */

params ["_container", "_unit"];

private _fuel = [_container] call FUNC(getFuel);
private _pickupItem = "";
private _deployWeapon = _container getVariable [QGVAR(weapon), ""];
if (_fuel >= _container getVariable QGVAR(capacity)) then {
    _pickupItem = getText (configFile >> "CfgWeapons" >> _deployWeapon >> QGVAR(full));
} else {
    _pickupItem = getText (configFile >> "CfgWeapons" >> _deployWeapon >> QGVAR(empty));
};


[objNull, _container, false] call FUNC(dropNozzle);
deleteVehicle _container;

[_unit, _pickupItem, true] call CBA_fnc_addWeapon;
