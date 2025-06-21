#include "..\script_component.hpp"
#include "..\ui\defines.hpp"
/*
 * Author: GamingZeether
 * Opens garage display
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [display, car] call ace_garage_fnc_onGarageOpen
 *
 * Public: No
 */

params ["_vehicle"];

// Open dialog
createDialog QGVAR(display);
private _display = findDisplay IDD_ACE_GARAGE; 
_display setVariable [QGVAR(vehicle), _vehicle];
_display setVariable [QGVAR(options), [typeOf _vehicle] call FUNC(getOptions)];
uiNamespace setVariable [QGVAR(display), _display];

// Hide listbox
private _listBox = _display displayCtrl IDC_ACE_LISTBOX;
private _listBackground = _display displayCtrl IDC_ACE_BACKGROUND;
_listBox ctrlShow false;
_listBackground ctrlShow false;
