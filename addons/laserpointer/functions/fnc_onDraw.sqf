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
    private _brightness = 2 - call EFUNC(common,ambientBrightness);
    private _range = GVAR(laserPointerRange);
    
    if (GVAR(isTI)) then {
        {
            // red laser
            [_x, _range, _brightness] call FUNC(drawLaserpointTI);
        } count GVAR(redLaserUnits);
        
        {
            // green laser
            [_x, _range, _brightness] call FUNC(drawLaserpointTI);
        } count GVAR(greenLaserUnits);
		
	{
            // ir laser
            [_x, _range, _brightness] call FUNC(drawLaserpointTI);
        } count GVAR(irLaserUnits);

    //visible mode
    } else {
        {
            // red laser
            [_x, _range, false, _brightness] call FUNC(drawLaserpoint);
        } count GVAR(redLaserUnits);

        {
            // green laser
            [_x, _range, true, _brightness] call FUNC(drawLaserpoint);
        } count GVAR(greenLaserUnits);
    }
};