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
private _laser = (_target weaponAccessories _weapon) select 1;

private _weaponProxyName = switch (_weapon) do {
    case (primaryWeapon _target): {"proxy:\a3\characters_f\proxies\weapon.001"};
    case (handgunWeapon _target): {"proxy:\a3\characters_f\proxies\pistol.001"};
    case (secondaryWeapon _target): {"proxy:\a3\characters_f\proxies\launcher.001"};
    default {""};
};

//vector dir is the right side of the weapon
//same with laser pointer accessory
private _weaponDirAndUp = _target selectionVectorDirAndUp [_weaponProxyName, 1];
private _v2 = _target vectorModelToWorld (_weaponDirAndUp select 0); //right
private _v3 = _target vectorModelToWorld (_weaponDirAndUp select 1); //top
private _v1 = _v3 vectorCrossProduct _v2;                            //forward

//get laser offset from weapon proxy
//pointer is part of key because model may change
private _laserOffset = if ([_weapon, _laser] in GVAR(laserPosHashmap)) then {
    GVAR(laserPosHashmap) get [_weapon, _laser]
} else {
    [_target] call FUNC(getLaserOffset)
};
_laserOffset params ["_o1", "_o2", "_o3"];
private _p0 = AGLToASL (_target modelToWorldVisual (_target selectionPosition _weaponProxyName));
_p0 = _p0 vectorAdd (_v1 vectorMultiply -_o1) vectorAdd (_v2 vectorMultiply _o2) vectorAdd (_v3 vectorMultiply _o3);

private _laserColor = if (_isTI) then {
    ([ACE_player] call FUNC(getThermalsColor)) select [0,3]
} else {
    [[1000, 0, 0], [0, 1000, 0], [0, 1000, 0]] select _laserType
};

drawLaser [_p0, _v1, _laserColor, [], 0.1, [0.25, 0] select _isTI, -1, (_laserType == 2)];
