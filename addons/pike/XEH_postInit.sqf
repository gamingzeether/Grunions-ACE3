#include "script_component.hpp"

if (!hasInterface) exitWith {};

[QGVAR(fired), {true}, true, false, true, true, false, true] call EFUNC(common,registerAmmoFiredEvent);
[QGVAR(fired), FUNC(handleFired)] call CBA_fnc_addEventHandler;
