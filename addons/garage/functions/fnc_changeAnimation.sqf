#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Animates vehicle
 * Copied from BIS_fnc_initVehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Animation source name <STRING>
 * 2: Animation phase <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [car, "HideBumper1", 1] call ace_garage_fnc_changeAnimation
 *
 * Public: Yes
 */

params ["_vehicle", "_source", "_phase"];

private _phaseCurrent = _vehicle animationPhase _source;
private _animCfg = (configOf _vehicle >> "AnimationSources" >> _source);
if (_phase != _phaseCurrent) then {
    if (getText (_animCfg >> "source") == "door") then {
        _vehicle animateDoor [_source, _phase, true];
    } else {
        if (getNumber (_animCfg >> "useSource") == 1) then {
            _vehicle animateSource [_source, _phase, true];
        } else {
            _vehicle animate [_source, _phase, true];
        };
    };
};

//lock cargo seats
private _lockCargoSeats = [];
private _allCargoSeats = [];

private _phase = _vehicle animationPhase _source; 
if (!isNull (_animCfg >> "lockCargoAnimationPhase") && !isNull (_animCfg >> "lockCargo")) then {
    private _lockCargoAnimationPhase = getNumber(_animCfg >> "lockCargoAnimationPhase"); 
    {
        _allCargoSeats pushBackUnique _x;
        if (abs (_lockCargoAnimationPhase - _phase) < 0.001) then {_lockCargoSeats pushBackUnique _x};
    } forEach getArray (_animCfg >> "lockCargo");
};

private _code = getText(_animCfg >> "onPhaseChanged"); 
if (_code != "") then {[_vehicle, _phase] call compile _code};

{
    _vehicle lockCargo [_x, _x in _lockCargoSeats];
} forEach _allCargoSeats;
