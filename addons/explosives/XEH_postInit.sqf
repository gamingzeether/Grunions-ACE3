#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet
 * Initialises the player object for the explosive system.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

//Event for setting explosive placement angle/pitch:
[QGVAR(place), {
    params ["_explosive", "", "", "_unit"];

    call FUNC(setPosition);

    if (isServer) then {
        private _owner = [objNull, _unit] select (missionNamespace getVariable [QGVAR(setShotParents), false]);
        _explosive setShotParents [_owner, _unit];
    };
}] call CBA_fnc_addEventHandler;
[QGVAR(startDefuse), LINKFUNC(startDefuse)] call CBA_fnc_addEventHandler;

//When getting knocked out in medical, trigger deadman explosives:
//Event is global, only run on server (ref: ace_medical_fnc_setUnconscious)
if (isServer) then {
    [QGVAR(detonate), {
        params ["_unit", "_explosive", "_delay"];
        TRACE_3("server detonate EH",_unit,_explosive,_delay);
        private _owner = [objNull, _unit] select (missionNamespace getVariable [QGVAR(setShotParents), false]);
        _explosive setShotParents [_owner, _unit];
        [{
            params ["_explosive"];
            TRACE_1("exploding",_explosive);
            if (!isNull _explosive) then {
                [QEGVAR(common,triggerAmmo), _explosive, _explosive] call CBA_fnc_targetEvent;
            };
        }, _explosive, _delay] call CBA_fnc_waitAndExecute;
    }] call CBA_fnc_addEventHandler;

    ["ace_unconscious", {
        params ["_unit", "_isUnconscious"];
        if (!_isUnconscious) exitWith {};
        TRACE_1("Knocked Out, Doing Deadman",_unit);
        [_unit] call FUNC(onIncapacitated);
    }] call CBA_fnc_addEventHandler;

    // Orient all Editor-placed SLAM (Bottom attack) mines facing upward
    {
        private _mine = _x;
        if (typeOf _mine == "ACE_SLAMDirectionalMine_Magnetic_Ammo") then {
            [_mine, MINE_PITCH_UP, 0] call CALLSTACK(BIS_fnc_setPitchBank);
        };
    } forEach allMines;
};

if (!hasInterface) exitWith {};

#include "initKeybinds.inc.sqf"

GVAR(PlacedCount) = 0;
GVAR(Setup) = objNull;
GVAR(pfeh_running) = false;
GVAR(CurrentSpeedDial) = 0;

["ace_interactMenuOpened", {
    //Cancel placement if interact menu opened
    if (GVAR(pfeh_running)) then {
        GVAR(placeAction) = PLACE_CANCEL;
    };

    //Show defuse actions on CfgAmmos (allMines):
    call FUNC(interactEH);

}] call CBA_fnc_addEventHandler;

["unit", {
    params ["_player"];
    [_player, QGVAR(explosiveActions)] call EFUNC(common,eraseCache);
}] call CBA_fnc_addPlayerEventHandler;

["ace_allowDefuse", {
    params["_mine", "_allow"];
    [_mine, _allow] call FUNC(allowDefuse);
}] call CBA_fnc_addEventHandler;

// Cursor detonation
GVAR(explosiveIcons) = createHashMap;
GVAR(detonatorRanges) = createHashMap;
GVAR(triggerDetonator) = createHashMap;
GVAR(selectedExplosive) = [];

private _weapons = (configFile >> "CfgWeapons");
for "_i" from 0 to (count _weapons - 1) do {
    private _cfg = _weapons select _i;
    if (isClass _cfg && {getNumber (_cfg >> QGVAR(Detonator)) == 1}) then {
        private _trigger = getText (_cfg >> QGVAR(triggerType));
        GVAR(triggerDetonator) set [_trigger, configName _cfg];
    };
};

["ACE Explosives", QGVAR(CursorDetonate), [LLSTRING(CursorDetonate_DisplayName), LLSTRING(CursorDetonate_Tooltip)], {
    GVAR(cursorDetonateKeyDown) = true;
    true
}, {
    GVAR(cursorDetonateKeyDown) = false;
    
    if (GVAR(selectedExplosive) isEqualTo []) exitWith {};
    
    GVAR(selectedExplosive) params ["_explosive", "_fuseTime", "_explosiveCode", "_magazineClass", "_detonatorName"];
    [ACE_player, GVAR(detonatorRanges) get _detonatorName, [_explosive, _fuseTime], _detonatorName] call FUNC(detonateExplosive);
    
    true
}] call CBA_fnc_addKeybind;

addMissionEventHandler ["Draw3D", {
    if (GVAR(cursorDetonateKeyDown)) then {
        call FUNC(cursorDetonateHold);
    };
}];
