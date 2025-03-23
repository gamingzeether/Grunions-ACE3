#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Force local unit into unconsciousness state.
 * uses some code from ace medical
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Is unconscious (optional, default: true) <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true] call ace_gforces_fnc_setUnconsciousAnim
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], "_wakeTime"];

if (!local _unit) exitWith {
    ERROR_1("Unit %1 not local or null",_unit);
};

_unit setUnconscious true;

if (!isNull objectParent _agent) then {
    ["gforces", _isUnconscious] call EFUNC(common,setDisableUserInputStatus);
    private _unconAnim = _unit call EFUNC(common,getDeathAnim);
    TRACE_2("inVehicle - playing death anim",_unit,_unconAnim);
    [_unit, _unconAnim] call EFUNC(common,doAnimation);
    
    [{
        params ["_unit"];
        private _awakeAnim = _unit call EFUNC(common,getAwakeAnim);
        TRACE_2("inVehicle - playing awake anim",_unit,_awakeAnim);
        [_unit, _awakeAnim, 2] call EFUNC(common,doAnimation);
    }, [_unit], _wakeTime] call CBA_fnc_waitAndExecute;
};
