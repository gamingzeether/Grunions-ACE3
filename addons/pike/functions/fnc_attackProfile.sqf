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
private _impactPos = [0,0,0];
private _projectilePos = getPosASL _projectile;
private _projectileVel = velocity _projectile;

if (_seekerTargetPos isEqualTo [0,0,0]) then {
    //no target or on course
    //simulate gravity
    private _velAfterGravity = _projectileVel vectorAdd [0, 0, -9.8 * 0.1 * diag_deltaTime];
    private _avgVel = _projectileVel vectorAdd _velAfterGravity; //dont need to divide because heading will be the same
    
    _projectile setVectorDir _avgVel;
    _returnTargetPos = _projectilePos vectorAdd _avgVel;
} else {
    //has target
    _impactPos = [_projectile, _seekerTargetPos] call FUNC(predictImpact);
    
    //calculate how far ahead or behind the impact position is
    private _proj2D = _projectilePos select [0,2];
    private _impact2D = _impactPos select [0,2];
    private _seeker2D = _seekerTargetPos select [0,2];
    //projectile will be origin
    _impact2D = _impact2D vectorDiff _proj2D;
    _seeker2D = _seeker2D vectorDiff _proj2D;
    //rotate points to be aligned to axis
    private _impactNormalized = vectorNormalized _impact2D;
    private _impactY = (_impact2D select 0) * (_impactNormalized select 0) + (_impact2D select 1) * (_impactNormalized select 1);
    private _seekerY = (_seeker2D select 0) * (_impactNormalized select 0) + (_seeker2D select 1) * (_impactNormalized select 1);
    
    private _distanceError = _seekerY - _impactY;
    _distanceError = _distanceError + ((_seekerTargetPos select 2) - (_impactPos select 2));
    if (!(_impactPos isEqualTo [0,0,0])) then {
        //correct course
        _returnTargetPos = _seekerTargetPos vectorAdd [0,0,_distanceError / 2];
    } else {
        //no prediction but target exists
        _returnTargetPos = _seekerTargetPos vectorAdd [0,0,sqrt(_projectilePos vectorDistance _seekerTargetPos)];
    };
};

#ifdef DEBUG_MODE_FULL
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Radar\radar_ca.paa", [0,1,0,1], ASLtoAGL _seekerTargetPos, 1, 1, 45];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Radar\radar_ca.paa", [1,0,0,1], ASLtoAGL _impactPos, 1, 1, 45];
drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Radar\radar_ca.paa", [1,0,1,1], ASLtoAGL _returnTargetPos, 1, 1, 45];
#endif

_returnTargetPos
