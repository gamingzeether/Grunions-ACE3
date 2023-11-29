#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Calculates expected position on trajectory at time
 *
 * Arguments:
 * 0: Trajectory info <ARRAY>
 * 1: Current time
 *
 * Return Value:
 * Expected position ASL <ARRAY>
 *
 * Example:
 * [[], CBA_missionTime] call ace_pike_fnc_positionAtTime
 *
 * Public: No
 */

params ["_trajectoryInfo", "_curTime"];
_trajectoryInfo params ["_startPos", "_targetPos", "_speed", "_azimuth", "_elevation", "_calcTime"];

private _timeDiff = _curTime - _calcTime;
private _distance2D = _speed * _timeDiff * cos _elevation;
private _height = _speed * _timeDiff * (sin _elevation) - (TRAJECTORY_GRAVITY * _timeDiff * _timeDiff) / 2;
private _offsetFromStart = [(sin _azimuth) * _distance2D, (cos _azimuth) * _distance2D, _height];

(_startPos vectorAdd _offsetFromStart)
