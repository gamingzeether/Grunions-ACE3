#include "script_component.hpp"
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
if (vehicle GVAR(pathingAgent) != GVAR(pathingAgent)) then {
    deleteVehicle vehicle GVAR(pathingAgent);
};
private _vehicleCopy = createVehicle [typeOf _vehicle, [0, 0, 0]];
[_vehicleCopy, QUOTE(ADDON)] call EFUNC(common,hideUnit);
_vehicle disableCollisionWith _vehicleCopy;
_vehicleCopy setPosASL getPosASL _vehicle;
_vehicleCopy setVectorDir vectorDir _vehicle;
GVAR(pathingAgent) moveInDriver _vehicleCopy;
GVAR(pathingAgent) setDestination [_target, "LEADER PLANNED", true];
