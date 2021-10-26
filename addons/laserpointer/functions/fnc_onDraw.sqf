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

if (count GVAR(redLaserUnits) + count GVAR(greenLaserUnits) + count GVAR(irLaserUnits) > 0 && {!GVAR(isIR)}) then {
    private _range = GVAR(laserPointerRange);
    
    {
        //red laser
        [_x, _range, 0, GVAR(isTI)] call FUNC(drawLaserpoint);
    } count GVAR(redLaserUnits);
    {
        //green laser
        [_x, _range, 1, GVAR(isTI)] call FUNC(drawLaserpoint);
    } count GVAR(greenLaserUnits);
    if (GVAR(isTI)) then {
        {
            //ir laser
            [_x, _range, 2, true] call FUNC(drawLaserpoint);
        } count GVAR(irLaserUnits);
    };
};
