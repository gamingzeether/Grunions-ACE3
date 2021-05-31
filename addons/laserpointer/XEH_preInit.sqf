#include "script_component.hpp"

{
    TRACE_1("blocking switching to unsupported laser mode",_x);
    [_x, { false }] call CBA_fnc_addAttachmentCondition;
} forEach (keys (uiNamespace getVariable QGVAR(oldLasers)));

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

["visionMode", {
    params ["", "_visionMode"];

    GVAR(isIR) = _visionMode isEqualTo 1;
    GVAR(isTI) = _visionMode isEqualTo 2;
}] call CBA_fnc_addPlayerEventHandler;

ADDON = true;
