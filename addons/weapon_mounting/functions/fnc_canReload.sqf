#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if weapon can be reloaded
 *
 * Arguments:
 * Action args
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_weapon_mounting_fnc_canReload
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

private _compatMags = _vehicle getVariable [QGVAR(compatMags), []];
private _carryMags = magazinesAmmo _unit;
{
    _carryMags set [_foreachIndex, _x select 0];
} foreach _carryMags;

private _magIntersect = _carryMags arrayIntersect _compatMags;

(count _magIntersect > 0)
