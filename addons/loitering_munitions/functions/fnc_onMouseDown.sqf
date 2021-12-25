#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles mouse click down
 *
 * Arguments:
 * Mouse event args <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_loitering_munitions_fnc_onMouseDown
 *
 * Public: No
 */

params ["_map", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

if (_button == 0) then {
    if (_shift || _ctrl || _alt) then {
        private _multiplier = 1;
        if (_ctrl) then {
            _multiplier = _multiplier * 2;
        };
        if (_alt) then {
            _multiplier = _multiplier * 4;
        };
        GVAR(multiplier) = _multiplier;
        
        // Set altitude
        GVAR(startY) = _yPos;
        _map setVariable [QGVAR(movingEventID), _map ctrlAddEventHandler ["MouseMoving", {
            params ["_map", "_xPos", "_yPos"];
            GVAR(altitude) = 0 max (GVAR(altitude) + (_yPos - GVAR(startY)) * -200 * GVAR(multiplier));
            GVAR(startY) = _yPos;
            
            (findDisplay 28880 displayCtrl 11) ctrlSetStructuredText parseText format [LLSTRING(altitude), round GVAR(altitude), round (GVAR(altitude) - getTerrainHeightASL GVAR(startPosWorld))];
        }]];
    } else {
        private _worldPos = _map ctrlMapScreenToWorld [_xPos, _yPos];
        GVAR(startPosWorld) = _worldPos;
        GVAR(radius) = (call FUNC(getLoiterDistance)) select 0;
        
        // Get radius of circle
        _map setVariable [QGVAR(movingEventID), _map ctrlAddEventHandler ["MouseMoving", {
            params ["_map", "_xPos", "_yPos"];
            
            private _worldPos = _map ctrlMapScreenToWorld [_xPos, _yPos];
            private _distance = _worldPos vectorDistance GVAR(startPosWorld);
            
            // Get world pos between min and max distance rings
            private _distMinMax = call FUNC(getLoiterDistance);
            GVAR(radius) = (_distMinMax select 1) min (_distance max (_distMinMax select 0));
        }]];
    };
};
