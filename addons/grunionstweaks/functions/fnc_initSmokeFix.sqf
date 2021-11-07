#include "script_component.hpp"

if (!hasInterface) exitWith {};

ACE_player addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];
    
    if (_role == "driver") then {
        _turret = [-1];
    };
    if ("SmokeLauncher" in (_vehicle weaponsTurret _turret)) then {
        _vehicle setEffectiveCommander _unit;
    };
}];

ACE_player addEventHandler ["SeatSwitchedMan", {
    params ["_unit1", "_unit2", "_vehicle"];
    private _turret = [];
    
    private _role = assignedVehicleRole _unit1;
    if (_role isEqualTo ["driver"]) then {
        _turret = [-1];
    } else {
        _turret = _role select 1;
    };
    if ("SmokeLauncher" in (_vehicle weaponsTurret _turret)) then {
        _vehicle setEffectiveCommander _unit1;
    };
}];
