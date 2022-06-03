#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Deploys unit's fuel container
 * Must be executed where unit is local
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_refuel_fnc_deployContainer
 *
 * Public: No
 */
 
params ["_unit"];

// Get information about container
private _handgun = handgunWeapon _unit;
private _isEmpty = (_handgun == getText (configFile >> "CfgWeapons" >> _handgun >> QGVAR(empty)));
private _capacity = getNumber (configFile >> "CfgWeapons" >> _handgun >> QGVAR(capacity));
private _vehicle = getText (configFile >> "CfgWeapons" >> _handgun >> QGVAR(vehicle));

_unit removeWeapon _handgun;

// Create container
private _container = createVehicle [_vehicle, [0, 0, 0]];
_container setPosASL (getPosASL _unit vectorAdd vectorDir _unit);
[_container, _capacity] call FUNC(makeJerryCan);
if (_isEmpty) then {
    [_container, 0] call FUNC(setFuel);
};
_container setVariable [QGVAR(weapon), _handgun, true];

// Add pickup action to container
private _pickupAction = [
    QGVAR(pickupContainer),
    LLSTRING(Pickup),
    QPATHTOF(ui\icon_refuel_interact.paa),
    FUNC(pickupContainer),
    {
        params ["_container", "_player"];
        [_player, _container] call FUNC(canDisconnect)
    }
] call EFUNC(interact_menu,createAction);
[_container, 0, ["ACE_MainActions", QGVAR(Refuel)], _pickupAction] call EFUNC(interact_menu,addActionToObject);

// Add siphoning action
private _siphonAction = [
    QGVAR(startSiphon),
    LLSTRING(Siphon),
    QPATHTOF(ui\icon_refuel_interact.paa),
    FUNC(startSiphon),
    {
        params ["_container", "_player"];
        (!isNull (_container getVariable [QGVAR(sink), objNull])) &&
        {!(_container getVariable [QGVAR(isRefueling), false])} &&
        {!(_container getVariable [QGVAR(isSiphoning), false])} &&
        {_container getVariable QGVAR(capacity) > [_container] call FUNC(getFuel)}
    }
] call EFUNC(interact_menu,createAction);
[_container, 0, ["ACE_MainActions", QGVAR(Refuel)], _siphonAction] call EFUNC(interact_menu,addActionToObject);
