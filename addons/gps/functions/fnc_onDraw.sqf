#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Draws things to the map
 *
 * Arguments:
 * Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_onDraw
 *
 * Public: No
 */

params ["_control"];

private _vehicle = vehicle ACE_player;
_control drawIcon ["a3\ui_f\data\Map\VehicleIcons\iconCar_ca.paa", [0.2, 0.3, 1, 1], _vehicle, 35, 35, getDir _vehicle];

if (GVAR(isNavigating)) then {
    private _prevPos;
    private _nextPos = getPosASL _vehicle;
    for "_i" from (GVAR(nextMarkerIndex) + 1) to (count GVAR(activeNavMarkers) - 1) do {
        _prevPos = _nextPos;
        _nextPos = GVAR(activeNavMarkers) select _i;
        _control drawLine [_prevPos, _nextPos, [1, 0, 0, 1]];
    };
};
