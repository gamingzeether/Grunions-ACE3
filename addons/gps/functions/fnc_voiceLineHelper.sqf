#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Works through voice prompt queue until it is empty
 * 
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_voiceLineHelper
 *
 * Public: No
 */

if (count GVAR(voiceLineQueue) == 0) exitWith {
    GVAR(speakerHelperActive) = false;
};
private _queueItem = GVAR(voiceLineQueue) select 0;
GVAR(voiceLineQueue) deleteAt 0;
_queueItem params ["_sound", "_waitTime"];
playSound [_sound, true];
[{
    call FUNC(voiceLineHelper);
}, nil, _waitTime] call CBA_fnc_waitAndExecute;
