// #define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!hasInterface) exitWith {};

ACE_player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
    
    if (_unit == commander _vehicle) then {
        _vehicle setEffectiveCommander commander _vehicle;
    };
}];
