#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Draws waypoint and turn markers
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_drawMarkers
 * 
 * Public: No
 */

// Waypoints
private _cameraPos = positionCameraToWorld [0, 0, 0];
for "_i" from 1 to GVAR(waypointCount) do {
    private _index = GVAR(nextMarkerIndex) + _i - 1;
    if (_index >= count GVAR(activeNavMarkers)) exitWith {};
    private _pos = GVAR(activeNavMarkers) select _index;
    private _size = 10 / sqrt (_cameraPos distance _pos);
    drawIcon3D ["a3\ui_f\data\GUI\Cfg\Ranks\private_pr.paa", [0.2, 0.3, 1, (GVAR(waypointAlpha) / sqrt _i)], ASLToAGL _pos, _size, _size, 180];
};

// Turns
if (GVAR(nextTurnIndex) == -1 || {GVAR(nextTurnIndex) == count GVAR(turns)}) exitWith {};
private _nextTurn = GVAR(turns) select GVAR(nextTurnIndex);
_nextTurn params ["_position", "_turnDirection", "_warning", "_vector"];
private _alpha = 0.1 * sin (CBA_missionTime * 360) + GVAR(turnAlpha);
private _turnSize = 20 / sqrt (_cameraPos distance _position);
// Calculate angle to turn
private _carVector = (vectorDir vehicle ACE_player) select [0, 2];
private _vectorLeft = [(_vector select 1) * -1, _vector select 0];
private _angle = ((_vectorLeft vectorDotProduct _carVector) atan2 (_vector vectorDotProduct _carVector)) * -1 + 180;
drawIcon3D [
    "a3\ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa", 
    [0.8, 0.3, 0.3, _alpha], 
    ASLToAGL _position vectorAdd [0, 0, 4], 
    _turnSize, _turnSize, 
    _angle, 
    [" ", "!", "!!"] select _warning,
    true,
    0.05 * _turnSize,
    "RobotoCondensed",
    "center",
    true
];
