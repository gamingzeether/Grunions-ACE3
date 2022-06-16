#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Makes a fysh flop around
 * Tries to flop towards an enemy of _side
 *
 * Arguments:
 * 0: Projectile <OBJECT>
 * 1: Side to ignore <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [fysh, west] call ace_fyshing_fnc_flop;
 *
 * Public: No
 */

params ["_projectile", "_side"];

if (isNull _projectile) exitWith {};

if (vectorMagnitude velocity _projectile > 0.1) exitWith {
    [FUNC(flop), [_projectile, _side], random [0.5, 0.75, 2]] call CBA_fnc_waitAndExecute;
};

private _pos = getPosASL _projectile;

private _nearTargets = _pos nearEntities ["Man", 100];
_nearTargets = _nearTargets select {
    (alive _x) && 
    {[side _x, _side] call BIS_fnc_sideIsEnemy}
};

private _targetPos = [];
private _dist = 10;
if (_nearTargets isEqualTo []) then {
    _targetPos = _pos vectorAdd [random [-5, 0, 5], random [-5, 0, 5], random [-5, 0, 5]];
} else {
    // select closest target
    private _target = _nearTargets select 0;
    _dist = _target distance _projectile;
    {
        private _dist2 = _x distance _projectile;
        if (_dist2 < _dist) then {
            _target = _x;
            _dist = _dist2;
        };
    } foreach _nearTargets;
    _targetPos = (aimPos _target) vectorAdd (velocity _target);
    _dist = _targetPos distance _projectile;
};

// flop towards target
private _torque = [random [-1, 0, 1], random [-1, 0, 1], random [-1, 0, 1]];
_torque = _torque vectorMultiply 5;
_projectile addTorque _torque;

private _vel = (_pos vectorFromTo _targetPos) vectorMultiply (_dist min (5 + random 5));
_vel set [2, (_vel select 2) + 5];
_vel vectorAdd (_torque vectorMultiply 0.5);
_projectile setVelocity _vel;

[FUNC(flop), [_projectile, _side], random [0.5, 0.75, 2]] call CBA_fnc_waitAndExecute;
