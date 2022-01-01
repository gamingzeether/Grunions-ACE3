#include "script_component.hpp"

params ["_display"];

_display displayAddEventHandler ["MouseZChanged", FUNC(reel)];
_display displayAddEventHandler ["MouseButtonDown", {
    if (GVAR(PFHRunning) && {(_this select 1) == 1}) then {
        GVAR(state) = ROD_CANCEL;
    };
    if ((_this select 1) == 0) then {
        if (GVAR(state) == ROD_WAIT && {[_unit] call FUNC(canFish)}) then {
            [ACE_player, (getCameraViewDirection ACE_player) vectorMultiply 25] call FUNC(castRod);
            GVAR(state) = ROD_CAST;
        };
    };
}];
