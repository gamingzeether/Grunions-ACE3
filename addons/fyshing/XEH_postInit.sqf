#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Throw fish event handler
[QGVAR(fyshThrown), LINKFUNC(handleFired)] call CBA_fnc_addEventHandler;
[QGVAR(fyshThrown), {
    params ["_ammo", "_ammoConfig"];
    (_ammo in [QGVAR(fysh_explosive), QGVAR(fysh)])
}, true, false, true, true, false, true] call EFUNC(common,registerAmmoFiredEvent);

// Fyshing rod stuff
["weapon", LINKFUNC(handleWeaponChanged)] call CBA_fnc_addPlayerEventHandler;
GVAR(PFHRunning) = false;
