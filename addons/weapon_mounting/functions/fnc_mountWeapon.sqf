#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Mounts a weapon on a vehicle and initilizes it 
 *
 * Arguments:
 * 0: CfgWeapons classname <STRING>
 * 1: Vehicle <OBJECT>
 * 2: Mounting position (Default: []) <ARRAY>
 * 3: Weapon model (Default: "") <STRING>
 * 4: Model scale (Default: 1) <NUMBER>
 * 5: Original weapon (Default: "") <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["MMG_01_base_F", quadbike] call ace_weapon_mounting_fnc_mountWeapon
 *
 * Public: Yes
 */

params ["_weaponName", "_vehicle", ["_mountingPosition", []], ["_weaponModel", ""], ["_modelScale", 1], ["_originalWeapon", ""]];

private _wCfg = (configFile >> "CfgWeapons" >> _weaponName);
private _vCfg = configOf _vehicle;

if (_originalWeapon == "") then {
    _originalWeapon = _weaponName;
};
if (_mountingPosition isEqualTo []) then {
    private _mountingPositions = _vehicle getVariable QGVAR(freePositions);
    if (isNil "_mountingPositions") then {
        _mountingPositions = getArray (_vCfg >> QGVAR(mountingPositions));
        if (_mountingPositions isEqualTo []) exitWith {};
        _mountingPosition = _mountingPositions deleteAt 0;
        
        _vehicle setVariable [QGVAR(freePositions), _mountingPositions, true];
    } else {
        if (_mountingPositions isEqualTo []) exitWith {};
        _mountingPosition = _mountingPositions select 0;
    };
};

// Attach weapon model
if (_weaponModel == "") then {
    _weaponModel = getText (_wCfg >> "model");
};
private _weapon = createSimpleObject [_weaponModel, [0,0,0]];
_weapon setObjectScale _modelScale;
_weapon attachTo [_vehicle, _mountingPosition];

private _vForward = vectorDir _vehicle;
private _vUp = vectorUp _vehicle;
private _vRight = _vForward vectorCrossProduct _vUp;
_weapon setVectorDirAndUp [_vRight, _vUp];

private _flashSelection = getText (_wCfg >> "selectionFireAnim");
_weapon hideSelection [_flashSelection, true];

// Set variables
private _mags = [_weaponName, true] call CBA_fnc_compatibleMagazines;

/*
_mags = _mags select {
    private _mCfg = (configFile >> "CfgMagazines" >> _x);
    private _type = getNumber (_mCfg >> "type");
    getNumber (_mCfg >> "scope") == 2 && {_type == 256 || {_type == 16}}
};
*/
private _muzzlePos = (_weapon selectionPosition (getText (_wCfg >> "muzzlePos"))) vectorMultiply 1.1;

_weapon setVariable [QGVAR(config), _wCfg, true];
_weapon setVariable [QGVAR(muzzlePos), _muzzlePos, true];
_weapon setVariable [QGVAR(flashSelection), _flashSelection, true];
_weapon setVariable [QGVAR(originalWeapon), _originalWeapon, true];

_vehicle setVariable [QGVAR(compatMags), _mags];
_vehicle setVariable [QGVAR(mountedWeapon), _weapon, true];

// Add weapon turret to vehicle
_vehicle addWeaponTurret [_weaponName, [-1]];
_vehicle selectWeaponTurret [_weaponName, [-1]];

/*
private _vehWeapons = _vehicle weaponsTurret [-1];
_vehWeapons = _vehWeapons select {"horn" in toLower _x};
{
    _vehicle removeWeaponTurret [_x, [-1]];
} foreach _vehWeapons;
*/

// Add reload / unload actions
private _dummyName = format [QGVAR(dummy_%1), _weaponName];
private _dummyAction = [
    _dummyName,
    getText (_wCfg >> "displayName"),
    "",
    {},
    {true},
    {},
    nil,
    _mountingPosition,
    4
] call EFUNC(interact_menu,createAction);
private _reloadAction = [
    QGVAR(reload),
    LLSTRING(reload_displayName),
    "",
    {},
    {call FUNC(canReload)},
    {call FUNC(reloadAction)},
    nil,
    _mountingPosition,
    4
] call EFUNC(interact_menu,createAction);
private _unloadAction = [
    QGVAR(unload),
    LLSTRING(unload_displayName),
    "",
    {call FUNC(unload)},
    {call FUNC(canUnload)},
    {},
    nil,
    _mountingPosition,
    4
] call EFUNC(interact_menu,createAction);
private _unmountAction = [
    format [QGVAR(unmount), _weaponName],
    format [LLSTRING(unmountAction_displayName), getText (_wCfg >> "displayName")],
    "",
    {call FUNC(unmountWeapon)},
    {true},
    {},
    _weaponName,
    _mountingPosition,
    4
] call EFUNC(interact_menu,createAction);

[_vehicle, 0, [], _dummyAction] call EFUNC(interact_menu,addActionToObject);
[_vehicle, 0, [_dummyName], _reloadAction] call EFUNC(interact_menu,addActionToObject);
[_vehicle, 0, [_dummyName], _unloadAction] call EFUNC(interact_menu,addActionToObject);
[_vehicle, 0, [_dummyName], _unmountAction] call EFUNC(interact_menu,addActionToObject);

// Add events
_vehicle setVariable [QGVAR(eventFired), _vehicle addEventHandler ["Fired", {
    _this call FUNC(firedWeapon);
}]];
_vehicle setVariable [QGVAR(eventGetIn), _vehicle addEventHandler ["GetIn", {
    params ["_vehicle", "", "_unit"];
    
    [_vehicle, _unit] call FUNC(onVehicleChanged);
}]];
_vehicle setVariable [QGVAR(eventGetOut), _vehicle addEventHandler ["GetOut", {
    params ["_vehicle", "", "_unit"];
    
    [_vehicle, _unit] call FUNC(onVehicleChanged);
}]];
_vehicle setVariable [QGVAR(eventSeatSwitched), _vehicle addEventHandler ["SeatSwitched", {
    params ["_vehicle", "_unit"];
    
    [_vehicle, _unit] call FUNC(onVehicleChanged);
}]];
_vehicle setVariable [QGVAR(eventMPKilled), _vehicle addMPEventHandler ["MPKilled", {
    _this call FUNC(handleVehicleDestroyed);
}]];
