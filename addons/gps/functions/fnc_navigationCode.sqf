#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Code that is run during the trip
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_navigationCode
 * 
 * Public: No
 */

// Markers
if (GVAR(nextMarkerIndex) == -1) exitWith {};
private _vehiclePos = getPosASL vehicle ACE_player;
private _playerVector = vectorDir vehicle ACE_player;
for "_i" from GVAR(nextMarkerIndex) to (count GVAR(activeNavMarkers) - 1) do {\
    private _markerPos = GVAR(activeNavMarkers) select _i;
    private _dist = _markerPos vectorDistance _vehiclePos;
    private _vectorToMarker = _vehiclePos vectorFromTo _markerPos;
    if (_dist < 20 && {_playerVector vectorDotProduct _vectorToMarker < 0}) exitWith {
        // Update turn marker
        for "_j" from GVAR(nextMarkerIndex) to _i do {
            private _pos = GVAR(activeNavMarkers) select _j;
            if (GVAR(turns) select GVAR(nextTurnIndex) select 0 isEqualTo _pos) then {
                GVAR(nextTurnIndex) = GVAR(nextTurnIndex) + 1;
                GVAR(nextTurnDistanceSaid) = "";
                GVAR(nextTurnDirectionSaid) = false;
            };
        };
        GVAR(nextMarkerIndex) = _i + 1;
    };
};

if (count GVAR(activeNavMarkers) == GVAR(nextMarkerIndex)) exitWith {
    // Destination reached
    GVAR(nextMarkerIndex) = -1;
    GVAR(nextTurnIndex) = -1;
    GVAR(isNavigating) = false;
    ["StatusDestinationReached", 3, "Status"] call FUNC(sayVoiceLine);
};

private _turn = GVAR(turns) select GVAR(nextTurnIndex);
_turn params ["_pos", "_turnDirection"];
private _distanceLine = "";
private _distance = getPosASL ACE_player vectorDistance _pos;
if (_distance <= 100) then {
    _distanceLine = "Distance100";
} else {
    if (_distance <= 200) then {
        _distanceLine = "Distance200";
    } else {
        if (_distance <= 300) then {
            _distanceLine = "Distance300";
        } else {
            if (_distance <= 500) then {
                _distanceLine = "Distance500";
            } else {
                if (_distance <= 1500) then {
                    _distanceLine = "Distance1000";
                };
            };
        };
    };
};
if (_distanceLine != "" && {GVAR(nextTurnDistanceSaid) != _distanceLine}) then {
    if (!GVAR(nextTurnDirectionSaid)) then {
        [["DirectionForward", "DirectionLeft", "DirectionRight"] select _turnDirection, 0.75, "Direction"] call FUNC(sayVoiceLine);
        GVAR(nextTurnDirectionSaid) = true;
    };
    [_distanceLine, 1.5, "Distance", true] call FUNC(sayVoiceLine);
    GVAR(nextTurnDistanceSaid) = _distanceLine;
};
