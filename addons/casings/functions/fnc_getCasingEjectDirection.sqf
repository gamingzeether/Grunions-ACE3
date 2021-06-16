#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Calculates the ejection direction of casings
 *
 * Arguments:
 * CfgWeapons classname <STRING>
 *
 * Return Value:
 * Ejection direction L/R (Positive = right) <NUMBER>
 *
 * Public: No
 */

params ["_weapon"];

private _model = getText (configFile >> "CfgWeapons" >> _weapon >> "model");

if (_model select [0,1] == "\") then {
    _model = _model select [1, count _model - 1];
};
if (_model select [count _model - 4, 4] != ".p3d") then {
    _model = _model + ".p3d";
};

private _dummyWeapon = createSimpleObject [_model, [0,0,0], true];

private _casingStart = _dummyWeapon selectionPosition ["nabojnicestart", "memory"];
private _casingEnd = _dummyWeapon selectionPosition ["nabojniceend", "memory"];

private _vectorDiff = _casingEnd vectorDiff _casingStart;
_vectorDiff = vectorNormalized _vectorDiff;

deleteVehicle _dummyWeapon;

private _direction = _vectorDiff select 1;

_direction