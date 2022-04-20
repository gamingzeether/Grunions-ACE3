#include "script_component.hpp"
/*
 * Author: commy2
 * Draw the visible laser beams of all cached units.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ACE_laserpointer_fnc_onDraw
 *
 * Public: No
 */

if (count GVAR(redLaserUnits) > 0 && {!GVAR(isIR)}) then {
    private _range = GVAR(laserPointerRange);
    
    {
        //red laser
        [_x, _range, 0, GVAR(isTI)] call FUNC(drawLaserpoint);
    } count GVAR(redLaserUnits);
};
