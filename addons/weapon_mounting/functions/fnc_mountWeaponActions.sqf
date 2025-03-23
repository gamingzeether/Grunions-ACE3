#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Creates child actions for mounting weapons
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <UNIT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [quadbike, ACE_player] call ace_weapon_mounting_fnc_mountWeaponActions
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

private _actions = [];

private _weapons = [_unit] call FUNC(getMountableWeapons);

{
    private _wCfg = (configFile >> "CfgWeapons" >> _x);
    private _displayName = getText (_wCfg >> "displayName");
    private _icon = getText (_wCfg >> "picture");
    
    private _action = [
        _x,
        _displayName,
        _icon,
        {call FUNC(mountProgressBar)},
        {
            params ["_vehicle", "_unit", "_weapon"];
            [_weapon, _vehicle] call FUNC(canMountWeapon);
        },
        {},
        _x
    ] call EFUNC(interact_menu,createAction);
    _actions pushBack [_action, [], _vehicle];
} forEach (_weapons select 0);

// Special weapons
{
    private _properties = [_x] call FUNC(getSpecialWeaponProperties);
    _properties params ["_displayName", "_icon", "_wName", "_model", "_scale", "_type"];
    if (_type == WEAPONMOUNTING_TYPE_FAIL) then {continue};
    
    private _action = [
        _wName,
        _displayName,
        _icon,
        {call FUNC(mountProgressBarSpecial)},
        {true},
        {},
        [_x, _wName, _model, _scale, _type]
    ] call EFUNC(interact_menu,createAction);
    _actions pushBack [_action, [], _vehicle];
} forEach (_weapons select 1);

_actions
