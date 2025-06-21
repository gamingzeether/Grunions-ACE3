#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Finds a path to target position and triggers pathing event
 *
 * Arguments:
 * 0: Vehicle to copy <OBJECT>
 * 1: End position <ARRAY>
 *
 * Return Value:
 * None (Pathing agent event is triggered instead)
 *
 * Example:
 * [vehicle ACE_player, getPosASL goal] call ace_gps_fnc_findPathTo
 *
 * Public: No
 */

params ["_vehicle", "_target"];

GVAR(findingPath) = true;
deleteVehicle vehicle GVAR(pathingAgent);
deleteVehicle GVAR(pathingAgent);
GVAR(pathingAgent) = calculatePath [typeOf _vehicle, "SAFE", getPosASL ACE_player, _target];
GVAR(pathingAgent) addEventHandler ["PathCalculated", {
    params ["_agent", "_path"];
    if (!GVAR(findingPath)) exitWith {};
    GVAR(findingPath) = false;
    GVAR(activeNavMarkers) = _path;
    call FUNC(startNavigation);
    
    // Reset agent
    if (!isNull objectParent _agent) then {
        deleteVehicle vehicle _agent;
    };
    deleteVehicle _agent;
}];
