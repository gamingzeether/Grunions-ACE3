#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Creates reload child actions
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Type of magazine <STRING>
 *
 * Return Value:
 * Can reload <BOOL>
 *
 * Example:
 * [quadbike, "150Rnd_93x64_Mag"] call ace_weapon_mounting_fnc_canReloadType
 *
 * Public: No
 */

params ["_vehicle", "_type"];

private _compatTypes = _vehicle getVariable [QGVAR(compatMags), []];
if (!(_type in _compatTypes)) exitWith {false};

private _types = [];
private _countOfType = 0;
private _turret = getArray (configOf _vehicle >> QGVAR(turret));
{
    _x params ["_xClass", "_xTurret", "_xCount"];
    if (_xTurret isNotEqualTo _turret) then {continue};
    
    if (_xClass in _compatTypes) then {
        _types pushBack _xClass;
    };
    if (_xClass == _type) then {
        _countOfType = _countOfType + 1;
    };
} forEach (magazinesAllTurrets _vehicle);
_types pushBack _type;
_types = _types arrayIntersect _types;

(count _types <= GVAR(maxTypes)) && 
{_countOfType < GVAR(maxOfType)}
