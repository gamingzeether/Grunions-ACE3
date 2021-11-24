#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Reloads weapon with magazine
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 * 2: Interact menu args <ARRAY>
 * 3: Start loading/unloading cycle (Default: true) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_weapon_mounting_fnc_reload
 *
 * Public: No
 */

params ["_vehicle", "_unit", "_mag", ["_start", true]];

// Select mag with most ammo
private _cargoMags = magazinesAmmo _unit;
_cargoMags = _cargoMags select {(_x select 0) == _mag};
private _highestCount = -1;
{
    _highestCount = _highestCount max (_x select 1);
} foreach _cargoMags;

if (_highestCount > 0) then {
    GVAR(toLoad) pushBack [_vehicle, _unit, _mag, _highestCount];
};

if (_start) then {
    [true] call FUNC(doLoadUnloadCycle);
};
