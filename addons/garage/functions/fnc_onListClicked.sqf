#include "..\script_component.hpp"
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

// Update listbox
private _display = ctrlParent _ctrl;
private _isChecked = (_ctrl lbPicture _index != toLower getText (configFile >> "RscCheckBox" >> "textureChecked"));
private _curTab = _display getVariable [QGVAR(listboxTab), -1];
private _isComponentsTab = (_curTab == IDC_ACE_TABCOMPONENTS);

private _vehicle = _display getVariable [QGVAR(vehicle), objNull];
private _source = _ctrl lbData _index;
private _customization = [_vehicle] call BIS_fnc_getVehicleCustomization;

private _checkboxTextures = [
    toLower getText (configFile >> "RscCheckBox" >> "textureUnchecked"),
    toLower getText (configFile >> "RscCheckBox" >> "textureChecked")
];
private _imagePath = _checkboxTextures select _isChecked;
_ctrl lbSetPicture [_index, _imagePath];

private _lbSize = (lbSize _ctrl) - 1;
if (_isComponentsTab) then {
    // Play animation
    private _phase = parseNumber _isChecked;
    private _animations = [_source, _phase];

    private _animationConfig = (configOf _vehicle >> "AnimationSources" >> _source);
    
    private _forceAnimatePhase = getNumber (_animationConfig >> "forceAnimatePhase");
    private _forceAnimates = [];
    if (_forceAnimatePhase == _phase) then {
        _forceAnimates = getArray (_animationConfig >> "forceAnimate");
    } else {
        _forceAnimates = getArray (_animationConfig >> "forceAnimate2");
        _forceAnimatePhase = (1 - _forceAnimatePhase);
    };
    
    private _phaseCurrent = _vehicle animationPhase _source;
    private _doForceAnimate = (_forceAnimatePhase == _phase) && {_phase != _phaseCurrent && {count _forceAnimates >= 2}};
    
    if (_doForceAnimate && {count _forceAnimates > 1}) then {
        private _lbValues = [];
        for "_i" from 0 to _lbSize do {
            _lbValues pushBack (_ctrl lbData _i);
        };
        for "_i" from 0 to (count _forceAnimates - 1) step 2 do {
            private _animSource = _forceAnimates select _i;
            private _forceState = _forceAnimates select (_i + 1);
            
            _animations append [_animSource, _forceState];
            
            private _lbIndex = _lbValues find (_forceAnimates select _i);
            _ctrl lbSetPicture [_lbIndex, _checkboxTextures select _forceState];
        };
    };
    
    for "_i" from 0 to (count _animations - 1) step 2 do {
        [QGVAR(animChanged), [_vehicle, _animations select _i, _animations select (_i + 1)]] call CBA_fnc_globalEvent;
    };
} else {
    // Apply textures and materials
    for "_i" from 0 to _lbSize do {
        _ctrl lbSetPicture [_i, _checkboxTextures select (_i == _index)];
    };
    
    [QGVAR(camoChanged), [_vehicle, _source]] call CBA_fnc_globalEvent;
};
