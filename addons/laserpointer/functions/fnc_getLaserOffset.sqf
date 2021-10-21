#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Finds the offset of a laser and adds it to the cache
 *
 * Arguments:
 * 0: Target unit <OBJECT>
 *
 * Return Value:
 * Laser offset
 *
 * Example:
 * [player] call ace_laserpointer_fnc_getLaserOffset
 *
 * Public: No
 */

params ["_unit"];

private _laserOffset = [0,0,0];

private _weapon = currentWeapon _unit;
private _lasers = (_unit weaponAccessories _weapon) arrayIntersect getArray (configfile >> "PointerSlot" >> "compatibleItems");
if (count _lasers == 0) exitWith {_laserOffset};

private _accProxyName = getText (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "PointerSlot" >> "linkProxy");
private _beamProxyName = getText (configFile >> "CfgWeapons" >> _lasers select 0 >> "ItemInfo" >> "Pointer" >> "irLaserPos");

private _dummyWeapon = createSimpleObject [getText (configFile >> "CfgWeapons" >> _weapon >> "model"), [0,0,0], true];
private _dummyLaser = createSimpleObject [getText (configFile >> "CfgWeapons" >> _lasers select 0 >> "model"), [0,0,0], true];

private _wOffset = _dummyWeapon selectionPosition [_accProxyName, 1];
private _lOffset = _dummyLaser selectionPosition [_beamProxyName, "Memory"];

private _vecDirAndUp = _dummyWeapon selectionVectorDirAndUp [_accProxyName, 1];
private _pointerRight = _vecDirAndUp select 0;
private _pointerUp = _vecDirAndUp select 1;
private _pointerDir = _pointerRight vectorCrossProduct _pointerUp;
_lOffset = (_pointerDir vectorMultiply (_lOffset select 0)) vectorAdd (_pointerRight vectorMultiply (_lOffset select 1)) vectorAdd (_pointerUp vectorMultiply (_lOffset select 2));

_laserOffset = _wOffset vectorAdd _lOffset;

//clean up
deleteVehicle _dummyWeapon;
deleteVehicle _dummyLaser;

GVAR(laserPosHashmap) set [[_weapon, _lasers], _laserOffset];

_laserOffset
