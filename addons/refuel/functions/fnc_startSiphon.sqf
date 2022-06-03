#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Starts siphoning fuel from vehicle that container is attached to
 *
 * Arguments:
 * 0: Container <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [container] call ace_refuel_fnc_startSiphon
 *
 * Public: No
 */

params ["_container", "_player"];

private _siphonTarget = _container getVariable [QGVAR(sink), objNull];
if (isNull _siphonTarget) exitWith {};

// Calculate time
private _capacity = _container getVariable [QGVAR(capacity), 0];
private _currentFuelContainer = [_container] call FUNC(getFuel);
private _config = configFile >> "CfgVehicles" >> typeOf _siphonTarget;
private _targetMaxFuel = getNumber (_config >> QGVAR(fuelCapacity));
if (_targetMaxFuel == 0) then {
    _targetMaxFuel = getNumber (_config >> "fuelCapacity");
};
private _currentFuelTarget = fuel _siphonTarget * _targetMaxFuel;
private _refuelTime = ((_capacity - _currentFuelContainer) min _currentFuelTarget) / GVAR(rate);

[LLSTRING(SiphonStarted)] call EFUNC(common,displayTextStructured);

// Prevent container from being picked up
_container setVariable [QGVAR(isSiphoning), true, true];

[{
    params ["_container", "_siphonTarget", "_startTime"];
    
    private _elapsedTime = CBA_missionTime - _startTime;
    
    // Set container fuel
    private _capacity = _container getVariable [QGVAR(capacity), 0];
    private _currentFuelContainer = [_container] call FUNC(getFuel);
    private _fuelTransferred = (_capacity - _currentFuelContainer) min (_elapsedTime * GVAR(rate));
    [_container, _currentFuelContainer + _fuelTransferred] call FUNC(setFuel);
    
    // Set target fuel
    private _config = configFile >> "CfgVehicles" >> typeOf _siphonTarget;
    private _targetMaxFuel = getNumber (_config >> QGVAR(fuelCapacity));
    if (_targetMaxFuel == 0) then {
        _targetMaxFuel = getNumber (_config >> "fuelCapacity");
    };
    private _currentFuelTarget = fuel _siphonTarget * _targetMaxFuel;
    [QEGVAR(common,setFuel), [_siphonTarget, (_currentFuelTarget - _fuelTransferred) / _targetMaxFuel], _siphonTarget] call CBA_fnc_targetEvent;
    
    [LLSTRING(SiphonCompleted)] call EFUNC(common,displayTextStructured);
    
    _container setVariable [QGVAR(isSiphoning), false, true];
}, [_container, _siphonTarget, CBA_missionTime], _refuelTime] call CBA_fnc_waitAndExecute;
