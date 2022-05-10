#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles GPS map double click
 *
 * Arguments:
 * onMouseButtonDblClick event args
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_onMouseButtonDblClick
 *
 * Public: No
 */

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

if (_button == 0 && {!GVAR(findingPath)} && {call FUNC(canUseGPS)}) then {
    private _playerPos = getPosASL ACE_player;
    private _clickPos = _control ctrlMapScreenToWorld [_xPos, _yPos];
    
    GVAR(activeNavMarkers) = [];
    GVAR(turns) = [];
    GVAR(nextMarkerIndex) = -1;
    GVAR(nextTurnIndex) = -1;
    [vehicle ACE_player, _clickPos] call FUNC(findPathTo);
    ["StatusPathingStart", 3, "Status"] call FUNC(sayVoiceLine);
};
