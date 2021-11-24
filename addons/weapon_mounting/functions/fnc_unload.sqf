#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Unloads all mags in a turret
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
 * [] call ace_weapon_mounting_fnc_unload
 *
 * Public: No
 */

params ["_vehicle", "_unit", "_args", ["_start", true]];

{
    _x params ["_xClass", "_xTurret", "_xCount"];
    if (_xTurret isEqualTo [-1]) then {
        GVAR(toUnload) pushBack [_vehicle, _unit, _xClass, _xCount];
    };
} foreach (magazinesAllTurrets _vehicle);

if (_start) then {
    [true] call FUNC(doLoadUnloadCycle);
};
