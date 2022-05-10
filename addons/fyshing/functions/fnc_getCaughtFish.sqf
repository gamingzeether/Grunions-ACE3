#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Returns name of fish on bobber
 *
 * Arguments:
 * Bobber <OBJECT>
 *
 * Return Value:
 * Name of fish <STRING>
 *
 * Example:
 * [bobber] call ace_fyshing_fnc_getCaughtFish;
 *
 * Public: Yes
 */

params ["_bobber"];

private _attached = _bobber getVariable [QGVAR(attachedFish), []];
if (_attached isEqualTo []) exitWith {"nothing"};

private _fish = _attached select 0;

toLowerANSI getText (configOf _fish >> "displayName")
