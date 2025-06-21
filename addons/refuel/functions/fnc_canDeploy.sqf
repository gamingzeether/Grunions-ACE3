#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if unit can deploy fuel container
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Can deploy <BOOL>
 *
 * Example:
 * [ACE_player] call ace_refuel_fnc_canDeploy
 *
 * Public: Yes
 */
 
params ["_unit"];

(alive _unit) && 
{handgunWeapon _unit isKindOf [QGVAR(ContainerWeaponBase), configFile >> "CfgWeapons"]} && 
{!lineIntersects [eyePos _unit, eyePos _unit vectorAdd eyeDirection _unit, _unit]}
