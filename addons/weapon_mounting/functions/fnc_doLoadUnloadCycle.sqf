#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles loading / unloading progress bars
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_weapon_mounting_fnc_doLoadUnloadCycle
 *
 * Public: Yes
 */

params [["_init", true]];

if (!_init) then {
    if (GVAR(toUnload) isNotEqualTo []) then {
        private _unload = GVAR(toUnload) deleteAt (count GVAR(toUnload) - 1);
        _unload params ["_vehicle", "_unit", "_class", "_count"];
        private _turret = getArray (configOf _vehicle >> QGVAR(turret));
        
        // Remove specific mag with count
        private _loadedMags = [];
        {
            _x params ["_xClass", "_xTurret", "_xCount"];
            if (_xClass == _class && {_xTurret isEqualTo _turret}) then {
                _loadedMags pushBack _x;
            };
        } foreach (magazinesAllTurrets _vehicle);
        for "_i" from 0 to count _loadedMags - 1 do {
            if (((_loadedMags select _i) select 2) == _count) exitWith {
                _loadedMags deleteAt _i;
            };
        };
        _vehicle removeMagazinesTurret [_class, _turret];
        {
            _vehicle addMagazineTurret _x;
        } foreach _loadedMags;
        
        //[_unit, _class, _count, true] call CBA_fnc_addMagazine;
        
        // Modified from CBA_fnc_addMagazine
        if (_count > 0) then {
            if (_unit canAdd _class) then {
                _unit addMagazine [_class, _count];
            } else {
                private _weaponHolder = nearestObject [_unit, "WeaponHolder"];
    
                if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
                    _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
                    _weaponHolder setPosASL getPosASL _unit;
                };
                [_weaponHolder, _class] call CBA_fnc_addMagazineCargo;
            };
        };
    } else {
        if (GVAR(toLoad) isNotEqualTo []) then {
            private _load = GVAR(toLoad) deleteAt (count GVAR(toLoad) - 1);
            _load params ["_vehicle", "_unit", "_class", "_count"];
            private _turret = getArray (configOf _vehicle >> QGVAR(turret));
            
            if ([_unit, _class, _count] call CBA_fnc_removeMagazine) then {
                _vehicle addMagazineTurret [_class, _turret, _count];
            };
        };
    };
};

if (GVAR(toUnload) isNotEqualTo [] || {GVAR(toLoad) isNotEqualTo []}) then {
    private _title = [LLSTRING(loading_title), LLSTRING(unloading_title)] select (GVAR(toUnload) isNotEqualTo []);
    
    [
        2,
        nil,
        {[false] call FUNC(doLoadUnloadCycle)},
        {
            GVAR(toUnload) = [];
            GVAR(toLoad) = [];
        },
        _title
    ] call EFUNC(common,progressBar);
};
