#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if weapon can be unloaded
 *
 * Arguments:
 * Action args
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_weapon_mounting_fnc_canUnload
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

private _compatMags = [];
if (_vehicle getVariable [QGVAR(cswMags), false]) then {
    private _weaponName = _vehicle getVariable QGVAR(mountedWeaponName);
    _compatMags = [_weaponName, true] call CBA_fnc_compatibleMagazines;
} else {
    _compatMags = _vehicle getVariable [QGVAR(compatMags), []];
};
(count ((_vehicle magazinesTurret [getArray (configOf _vehicle >> QGVAR(turret)), true]) select {_x in _compatMags}) > 0)
