#include "script_component.hpp"
/*
 * Author: Rocko and esteldunedain
 * Create empty casing on weapon fired. Called from an ammo fired EH.
 *
 * Arguments:
 * None. Parameters inherited from EFUNC(common,firedEH)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];

BEGIN_COUNTER(fnc_fireEH);

private _unitPosASL = AGLToASL (_unit modelToWorldVisual (_unit selectionPosition "righthand"));

// Make far away units 10 times less likely to create casings
if ((positionCameraToWorld [0,0,0]) vectorDistance (ASLtoATL _unitPosASL) > 100 && {random 1 < 0.9}) exitWith {};

private _cartridge = getText (configFile >> "CfgAmmo" >> _ammo >> "cartridge");

private _weapDir = _unit weaponDirection currentWeapon _unit;

if (_unit getVariable [QGVAR(prevWeapon), ""] != _weapon) then {
    _unit setVariable [QGVAR(prevWeapon), _weapon];
    
    private _dir = [_weapon] call FUNC(getCasingEjectDirection);
    _unit setVariable [QGVAR(ejectDirection), _dir];
};

private _ejectDir = _weapDir vectorCrossProduct [0, 0, 1];
_ejectDir = _ejectDir vectorMultiply (_unit getVariable QGVAR(ejectDirection));

private _posASL = _unitPosASL vectorAdd _ejectDir;

private _rndAngle = random 360;
_posASL = _posASL vectorAdd ([sin _rndAngle, cos _rndAngle, 0] vectorMultiply (0.7 * sqrt (random 1)));

private _toPt = + _posASL;
_toPt set [2, (_posASL select 2) - 100];

private _intersectInfo = (lineIntersectsSurfaces [_posASL, _toPt, _unit, vehicle _unit]) select 0;

[{
    BEGIN_COUNTER(fnc_fireEH_create);

    params ["_cartridge", "_posASL", "_intersectInfo"];

    // Check if we can reuse the existing casing
    private _casing = GVAR(casings) select GVAR(currentIndex);
    if (typeOf _casing != _cartridge) then {
        // Delete former casing (nothing happens if it's an objNull)
        deleteVehicle _casing;
        // Create a new casing of the correct type
        // By creating it at [0,0,0] instead of _posASL the time is reduced
        // from around 1.08 ms to 0.08 ms. This is most likely because the
        // engine doesn't create the object exactly where it is told to, but
        // instead looks for a suitable position. Creating at origin prevents
        // that from happening.
        _casing = createSimpleObject [_cartridge, [0,0,0], true];
    };
    
    _casing setdir (random 360);

    if (count _intersectInfo != 0) then {
        _posASL = _intersectInfo select 0;
        _casing setVectorUp (_intersectInfo select 1);
    };
    _posASL set [2, (_posASL select 2) + 0.01];
    
    _casing setposASL _posASL;

    // Store newly created casing
    GVAR(casings) set [GVAR(currentIndex), _casing];
    // Update storage index
    GVAR(currentIndex) = (GVAR(currentIndex) + 1) % GVAR(maxCasings);

    TRACE_3("", _casing, _posASL, GVAR(currentIndex));

    END_COUNTER(fnc_fireEH_create);
}, [_cartridge, _posASL, _intersectInfo], 0.4] call CBA_fnc_waitAndExecute;

END_COUNTER(fnc_fireEH);
