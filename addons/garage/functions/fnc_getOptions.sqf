#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Gets the customization options for a vehicle
 *
 * Arguments:
 * 0: Vehicle classname
 *
 * Return Value:
 * Options <ARRAY>
 *  0: Components
 *   0: Option 1
 *    0: Display name
 *    1: Animation source
 *   ...
 *  1: Textures
 *   0: Option 1
 *    0: Display name
 *    1: Texture info
 *   ...
 *
 * Example:
 * [typeOf cursorObject] call ace_garage_fnc_getOptions
 *
 * Public: Yes
 */
 
params ["_classname"];

private _animationCfg = (configfile >> "CfgVehicles" >> _classname >> "AnimationSources");
private _textureCfg = (configfile >> "CfgVehicles" >> _classname >> "TextureSources");

// Get textures
private _textures = [];
for "_i" from 0 to (count _textureCfg - 1) do {
    private _cfg = _textureCfg select _i;
    if (isText (_cfg >> "DisplayName")) then {
        private _displayName = getText (_cfg >> "DisplayName");
        private _textureSrc = configName _cfg;
        _textures append [[_displayName, _textureSrc]];
    };
};

// Get animations
private _animations = [];
for "_i" from 0 to (count _animationCfg - 1) do {
    private _cfg = _animationCfg select _i;
    if (isText (_cfg >> "DisplayName")) then {
        private _displayName = getText (_cfg >> "DisplayName");
        private _animationSrc = configName _cfg;
        _animations append [[_displayName, _animationSrc]];
    };
};

[_textures, _animations]
