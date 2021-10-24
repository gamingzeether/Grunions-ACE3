#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

["visionMode", {
    params ["_unit", "_visionMode"];

    GVAR(isIR) = _visionMode isEqualTo 1;
    GVAR(isTI) = _visionMode isEqualTo 2;
    
    GVAR(TIColor) = [_unit] call FUNC(getThermalsColor);
}] call CBA_fnc_addPlayerEventHandler;

#include "initSettings.sqf"

ADDON = true;
