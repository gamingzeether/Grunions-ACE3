#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Starts navigation after pathing agent finds a path
 * Modifies the path
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_startNavigation
 * 
 * Public: No
 */

if (count GVAR(activeNavMarkers) < 2) exitWith {};
GVAR(isNavigating) = true;
GVAR(nextMarkerIndex) = 0;
GVAR(nextTurnIndex) = 0;
["StatusIdle", 3, "Status"] call FUNC(sayVoiceLine);

private _fnc_vectorFromTo2D = {
    private _vector = (_this select 0) vectorDiff (_this select 1);
    _vector set [2, 0];
    (vectorNormalized _vector select [0, 2])
};

// Remove markers that are too close
private _lastMarker = GVAR(activeNavMarkers) select 0;
GVAR(activeNavMarkers) = GVAR(activeNavMarkers) select {
    private _distToMark = _lastMarker distance _x;
    if (_distToMark > MARKER_MIN_DISTANCE) then {
        _lastMarker = _x;
        true
    } else {
        false
    }
};

// Find intersections
private _foundIntersections = [];
{
    private _segments = (_x select [0, 2]) nearRoads (MARKER_MIN_DISTANCE * 2);
    private _index = _segments findIf {(count roadsConnectedTo [_x, true]) > 2};
    if (_index != -1) then {
        private _intersectionSegment = _segments select _index;
        if (!(_intersectionSegment in _foundIntersections)) then {
            private _pos = getPosASL _intersectionSegment;
            _foundIntersections pushBack _pos;
        };
    };
} foreach GVAR(activeNavMarkers);

// Insert intersections
{
    for "_i" from 0 to (count GVAR(activeNavMarkers) - 2) do {
        private _pos1 = GVAR(activeNavMarkers) select _i;
        private _pos2 = GVAR(activeNavMarkers) select _i + 1;
        private _vector12 = _pos1 vectorFromTo _pos2;
        private _vector21 = _pos2 vectorFromTo _pos1;
        private _vector1i = _pos1 vectorFromTo _x;
        private _vector2i = _pos2 vectorFromTo _x;
        if (_vector12 vectorDotProduct _vector1i > 0 && {_vector21 vectorDotProduct _vector2i > 0} && {_x distance _pos1 < _pos1 distance _pos2}) exitWith {
            GVAR(activeNavMarkers) insert [_i + 1, [_x]];
            _index = _i;
            if (_x distance _pos2 < MARKER_MIN_DISTANCE) then {
                GVAR(activeNavMarkers) deleteAt (_i + 2);
            };
            if (_x distance _pos1 < MARKER_MIN_DISTANCE) then {
                GVAR(activeNavMarkers) deleteAt (_i);
            };
        };
    };
} foreach _foundIntersections;

// Turns
private _prevPos;
private _pos = GVAR(activeNavMarkers) select 0;
private _nextPos = GVAR(activeNavMarkers) select 1;
for "_i" from 2 to (count GVAR(activeNavMarkers) - 1) do {
    _prevPos = _pos;
    _pos = _nextPos;
    _nextPos = GVAR(activeNavMarkers) select _i;
    private _vector1 = [_prevPos, _pos] call _fnc_vectorFromTo2D;
    private _vector2 = [_pos, _nextPos] call _fnc_vectorFromTo2D;
    
    // Check if turning
    if (_vector1 vectorDotProduct _vector2 < 0.9) then {
        private _vector1Left = [(_vector1 select 1) * -1, _vector1 select 0];
        
        private _dot = _vector2 vectorDotProduct _vector1Left;
        private _turnDirection = [TURN_LEFT, TURN_RIGHT] select (_dot < 0);
        GVAR(turns) pushBack [_pos, _turnDirection, _dot, _vector2];
    } else {
        if (_pos in _foundIntersections) then {
            GVAR(turns) pushBack [_pos, TURN_STRAIGHT, 0, _vector2];
        };
    };
};

// Add warning to slow if multiple turns close to each other
if (GVAR(turns) isNotEqualTo []) then {
    private _turn;
    private _nextTurn = GVAR(turns) select 0;
    for "_i" from 1 to count GVAR(turns) do {
        _turn =  _nextTurn;
        _nextTurn = GVAR(turns) select _i;
        private _distanceToNext = [(_turn select 0) distance (_nextTurn select 0), 1000] select (_i == count GVAR(turns));
        private _warn = SPEEDWARN_NONE;
        if (_distanceToNext < 100 || {abs (_turn select 2) > 0.5}) then {
            _warn = SPEEDWARN_SLOW;
            if (_distanceToNext < 50 || {abs (_turn select 2) > 0.8}) then {
                _warn = SPEEDWARN_SLOWER;
            };
        };
        _turn set [2, _warn];
    };
};
