#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Handles vehicle turret fired
 *
 * Arguments:
 * Fired Event args
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_weapon_mounting_fnc_firedWeapon
 *
 * Public: No
 */

params ["_vehicle", "_wepName", "", "", "", "", "_projectile", "_gunner"];

if (!local _projectile) exitWith {};

private _weapon = _vehicle getVariable [QGVAR(mountedWeapon), objNull];

if (isNull _weapon) exitWith {};
if (configName (_weapon getVariable QGVAR(config)) != _wepName) exitWith {};

private _muzzlePos = _weapon getVariable QGVAR(muzzlePos);

// set projectile new velocity and position
// because vectorDir points to the right side of the model, the real weapon direction is actually to the left
private _vec = (vectorNormalized vectorUp _weapon) vectorCrossProduct (vectorNormalized vectorDir _weapon);

_projectile setPosASL (_weapon modelToWorldVisualWorld _muzzlePos);
_projectile setVectorDir _vec;
_projectile setVelocity (_vec vectorMultiply (vectorMagnitude velocity _projectile));

// weapon flash effect
private _flashSelection = _weapon getVariable [QGVAR(flashSelection), ""];
_weapon hideSelection [_flashSelection, false];
[{
    params ["_weapon", "_sel"];
    _weapon hideSelection [_sel, true];
}, [_weapon, _flashSelection]] call CBA_fnc_execNextFrame;
