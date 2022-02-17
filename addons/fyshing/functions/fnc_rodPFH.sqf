#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Called from per frame handler
 *
 * Arguments:
 * 0: Bobber <OBJECT>
 * 1: Fishing line <OBJECT>
 * 2: Rope helper <OBJECT>
 * 3: Player unit <OBJECT>
 * 4: Start time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_fyshing_fnc_rodPFH;
 *
 * Public: No
 */

params ["_args", "_handle"];
_args params ["_bobber", "_line", "_helper", "_unit", "_startTime"];

private _distance = _helper distance _bobber;
private _elapsedTime = CBA_missionTime - _startTime;

private _exitCode = -1;
if (GVAR(state) == ROD_CANCEL || {!([_unit] call FUNC(canFish))}) then {
    _exitCode = 0;
} else {
    if (GVAR(reeling) && {_distance <= 1}) then {
        _exitCode = 1;
    } else {
        if (!(_bobber in ropeAttachedObjects _helper)) then {
            _exitCode = 2;
        } else {
            if (GVAR(stressedTime) > MAX_STRESS_TIME) then {
                _exitCode = 3;
            };
        };
    };
};

if (_exitCode != -1 && {_elapsedTime > 0.5}) exitWith {
    private _message = ["", LLSTRING(Caught), LLSTRING(HookBroke), LLSTRING(LineBroke)] select _exitCode;
    if (_exitCode == 1) then {
        private _caughtFish = [_bobber] call FUNC(getCaughtFish);
        ["ace_caughtFish", [ACE_player, _caughtFish]] call CBA_fnc_globalEvent;
        
        if (_caughtFish isNotEqualTo "nothing") then {
            [_unit, selectRandom [QGVAR(fysh), QGVAR(fysh_explosive)], true] call CBA_fnc_addItem;
            _caughtFish = "a " + _caughtFish;
        };
        _message = format [_message, _caughtFish];
    };
    
    if (_message != "") then {
        [_message] call EFUNC(common,displayText);
    };
    
    [_handle] call CBA_fnc_removePerFrameHandler;
    GVAR(PFHRunning) = false;
    deleteVehicle _bobber;
    deleteVehicle _helper;
    ropeDestroy _line;
    private _attachedFish = _bobber getVariable [QGVAR(attachedFish), []];
    {deleteVehicle _x} foreach _attachedFish;
    
    if (currentWeapon _unit == QGVAR(fyshingRod) && {([_unit] call FUNC(canFish))}) then {
        GVAR(state) = ROD_WAIT;
    };
};

if (GVAR(reeling)) then {
    ropeUnwind [_line, 5, (_distance - 1) max (ropeLength _line - 1)];
};

private _pos = _unit selectionPosition ["proxy:\a3\characters_f\proxies\pistol.001", 1];
private _weaponDirAndUp = _unit selectionVectorDirAndUp ["proxy:\a3\characters_f\proxies\pistol.001", 1];
private _v2 = _unit vectorModelToWorld (_weaponDirAndUp select 0); //right
private _v3 = _unit vectorModelToWorld (_weaponDirAndUp select 1); //top
private _v1 = _v3 vectorCrossProduct _v2;                          //forward

_offset = (_v1 vectorMultiply 1.2) vectorAdd (_v2 vectorMultiply -0.2) vectorAdd (_v3 vectorMultiply 0.3);
_pos = _unit modelToWorldWorld _pos;
_pos = _pos vectorAdd _offset;
_helper setPosASL _pos;
