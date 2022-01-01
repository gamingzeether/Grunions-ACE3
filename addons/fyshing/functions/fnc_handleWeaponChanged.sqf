#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles weapon changed
 *
 * Arguments:
 * addPlayerEventHandler params
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_fyshing_fnc_handleWeaponChanged;
 *
 * Public: No
 */

params ["_unit", "_newWep", "_oldWep"];
if (_newWep == QGVAR(fyshingRod)) exitWith {
    //Show mouse buttons
    [localize LSTRING(CastAction), localize LSTRING(CancelAction), localize LSTRING(ScrollAction)] call EFUNC(interaction,showMouseHint);
    
    GVAR(state) = ROD_WAIT;
    GVAR(PFHRunning) = true;
};
if (_oldWep == QGVAR(fyshingRod)) exitWith {
    GVAR(state) = ROD_CANCEL;
    GVAR(PFHRunning) = false;
    
    [] call EFUNC(interaction,hideMouseHint);
};
