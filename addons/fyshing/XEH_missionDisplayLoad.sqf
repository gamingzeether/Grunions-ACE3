#include "script_component.hpp"

params ["_display"];

_display displayAddEventHandler ["MouseButtonDown", {
    if ((_this select 1) == 0) then {
        if ([_unit] call FUNC(canFish)) then {
            if (GVAR(state) == ROD_WAIT) then {
                [ACE_player, (getCameraViewDirection ACE_player) vectorMultiply 25] call FUNC(castRod);
                GVAR(state) = ROD_CAST;
            } else {
                GVAR(reeling) = true;
            };
        };
    } else {
        if (GVAR(PFHRunning) && {(_this select 1) == 1}) then {
            GVAR(state) = ROD_CANCEL;
        };
    };
}];
_display displayAddEventHandler ["MouseButtonUp", {
    if (GVAR(PFHRunning) && {(_this select 1) == 0}) then {
        GVAR(reeling) = false;
    };
}];
