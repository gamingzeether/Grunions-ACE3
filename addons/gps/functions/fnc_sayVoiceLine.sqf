#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Says voice prompt
 *
 * Arguments:
 * 0: Voice line <STRING>
 * 1: Time <NUMBER>
 * 2: Type of voice line (Default: "") <STRING>
 * 3: Remove other lines in queue with type (Default: false) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["StatusDestinationReached", 3] call ace_gps_fnc_sayVoiceLine
 *
 * Public: Yes
 */

params ["_voiceLine", "_waitTime", ["_type", ""], ["_overwriteSameType", false]];

private _sound = selectRandom getArray (configFile >> QUOTE(ADDON) >> "VoiceLines" >> _voiceLine);

if (_overwriteSameType) then {
    GVAR(voiceLineQueue) = GVAR(voiceLineQueue) select {
        (_x select 2 != _type)
    };
};

GVAR(voiceLineQueue) pushBack [_sound, _waitTime, _type];

if (!GVAR(speakerHelperActive)) then {
    GVAR(speakerHelperActive) = true;
    call FUNC(voiceLineHelper);
};
