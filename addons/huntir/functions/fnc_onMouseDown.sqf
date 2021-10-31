#include "script_component.hpp"
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
    GVAR(panId) = [{
        private _mousePos = getMousePosition;
        private _diff = _mousePos vectorDiff GVAR(mousePos);
        
        _diff = [(_diff select 0) * -GVAR(sensX) * ([1, -1] select GVAR(invertX)), (_diff select 1) * GVAR(sensY) * ([1, -1] select GVAR(invertY))];
        _diff = _diff vectorMultiply (1/2^GVAR(ZOOM));
        
        _diff params ["_xDiff", "_yDiff"];
        GVAR(ROTATE) = GVAR(ROTATE) + _xDiff;
        if ((GVAR(ELEVAT) < 4.01 && {_yDiff > 0}) || {GVAR(ELEVAT) > 0.01 && {_yDiff < 0}}) then {
            GVAR(ELEVAT) = (0.01 max (GVAR(ELEVAT) + _yDiff)) min 4.01;
        };
        
        GVAR(mousePos) = _mousePos;
    },0,[]] call CBA_fnc_addPerFrameHandler;
};
