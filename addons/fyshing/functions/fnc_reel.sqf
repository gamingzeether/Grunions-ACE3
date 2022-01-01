#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles scroll wheel event
 *
 * Arguments:
 * Scroll event args
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [] call ace_fyshing_fnc_reel;
 *
 * Public: No
 */

params ["", "_reelAmount"];
if (!GVAR(PFHRunning)) exitWith {};

if (_reelAmount < 0) then {
    GVAR(desiredLength) = GVAR(desiredLength) + _reelAmount;
} else {
    GVAR(desiredLength) = GVAR(currentLength);
};

true
