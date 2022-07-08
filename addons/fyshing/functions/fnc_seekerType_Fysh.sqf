#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Seeker Type: Fysh
 *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[], [], []] call ace_fyshing_fnc_seekerType_Fysh;
 *
 * Public: No
 */

params ["", "_args", "_seekerStateParams"];
_args params ["_firedEH", "_launchParams", "", "_seekerParams", "_stateParams"];
_firedEH params ["_shooter","","","","","","_projectile"];
_launchParams params ["", "_targetParams"];
_targetParams params ["_target"];
_seekerParams params ["_seekerAngle", "", "_seekerMaxRange"];
_seekerStateParams params ["_lastPoll"];

if (isNil "_target" || {isNull _target}) then {
    _target = objNull;
    
    if (CBA_missionTime - _lastPoll > 2) then {
        private _nearTargets = (position _projectile) nearEntities [["Man", "Car", "Tank"], _seekerMaxRange];
        
        if (_nearTargets isEqualTo []) exitWith {[0, 0, 0]};
        
        private _shooterSide = side _shooter;
        _nearTargets = _nearTargets select {
            {alive _x} && 
            {[_projectile, aimPos _x, _seekerAngle] call EFUNC(missileguidance,checkSeekerAngle)} && 
            {[_projectile, _x] call EFUNC(missileguidance,checkLos)} && 
            {[side _x, _shooterSide] call BIS_fnc_sideIsEnemy}
        };
        
        _target = selectRandom _nearTargets;
    };
    
    _targetParams set [0, _target];
};

if (isNull _target) exitWith {[0, 0, 0]};
if (!alive _target) exitWith {_target = objNull};

private _foundTargetPos = aimPos _target;

// Can't see target, return [0,0,0] and let doSeekerSearch handle it
if (!(([_projectile, _foundTargetPos, _seekerAngle] call EFUNC(missileguidance,checkSeekerAngle)) &&
    {[_projectile, _target] call EFUNC(missileguidance,checkLos)})) exitWith {
    _targetParams set [0, objNull];
    [0, 0, 0]
};

TRACE_2("", _target, _foundTargetPos);
// @TODO: Configurable lead for seekers
private _projectileSpeed = (vectorMagnitude velocity _projectile);
private _distanceToTarget = (getPosASL _projectile) vectorDistance _foundTargetPos;
private _eta = _distanceToTarget / _projectileSpeed;

private _adjustDistance = (velocity _target) vectorMultiply _eta;
TRACE_3("leading target",_distanceToTarget,_eta,_adjustDistance);
_foundTargetPos = _foundTargetPos vectorAdd _adjustDistance;

TRACE_2("return",_foundTargetPos,(aimPos _target) distance _foundTargetPos);
_foundTargetPos;
