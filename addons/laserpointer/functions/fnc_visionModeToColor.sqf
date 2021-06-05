#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Converts vision mode to colors
 * Possible vision modes are:
 *   -  0: White hot / Black cold
 *   -  1: Black hot / White cold
 *   -  2: Light Green Hot / Darker Green cold
 *   -  3: Black Hot / Darker Green cold
 *   -  4: Light Red Hot / Darker Red Cold
 *   -  5: Black Hot / Darker Red Cold
 *   -  6: White Hot / Darker Red Cold
 *   -  7: Thermal (Shade of Red and Green, Bodies are white)
 *
 * Arguments:
 * 0: Vision mode <NUMBER>
 *
 * Return Value:
 * Thermals color (0-2 hot color, 3-5 cold) <ARRAY>
 *
 * Example:
 * [player] call ace_laserpointer_fnc_visionModeToColor
 *
 * Public: Yes
 */

params ["_visionMode"];

//todo: adjust the values
switch (_visionMode) do {
    case 0: {[1,1,1,0,0,0]};
    case 1: {[0,0,0,1,1,1]};
    case 2: {[0,1,0,0,0.3,0]};
    case 3: {[0,0,0,0,0.3,0]};
    case 4: {[1,1,1,0,0,0]};
    case 5: {[1,1,1,0,0,0]};
    case 6: {[1,1,1,0,0,0]};
    case 7: {[1,1,1,0,0,0]};
};