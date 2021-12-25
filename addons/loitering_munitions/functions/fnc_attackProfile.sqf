#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Loitering munition default attack profile
 *
 * Arguments:
 * 0: Target ASL <ARRAY>
 * 1: Guidance args <ARRAY>
 * 2: Attack state params <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[1,2,3], []] call ace_loitering_munitions_fnc_attackProfile
 *
 * Public: No
 */

#define MEMORY_LENGTH 120

params ["_seekerTargetPos", "_args", "_attackProfileStateParams"];
_args params ["_firedEH"];

if (_attackProfileStateParams isEqualTo []) then {
    _firedEH params ["_shooter","","","","_ammo","","_projectile"];
    
    if (isNil QGVAR(startPosWorld)) then {
        GVAR(startPosWorld) = getPosASL _shooter;
    };
    if (isNil QGVAR(radius)) then {
        GVAR(radius) = (call FUNC(getLoiterDistance)) select 0;
    };
    if (isNil QGVAR(altitude)) then {
        GVAR(altitude) = (getPosASL ACE_player select 2) + 100;
    };
    
    _attackProfileStateParams set [0, STATE_GAINALT];
    _attackProfileStateParams set [1, getPosASL _shooter];
    _attackProfileStateParams set [2, GVAR(startPosWorld)];
    _attackProfileStateParams set [3, GVAR(radius)];
    _attackProfileStateParams set [4, GVAR(altitude)];
    _attackProfileStateParams set [5, getNumber (configOf _projectile >> QUOTE(ADDON) >> "minTerrainHeight")];
    
    _attackProfileStateParams set [6, [0]];
    _attackProfileStateParams set [7, 0];
};
_attackProfileStateParams params ["_state", "_launchPos", "_loiterCenter", "_loiterRadius", "_loiterHeight", "_minHeight", "_heightValues", "_counter"];

private _returnTargetPos = [0, 0, 0];

private _projectilePos = getPosASL _projectile;
switch (_state) do {
    case STATE_GAINALT: {
        private _heightAboveLaunch = (_projectilePos select 2) - (_launchPos select 2);
        
        if (_heightAboveLaunch >= _loiterHeight * (2 / 3)) then {
            _attackProfileStateParams set [0, STATE_LOITER];
        };
        
        _returnTargetPos = _projectilePos vectorAdd [0.1, 0.1, 100];
    };
    case STATE_LOITER: {
        private _relPosToCenter = _loiterCenter vectorFromTo _projectilePos;
        private _nextAngle = ((_relPosToCenter select 0) aTan2 (_relPosToCenter select 1)) + 10;
        
        private _targetHeight = _loiterHeight;
        if (_minHeight != -1) then {
            private _maxTerrHeight = selectMax _heightValues;
            
            _heightValues set [_counter, 0 max getTerrainHeightASL (_projectilePos vectorAdd velocity _projectile)];
            _attackProfileStateParams set [7, (_counter + 1) % MEMORY_LENGTH];
            
            _targetHeight = _loiterHeight max (_maxTerrHeight + _minHeight);
        };
        private _targetPos = _loiterCenter vectorAdd [_loiterRadius * sin _nextAngle, _loiterRadius * cos _nextAngle];
        _returnTargetPos = _projectilePos vectorAdd ((_projectilePos vectorFromTo _targetPos) vectorMultiply (vectorMagnitude velocity _projectile));
        _returnTargetPos set [2, _targetHeight];
        
        if (_seekerTargetPos isNotEqualTo [0,0,0]) then {
            _attackProfileStateParams set [0, STATE_ATTACK];
        };
    };
    case STATE_ATTACK: {
        systemchat str _seekerTargetPos;
        if (_seekerTargetPos isNotEqualTo [0,0,0]) then {
            _returnTargetPos = _seekerTargetPos vectorAdd [0, 0, -0.2];
        } else {
            _returnTargetPos = _projectilePos vectorAdd (_projectile vectorModelToWorld [0, 50, 0])
        };
    };
};

_returnTargetPos
