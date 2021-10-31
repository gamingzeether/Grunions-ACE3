#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Stops panning the huntir camera around
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_huntir_fnc_onMouseUp
 *
 * Public: No
 */
 
params ["", "_button"];

if (_button == 0) then {
    GVAR(panId) call CBA_fnc_removePerFrameHandler;
    GVAR(panId) = -1;
};
