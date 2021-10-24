#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
 * Author: GamingZeether
 * Called when selection of options listbox is changed
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [control, 5] call ace_garage_fnc_onListClicked
 *
 * Public: No
 */

params ["_ctrl", "_index"];

private _display = ctrlParent _ctrl;
private _isChecked = (_ctrl lbPicture _index != toLower getText (configfile >> "RscCheckBox" >> "textureChecked"));
private _curTab = _display getVariable [QGVAR(listboxTab), -1];
private _isComponentsTab = (_curTab == IDC_ACE_TABCOMPONENTS);

private _vehicle = _display getVariable [QGVAR(vehicle), objNull];
private _source = _ctrl lbData _index;
private _customization = [_vehicle] call BIS_fnc_getVehicleCustomization;

//update checked values
private _checkboxTextures = [
    toLower getText (configfile >> "RscCheckBox" >> "textureUnchecked"),
    toLower getText (configfile >> "RscCheckBox" >> "textureChecked")
];
private _imagePath = _checkboxTextures select _isChecked;
_ctrl lbSetPicture [_index, _imagePath];

//update vehicle
private _lbSize = (lbSize _ctrl) - 1;
if (_isComponentsTab) then {
    private _activeComponents = _customization select 1;
    private _selectedIndex = _activeComponents find _source;
    if (_selectedIndex != -1) then {
        _activeComponents deleteRange [_selectedIndex, 2];
    };
    
    private _animationConfig = (configFile >> "CfgVehicles" >> typeOf _vehicle >> "AnimationSources" >> _source);
    private _forceAnimates = getArray (_animationConfig >> "forceAnimate");
    
    if (count _forceAnimates > 1) then {
        private _lbValues = [];
        for "_i" from 0 to _lbSize do {
            _lbValues pushBack (_ctrl lbData _i);
        };
        for "_i" from 0 to (count _forceAnimates - 1) step 2 do {
            private _animSource = _forceAnimates select _i;
            private _forceState = _forceAnimates select (_i + 1);
            
            private _lbIndex = _lbValues find (_forceAnimates select _i);
            _ctrl lbSetPicture [_lbIndex, _checkboxTextures select _forceState];
            
            _selectedIndex = _activeComponents find _animSource;
            if (_selectedIndex != -1) then {
                _activeComponents set [_selectedIndex + 1, _forceState];
            };
        };
    };
    
    [_vehicle, false, _activeComponents + [_source, parseNumber _isChecked]] call BIS_fnc_initVehicle;
} else {
    for "_i" from 0 to _lbSize do {
        _ctrl lbSetPicture [_i, _checkboxTextures select (_i == _index)];
    };
    
    [_vehicle, [_source, parseNumber _isChecked]] call BIS_fnc_initVehicle;
};
