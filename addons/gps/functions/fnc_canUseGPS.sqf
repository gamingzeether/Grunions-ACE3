#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if player can use GPS navigation
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Can use GPS
 *
 * Example:
 * call ace_gps_fnc_canUseGPS
 *
 * Public: Yes
 */

((driver (vehicle ACE_player)) isEqualTo ACE_player) && 
{(assignedItems ACE_player select {_x call BIS_fnc_itemType select 1 == "GPS" || _x call BIS_fnc_itemType select 1 == "UAVTerminal"}) isNotEqualTo []} && 
{(typeOf vehicle ACE_player) isKindOf ["Car", configFile >> "CfgVehicles"]}
