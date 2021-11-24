#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Returns weapons that can be mounted
 *
 * Arguments:
 * 0: Player <UNIT>
 *
 * Return Value:
 * Weapons <ARRAY>
 *
 * Example:
 * [ACE_player] call ace_weapon_mounting_fnc_getMountableWeapons
 *
 * Public: No
 */

params ["_unit"];

private _normalWeapons = [];
_normalWeapons pushBack primaryWeapon _unit;
_normalWeapons pushBack handgunWeapon _unit;

private _specialWeapons = [];
_specialWeapons pushBack secondaryWeapon _unit;
_specialWeapons pushBack backpack _unit;

[_normalWeapons, _specialWeapons]
