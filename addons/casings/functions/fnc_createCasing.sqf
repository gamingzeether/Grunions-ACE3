#include "script_component.hpp"
/*
 * Author: esteldunedain / Cyruz / diwako
 * Produces a casing matching the fired weapons caliber on the ground around the unit
 *
 * Arguments:
 * 0: unit - Object the event handler is assigned to <OBJECT>
 * 1: weapon - Weapon used <STRING>
 * 4: ammo - Ammo used <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "", "","", "B_556x45_Ball"] call ace_casings_fnc_createCasing
 *
 * Public: No
 */

params ["_unit", "_weapon", "", "", "_ammo"];

if (!isNull objectParent _unit) exitWith {};

private _cartridge = GVAR(cachedCasings) get _ammo;
if (isNil "_cartridge") then {
    _cartridge = getText (configFile >> "CfgAmmo" >> _ammo >> "cartridge");
    GVAR(cachedCasings) set [_ammo, _cartridge];
};

if (_cartridge isEqualTo "") exitWith {};

private _unitPos = getposASL _unit;
// Distant shooters don't produce as many cases
if ((AGLToASL positionCameraToWorld [0,0,0]) vectorDistance _unitPos > 100 && {random 1 < 0.9}) exitWith {};

private _ejectDistance = GVAR(ejectDistance) get _weapon;
if (isNil "_ejectDistance") then {
    _ejectDistance = [_weapon] call FUNC(getCasingEjectDistance);
    GVAR(ejectDistance) set [_weapon, _ejectDistance];
};

private _weapDir = _unit weaponDirection currentWeapon _unit;
private _ejectDir = _weapDir vectorCrossProduct [0, 0, 1];
private _angle = random 360;
private _distance = 0.8 * (random 1) ^ 0.6;
private _pos = _unitPos
    vectorAdd (_ejectDir vectorMultiply _ejectDistance)
    vectorAdd ([_distance * cos _angle, _distance * sin _angle, 0]);

[
    {
        params ["_cartridge", "_pos"];

        private _lisPos = (lineIntersectsSurfaces [_pos, _pos vectorAdd [0,0,-1e11], objNull, objNull, true, 1, "ROADWAY", "FIRE"]) #0;
        private _casing = createSimpleObject [_cartridge, [0, 0, 0], true];
        _casing setPosASL (_lisPos #0 vectorAdd [0,0,0.005]);
        _casing setDir (random 360);
        _casing setVectorUp _lisPos #1;
        
        // Doing it this way is faster compared to removing from array and pushing something to the end
        // Removing an item in the array causes everything to be shifted down and that is slow on larger arrays
        deleteVehicle (GVAR(casings) select GVAR(currentIndex));
        GVAR(casings) set [GVAR(currentIndex), _casing];
        GVAR(currentIndex) = (GVAR(currentIndex) + 1) % GVAR(maxCasings);
    },
    [_cartridge, _pos],
    0.4
] call CBA_fnc_waitAndExecute;
