#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Creates reload child actions
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [quadbike, ACE_player] call ace_weapon_mounting_fnc_reloadAction
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

private _actions = [];
private _carryMags = magazinesAmmo _unit;
{
    _carryMags set [_foreachIndex, _x select 0];
} foreach _carryMags;
private _compatibleMags = (_vehicle getVariable [QGVAR(compatMags), []]) arrayIntersect _carryMags;

{
    private _magCfg = (configFile >> "CfgMagazines" >> _x);
    private _displayName = getText (_magCfg >> "displayName");
    private _icon = getText (_magCfg >> "picture");
    
    private _action = [
        _x,
        _displayName,
        _icon,
        {call FUNC(reload)},
        {[(_this select 0), (_this select 2)] call FUNC(canReloadType)},
        {},
        _x
    ] call EFUNC(interact_menu,createAction);
    _actions pushBack [_action, [], _vehicle];
} foreach _compatibleMags;

_actions
