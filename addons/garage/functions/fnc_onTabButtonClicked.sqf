#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
 * Author: GamingZeether
 * Called when the components or camo tab buttons are clicked
 *
 * Arguments:
 * 0: Control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * _this call ace_garage_fnc_onTabButtonClicked
 *
 * Public: No
 */

params ["_ctrl"];

private _idc = ctrlIDC _ctrl;
private _display = ctrlParent _ctrl;
private _options = _display getVariable [QGVAR(options), []];
private _vehicle = _display getVariable [QGVAR(vehicle), objNull];
if (_options isEqualTo [] || {isNull _vehicle} || {!alive _vehicle}) exitWith {};

private _customization = [_vehicle] call BIS_fnc_getVehicleCustomization;

private _curTab = _display getVariable [QGVAR(listboxTab), -1];
private _listBox = _display displayCtrl IDC_ACE_LISTBOX;
private _listBackground = _display displayCtrl IDC_ACE_BACKGROUND;
// Hide listbox if clicking currently selected tab
if (_curTab == _idc) exitWith {
    _listBox ctrlShow false;
    _listBackground ctrlShow false;
    _display setVariable [QGVAR(listboxTab), -1];
};
// Else, show listbox if not already showing
_listBox ctrlShow true;
_listBackground ctrlShow true;
_display setVariable [QGVAR(listboxTab), _idc];

private _isComponents = (_idc == IDC_ACE_TABCOMPONENTS);
_options = _options select _isComponents;
_customization = _customization select _isComponents;

private _checkedOptions = [];
for "_i" from 0 to (count _customization - 1) step 2 do {
    private _state = _customization select (_i + 1);
    if (_state == 1) then {
        _checkedOptions pushBack (_customization select _i);
    };
};

// Fill listbox with options
private _listbox = _display displayCtrl IDC_ACE_LISTBOX;
lbClear _listbox;
{
    private _displayName = _x select 0;
    private _source = _x select 1;
    
    private _index = _listbox lbAdd _displayName;
    _listbox lbSetData [_index, _source];
    
    private _imagePath = if (_source in _checkedOptions) then {
        toLower getText (configfile >> "RscCheckBox" >> "textureChecked")
    } else {
        toLower getText (configfile >> "RscCheckBox" >> "textureUnchecked")
    };
    _listbox lbSetPicture [_index, _imagePath];
} foreach _options;
