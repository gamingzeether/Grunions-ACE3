#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Code to run while holding down cursor detonate keybind
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 *  call ace_explosives_fnc_cursorDetonateHold
 *
 * Public: No
 */

if (!([ACE_player] call FUNC(canDetonate))) exitWith {};

private _cameraPosition = AGLToASL positionCameraToWorld [0, 0, 0];
private _cameraVector = _cameraPosition vectorFromTo (AGLToASL positionCameraToWorld [0, 0, 1]);
private _explosives = [ACE_player] call FUNC(getPlacedExplosives);
private _iconBaseSize = 2 * call EFUNC(common,getZoom);
private _closestExplosive = -1;
private _closestExplosiveDot = -1;
private _explosiveIcons = [];
{
    _x params ["_explosive", "", "", "_magazineClass", "_detonatorName"];
    
    private _position = getPosASL _explosive;
    
    // Stuff relating to how close explosive is to center of screen
    private _vectorToExplosive = _cameraPosition vectorFromTo _position;
    private _vectorDot = _vectorToExplosive vectorDotProduct _cameraVector;
    if (_vectorDot < 0) then {
        continue;
    };
    if (_vectorDot > _closestExplosiveDot && {_vectorDot > 0.998}) then {
        _closestExplosive = _forEachIndex;
        _closestExplosiveDot = _vectorDot;
    };
    
    // Return 3D icon info
    private _icon = GVAR(explosiveIcons) get _magazineClass;
    if (isNil "_icon") then {
        _icon = getText (configFile >> "CfgMagazines" >> _magazineClass >> "picture");
        GVAR(explosiveIcons) set [_magazineClass, _icon];
    };
    
    private _color = [1, 1, 1];
    private _alpha = 0.8;
    if (_vectorDot < 0.9397/*cos 20*/) then {
        _alpha = _alpha - 0.3;
    };
    if ((lineIntersectsSurfaces [_cameraPosition, aimPos _explosive, ACE_player, _explosive]) isNotEqualTo []) then {
        _alpha = _alpha - 0.3;
    };
    _detonatorName = GVAR(triggerDetonator) get _detonatorName;
    private _maxTriggerDistance = GVAR(detonatorRanges) get _detonatorName;
    if (isNil "_maxTriggerDistance") then {
        _maxTriggerDistance = getNumber (configFile >> "CfgWeapons" >> _detonatorName >> QGVAR(Range));
        GVAR(detonatorRanges) set [_detonatorName, _maxTriggerDistance];
    };
    if (_maxTriggerDistance < _position vectorDistance getPosASL ACE_player) then {
        _alpha = _alpha - 0.2;
        _color set [1, 0.2];
        _color set [2, 0.2];
    };
    _color set [3, _alpha];
    
    _explosiveIcons pushBack [_icon, _color, ASLToAGL _position];
} forEach _explosives;

if (_closestExplosive != -1) then {
    GVAR(selectedExplosive) = _explosives select _closestExplosive;
} else {
    GVAR(selectedExplosive) = [];
    drawIcon3D [
        "\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa",
        [1, 0.2, 0.2, 0.8],
        positionCameraToWorld [0, 0, 1],
        1.5, 1.5,
        0
    ];
};

{
    _x params ["_icon", "_color", "_position"];
    
    private _size = _iconBaseSize;
    if (_forEachIndex == _closestExplosive) then {
        _color set [3, 1];
        _size = _size + 1;
        private _circleSize = _size + 1;
        drawIcon3D [
            "\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa",
            [1, 0.2, 0.2, 0.8],
            _position,
            _circleSize, _circleSize,
            CBA_missionTime * -360
        ];
    };
    
    drawIcon3D [
        _icon,
        _color,
        _position,
        _size, _size,
        0
    ];
} forEach _explosiveIcons;
