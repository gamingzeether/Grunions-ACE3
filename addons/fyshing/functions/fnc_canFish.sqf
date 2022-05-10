#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if a player can fish
 *
 * Arguments:
 * Player unit <OBJECT>
 *
 * Return Value:
 * Can fish <BOOL>
 *
 * Example:
 * [ACE_Player] call ace_fyshing_fnc_canFish;
 *
 * Public: Yes
 */

params ["_unit"];

([_unit, objNull, ["notonmap", "isnotinside"]] call EFUNC(common,canInteractWIth)) && 
{_unit call CBA_fnc_canUseWeapon} && 
{isNull (ACE_controlledUAV select 0)} &&
{!weaponLowered _unit}
