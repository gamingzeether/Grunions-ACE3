#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Gets the color of thermals being used by a unit's nvgs
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
 * 0: Target unit <OBJECT>
 *
 * Return Value:
 * Thermals color (0-2 hot color, 3-5 cold) <ARRAY>
 *
 * Example:
 * [player] call ace_laserpointer_fnc_getThermalsColor
 *
 * Public: Yes
 */
 
params ["_unit"];
 
private _visionMode = 0;
private _nvgItem = hmd _unit;

private _cfgWeapons = configFile >> "CfgWeapons";
if (_nvgItem == "") then {
   //returns something like "{ "Integrated_NVG_TI_0_F" }"
   _subItems = getArray (_cfgWeapons >> headgear _unit >> "subItems");
   _nvgItem = _subItems select 0;
};

if (_nvgItem != "") then {
    private _thermalModes = getArray (_cfgWeapons >> _nvgItem >> "thermalMode");
    _visionMode = _thermalModes select 0;
};

private _color = [_visionMode] call FUNC(visionModeToColor);
_color 