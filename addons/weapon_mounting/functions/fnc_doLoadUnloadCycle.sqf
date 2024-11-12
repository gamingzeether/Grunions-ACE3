#include "..\script_component.hpp"
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
        private _removed = false;
        private _loadedMags = [];
        {
            _x params ["_xClass", "_xTurret", "_xCount"];
            if (_xClass == _class && {_xTurret isEqualTo _turret}) then {
                _loadedMags pushBack _x;
            };
        } forEach (magazinesAllTurrets _vehicle);
        for "_i" from 0 to count _loadedMags - 1 do {
            if (((_loadedMags select _i) select 2) == _count) exitWith {
                _loadedMags deleteAt _i;
                _removed = true;
            };
        };
        _vehicle removeMagazinesTurret [_class, _turret];
        {
            _vehicle addMagazineTurret _x;
        } forEach _loadedMags;
        
        //[_unit, _class, _count, true] call CBA_fnc_addMagazine;
        
        if (!_removed) exitWith {};
        
        // Modified from CBA_fnc_addMagazine
        // Check if it uses csw carry mags
        if (_vehicle getVariable [QGVAR(cswMags), false]) then {
            private _found = false;
            private _cswMagGroups = configFile >> QEGVAR(csw,groups);
            for "_i" from 0 to (count _cswMagGroups - 1) do { 
                private _group = _cswMagGroups select _i;
                for "_j" from 0 to (count _group - 1) do { 
                    private _configName = configName (_group select _j);
                    if (_configName == _class) then {
                        _class = configName _group;
                        _found = true;
                        break;
                    };
                };
                if (_found) then {
                    break;
                };
            };
        };
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
            private _weapon = (_vehicle weaponsTurret _turret) select 0;
            
            if ([_unit, _class, _count] call CBA_fnc_removeMagazine) then {
                // Check if it uses csw carry mags
                if (_vehicle getVariable [QGVAR(cswMags), false]) then {
                    _class = [_vehicle, _turret, _class] call EFUNC(csw,reload_getVehicleMagazine);
                };
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
