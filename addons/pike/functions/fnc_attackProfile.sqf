#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Pike mini missile ballisitc attack profile
 *
 * Arguments:
 * 0: Seeker Target PosASL <ARRAY>
 * 1: Guidance Arg Array <ARRAY>
 * 2: Attack Profile State <ARRAY>
 *
 * Return Value:
 * Missile Aim PosASL <ARRAY>
 *
 * Example:
 * [[1,2,3], [], []] call ace_pike_fnc_attackProfile
 *
 * Public: No
 */

params ["_seekerTargetPos", "_args", "_attackProfileStateParams"];
_args params ["_firedEH", "_launchParams", "", "", "_stateParams"];
_stateParams params ["", "_seekerStateParams"];
_launchParams params ["","_targetLaunchParams","_seekerType"];

_targetLaunchParams params ["", "", "_launchPos"];
_firedEH params ["","","","","","","_projectile"];

private _returnTargetPos = nil;
private _projectilePos = getPosASL _projectile;
private _projectileVel = velocity _projectile;
private _projectileSpeed = vectorMagnitude _projectileVel;

if (_attackProfileStateParams isEqualTo []) then {
    private _velNorm = vectorNormalized _projectileVel;
    private _azimuth = (_velNorm select 0) atan2 (_velNorm select 1);
    private _elevation = asin (_velNorm select 2);
    _attackProfileStateParams set [0, [_projectilePos, [0, 0, 0], _projectileSpeed, _azimuth, _elevation, CBA_missionTime]];
};

if (_seekerTargetPos vectorDistance _projectilePos < _projectileSpeed * 2) then {
    _returnTargetPos = _seekerTargetPos;
} else {
    private _expectedPosition = [_attackProfileStateParams select 0, CBA_missionTime] call FUNC(positionAtTime);
    // Recalculate if target position moved or off course
    if ((_attackProfileStateParams select 0 select 1) vectorDistance _seekerTargetPos > 0.5 || {_projectilePos vectorDistance _expectedPosition > 1}) then {
        if (_seekerTargetPos isEqualTo [0, 0, 0]) then {
            private _velNorm = vectorNormalized _projectileVel;
            private _azimuth = (_velNorm select 0) atan2 (_velNorm select 1);
            private _elevation = asin (_velNorm select 2);
            _attackProfileStateParams set [0, [_projectilePos, [0, 0, 0], _projectileSpeed, _azimuth, _elevation, CBA_missionTime]];
        } else {
            _attackProfileStateParams set [0, [_projectilePos, _seekerTargetPos, _projectileSpeed] call FUNC(calculateTrajectory)];
        };
    };
    _returnTargetPos = [_attackProfileStateParams select 0, CBA_missionTime + 1] call FUNC(positionAtTime);
};

#ifdef DEBUG_MODE_FULL
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Radar\radar_ca.paa", [0,1,0,1], ASLtoAGL _seekerTargetPos, 1, 1, 45];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Radar\radar_ca.paa", [1,0,1,1], ASLtoAGL _returnTargetPos, 1, 1, 45];

private _pos;
private _nextPos = _projectilePos;
for "_i" from 0 to 30 do {
    _pos = _nextPos;
    _nextPos = [_attackProfileStateParams select 0, CBA_missionTime + _i * 0.5] call FUNC(positionAtTime);
    drawLine3D [ASLtoAGL _pos, ASLtoAGL _nextPos, [1,0,0,1]];
};
#endif

_returnTargetPos
