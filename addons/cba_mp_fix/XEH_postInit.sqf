#include "script_component.hpp"

if (!hasInterface || {!isMultiplayer}) exitWith {};

0 spawn {
    sleep 5;
    if (CBA_missionTime > 0) exitWith {};
    CBA_missionTime = diag_tickTime;
    GVAR(lastTickTime) = diag_tickTime;
    [{
        private _tickTime = diag_tickTime;
        CBA_missionTime = CBA_missionTime + (_tickTime - GVAR(lastTickTime));
        GVAR(lastTickTime) = _tickTime;
    }, 0] call CBA_fnc_addPerFrameHandler;
};
