#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Changes camo of a vehicle
 * Copied from BIS_fnc_initVehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Texture source name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [car, "Beige"] call ace_garage_fnc_changeCamo
 *
 * Public: Yes
 */

params ["_vehicle", "_source"];

private _texturesToApply = [];
private _materialsToApply = [];

private _cfgTextureSourcesVariant = (configOf _vehicle >> "textureSources" >> _source);
if (count _texturesToApply == 0 && {isClass _cfgTextureSourcesVariant}) then
{
    _texturesToApply = getArray(_cfgTextureSourcesVariant >> "textures");
    _materialsToApply = getArray(_cfgTextureSourcesVariant >> "materials");
};

// change the textures
{_vehicle setObjectTextureGlobal [_forEachindex, _x];} forEach _texturesToApply;

// change the materials when it is appropriate
{if (_x != "") then {_vehicle setObjectMaterialGlobal [_forEachindex, _x];};} forEach _materialsToApply;
