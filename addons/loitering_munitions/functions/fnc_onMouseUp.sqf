#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Handles mouse click up
 *
 * Arguments:
 * Mouse event args <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_loitering_munitions_fnc_onMouseUp
 *
 * Public: No
 */

params ["_map", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

if (_button == 0) then {
    _map ctrlRemoveEventHandler ["MouseMoving", _map getVariable [QGVAR(movingEventID), -1]];
};
