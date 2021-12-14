#include "script_component.hpp"

GVAR(toUnload) = [];
GVAR(toLoad) = [];
GVAR(pfhHandle) = -1;
GVAR(aimRectHashMap) = createHashMap;
GVAR(controllers) = createHashMap;

["turret", {
    [ACE_player] call FUNC(onVehicleChanged);
}] call CBA_fnc_addPlayerEventHandler;
["ACE_controlledUAV", {
    [ACE_player, true] call FUNC(onVehicleChanged);
}] call CBA_fnc_addEventHandler;
