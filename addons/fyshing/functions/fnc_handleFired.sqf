#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles fired event
 *
 * Arguments:
 * FiredEH
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_fyshing_fnc_handleFired;
 *
 * Public: No
 */

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if (!(_ammo in [QGVAR(fysh), QGVAR(fysh_explosive)])) exitWith {};

[FUNC(flop), [_projectile, side _unit], random [0.5, 0.75, 2]] call CBA_fnc_waitAndExecute;
