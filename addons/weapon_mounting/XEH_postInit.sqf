#include "script_component.hpp"

GVAR(toUnload) = [];
GVAR(toLoad) = [];
GVAR(aimRectHashMap) = createHashMap;
GVAR(controllers) = createHashMap;

GVAR(runPFH) = true;
[FUNC(vehiclePFH), 0] call CBA_fnc_addPerFrameHandler;

["turret", {
    [ACE_player] call FUNC(onVehicleChanged);
}] call CBA_fnc_addPlayerEventHandler;
["ACE_controlledUAV", {
    [ACE_player, true] call FUNC(onVehicleChanged);
}] call CBA_fnc_addEventHandler;
