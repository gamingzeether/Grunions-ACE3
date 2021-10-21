#include "script_component.hpp"
/*
 * Author: commy2, esteldunedain, and GamingZeether
 * Draw a laser beam and laser point
 *
 * Arguments:
 * 0: Target unit <OBJECT>
 * 1: Range <NUMBER>
 * 2: Laser type <NUMBER>
 * 3: Draw thermals dot (Default: false) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 10, 0] call ace_laserpointer_fnc_drawLaserpoint
 *
 * Public: No
 */

params ["_target", "_range", "_laserType", ["_isTI", false]];

private _unit = ACE_player;
private _weapon = currentWeapon _target;
private _lasers = (_target weaponAccessories _weapon) arrayIntersect getArray (configfile >> "PointerSlot" >> "compatibleItems");

private _weaponProxyName = switch (_weapon) do {
    case (primaryWeapon _target): {"proxy:\a3\characters_f\proxies\weapon.001"};
    case (handgunWeapon _target): {"proxy:\a3\characters_f\proxies\pistol.001"};
    case (secondaryWeapon _target): {"proxy:\a3\characters_f\proxies\launcher.001"};
    default {""};
};

private _p0 = AGLToASL (_target modelToWorldVisual (_target selectionPosition _weaponProxyName));

private _weaponDirAndUp = _target selectionVectorDirAndUp [_weaponProxyName, 1];
//vector forward is the right side of the weapon?
//same with laser pointer accessory
private _v2 = _target vectorModelToWorld (_weaponDirAndUp select 0); //right
private _v3 = _target vectorModelToWorld (_weaponDirAndUp select 1); //top
private _v1 = _v3 vectorCrossProduct _v2;                            //forward

//get laser offset from weapon proxy
//pointer is part of key because model may change
private _laserOffset = if ([_weapon, _lasers] in GVAR(laserPosHashmap)) then {
    GVAR(laserPosHashmap) get [_weapon, _lasers]
} else {
    [_target] call FUNC(getLaserOffset)
};
_laserOffset params ["_o1", "_o2", "_o3"];

_p0 = _p0 vectorAdd (_v1 vectorMultiply -_o1) vectorAdd (_v2 vectorMultiply _o2) vectorAdd (_v3 vectorMultiply _o3);

private _laserColor = if (_isTI) then {
    ([ACE_player] call FUNC(getThermalsColor)) select [0,2]
} else {
    [[1000, 0, 0, 0.5], [0, 1000, 0, 0.5], [0, 1000, 0, 0.5]] select _laserType
};

//drawLaser [_p0, _v1, _laserColor, [], 0.05, [2, 0] select _isTI, (_laserType == 2)];

//use drawLine3D until 2.08
private _p1 = _p0 vectorAdd (_v1 vectorMultiply _range);
private _pL = lineIntersectsSurfaces [_p0, _p1, _unit, vehicle _unit] select 0 select 0;
if (isNil "_pL") exitWith {
    _p0 = ASLtoAGL _p0;
    _p1 = ASLtoAGL _p1;

    drawLine3D [
        _p0,
        _p1,
        _laserColor
    ];
};

private _distance = _p0 vectorDistance _pL;
if (_distance < 0.5) exitWith {};

_pL = ASLtoAGL _pL;
_p0 = ASLtoAGL _p0;

drawLine3D [
    _p0,
    _pL,
    _laserColor
];

private _camPos = positionCameraToWorld [0,0,0.2];

private _pL2 = _p0 vectorAdd (_v1 vectorMultiply (_distance - 0.5));
if (terrainIntersectASL [_camPos, _pL2]) exitWith {};
if (lineIntersects [_camPos, _pL2]) exitWith {};

private _distanceFromViewer = _camPos vectorDistance _pL;
private _size = 2 * call EFUNC(common,getZoom) / sqrt (_distanceFromViewer);

drawIcon3D [
    "\A3\ui_f\data\IGUI\RscCustomInfo\Sensors\Targets\UnknownMan_ca.paa",
    _laserColor,
    _pL,
    _size,
    _size,
    45,
    "",
    0,
    0.05
];
