#include "script_component.hpp"

if (!hasInterface) exitWith {};

{[_x, FUNC(handleFired)] call CBA_fnc_addEventHandler} foreach ["ace_firedPlayer", "ace_firedNonPlayer", "ace_firedPlayerVehicle", "ace_firedNonPlayerVehicle"];
