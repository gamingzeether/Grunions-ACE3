#include "script_component.hpp"

if (!hasInterface) exitWith {};

["ace_firedPlayer", LINKFUNC(handleFired)] call CBA_fnc_addEventHandler;

["weapon", LINKFUNC(handleWeaponChanged)] call CBA_fnc_addPlayerEventHandler;

GVAR(PFHRunning) = false;
