#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Starts panning the huntir camera around
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_huntir_fnc_onMouseDown
 *
 * Public: No
 */
 
params ["", "_button"];

// Left click
if (_button == 0) then {
    GVAR(mousePos) = getMousePosition;
    
    GVAR(mouseDown) = true;
};
