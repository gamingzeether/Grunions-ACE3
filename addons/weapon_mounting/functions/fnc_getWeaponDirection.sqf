#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Gets direction weapon should point to
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Vector <ARRAY>
 *
 * Example:
 * [quadbike] call ace_weapon_mounting_fnc_getWeaponDirection
 *
 * Public: No
 */

params ["_vehicle"];

private _aimRect = GVAR(aimRectHashMap) get typeOf _vehicle;
private _controller = GVAR(controller) get typeOf _vehicle;

if (unitIsUAV _vehicle) then {
    private _uavControl = UAVControl _vehicle;
    if (_uavControl select 0 != ACE_player || { (_uavControl select 1) isNotEqualTo _controller }) exitWith {[]};
} else {
    if ((assignedVehicleRole ACE_player select 0) isNotEqualTo _controller) exitWith {[]};
};

private _cameraDirection = (AGLToASL positionCameraToWorld [0,0,0]) vectorFromTo (AGLToASL positionCameraToWorld [0,0,1]);
private _directionModel = _vehicle vectorWorldToModel _cameraDirection;

// Clamp direction to restriction rectangle
_aimRect params ["_azimuthOffset", "_elevationOffset", "_azimuth", "_elevation"];
private _targetAz = 0;
private _targetEl = 0;

private _curAz = (_directionModel select 0) aTan2 (_directionModel select 1);
if (_azimuth != -1) then {
    private _angleDiff = (_azimuthOffset - _curAz + 540) % 360 - 180;
    
    _targetAz = _azimuthOffset + _azimuth min (_curAz max -_azimuth);
} else {
    _targetAz = _curAz;
};

private _curEl = aSin (_directionModel select 2);
if (_elevation != -1) then {
    private _angleDiff = (_elevationOffset - _curEl + 540) % 360 - 180;
    
    _targetEl = _elevationOffset + _elevation min (_curEl max -_elevation);
} else {
    _targetEl = _curEl;
};

_vehicle vectorModelToWorld [cos _targetEl * sin _targetAz, cos _targetEl * cos _targetAz, sin _targetEl]
