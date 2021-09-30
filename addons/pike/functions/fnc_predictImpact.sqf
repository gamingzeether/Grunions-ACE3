#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Predicts the closest intercept position of a missile
 * Assumes no thrust and no changes to direction other than simulated gravity
 *
 * Arguments:
 * 0: Projectile <OBJECT>
 * 1: Target position ASL <ARRAY>
 *
 * Return Value:
 * Closest intercept position ASL <ARRAY>
 *
 * Example:
 * [missile, getPosASL target] call ace_pike_fnc_predictImpactPos
 *
 * Public: Yes
 */

params ["_missile", "_target"];

#define PHYS_STEP 0.1

private _returnValue = [0,0,0];
private _closestDistance = 10e10;
private _config = configOf _missile;
private _velocity = velocity _missile;
private _position = getPosASL _missile;
private _speed = speed _missile;

private _airFriction = getNumber (_config >> "airFriction");
private _maxSpeed = getNumber (_config >> "maxSpeed");

for "_i" from 0 to 40 step PHYS_STEP do {
    //copy simulated gravity
    private _velAfterGravity = _velocity vectorAdd [0, 0, -9.8 * 0.1 * PHYS_STEP];
    private _newHeading = vectorNormalized (_velocity vectorAdd _velAfterGravity);
    
    _speed = _speed + ((_airFriction * -0.002 * _speed^2) * PHYS_STEP);
    private _gravitySpeedChange = (_newHeading select 2) * -9.8 * PHYS_STEP;
    _speed = _maxSpeed min (vectorMagnitude _velocity + _gravitySpeedChange);
    //set new velocity
    _velocity = _newHeading vectorMultiply _speed;
    private _nextPos = _position vectorAdd (_velocity vectorMultiply PHYS_STEP);
    
    private _intersects = lineIntersectsSurfaces [_position, _nextPos, _missile];
    
    #ifdef DEBUG_MODE_FULL
    drawLine3D [ASLtoAGL _position, ASLtoAGL _nextPos, [1,1,1,1]];
    #endif
    
    private _newDistance = _nextPos vectorDistance _target;
    if (_newDistance < _closestDistance) then {
        _closestDistance = _newDistance;
    };
    if (_newDistance > _closestDistance) exitWith {
        _returnValue = _position;
    };
    
    if (count _intersects > 0) exitWith {
        _returnValue = (_intersects select 0 select 0);
    };
    _position = _nextPos;
};

_returnValue
