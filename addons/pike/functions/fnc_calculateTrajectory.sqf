#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Calculates trajectory for pike to follow
 *
 * Arguments:
 * 0: Projectile position ASL <ARRAY>
 * 1: Target position ASL <ARRAY>
 * 2: Projectile speed <NUMBER>
 *
 * Return Value:
 * Trajectory info <ARRAY>
 * 0: Start position ASL <ARRAY>
 * 1: Target position ASL <ARRAY>
 * 2: Projectile speed <NUMBER>
 * 3: Target azimuth <NUMBER>
 * 4: Target elevation <NUMBER>
 * 5: Time of calculation <NUMBER>
 *
 * Example:
 * [[0,0,0], [10,0,0], 10] call ace_pike_fnc_calculateTrajectory
 *
 * Public: No
 */

params ["_startPos", "_targetPos", "_speed"];

private _offset = _targetPos vectorDiff _startPos;
private _heightOffset = _offset select 2;
private _distance2D = [0, 0, 0] distance2D _offset;

private _azimuth = (_offset select 0) atan2 (_offset select 1);

private _d = (_speed * _speed * _speed * _speed) - TRAJECTORY_GRAVITY * (TRAJECTORY_GRAVITY * _distance2D * _distance2D + 2 * _speed * _speed * _heightOffset);
private _sqrt = sqrt _d;
// Only need 1 solution and low usually has shorter time to impact
private _elevationLow  = atan ((_speed * _speed - _sqrt) / (TRAJECTORY_GRAVITY * _distance2D));
// private _elevationHigh = atan ((_speed * _speed + _sqrt) / (TRAJECTORY_GRAVITY * _distance2D));

[_startPos, _targetPos, _speed, _azimuth, [45, _elevationLow] select (_d >= 0), CBA_missionTime]
