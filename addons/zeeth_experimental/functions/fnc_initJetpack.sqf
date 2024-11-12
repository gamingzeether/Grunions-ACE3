#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Initalizes jetpack
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_zeeth_experimental_fnc_initJetpack
 * 
 * Public: No
 */

GVAR(jetpackDown) = false;
GVAR(jetpackEquipped) = false;
GVAR(jetpackRechargeCooldown) = 0;
GVAR(jetpackFuelMax) = 5;
GVAR(jetpackFuel) = GVAR(jetpackFuelMax);
GVAR(jetpackInAir) = false;

((uiNamespace getVariable [QGVAR(overlay), displayNull]) displayCtrl 1 controlsGroupCtrl 0) ctrlShow false;

[LLSTRING(Addon), QGVAR(jetpack), LLSTRING(Jetpack_KeybindActivate), {
    if (GVAR(jetpackInAir)) then {
        GVAR(jetpackDown) = true;
    } else {
        [{
            GVAR(jetpackDown) = true;
        }, nil, 0.1] call CBA_fnc_waitAndExecute;
    };
}, {
    GVAR(jetpackDown) = false; 
    GVAR(jetpackRechargeCooldown) = 1;
}] call CBA_fnc_addKeybind;

// Jetpack per frame code
[{
    if (!GVAR(jetpackEquipped)) exitWith {};
    
    private _playerPos = getPosASL ACE_player;
    private _heightTerrain = getPos ACE_player select 2;
    
    if (GVAR(jetpackInAir)) then {
        // Reset anim
        if (!(animationState ACE_player in ["afalpercmstpsraswrfldnon", "afalpercmstpsraswpstdnon", "afalpercmstpsraswlnrdnon", "afalpercmstpsnonwnondnon"])) then {
            private _anim = "";
            switch (currentWeapon ACE_player) do {
                case "": {
                    _anim = "afalpercmstpsnonwnondnon";
                };
                case primaryWeapon ACE_player: {
                    _anim = "afalpercmstpsraswrfldnon";
                };
                case secondaryWeapon ACE_player: {
                    _anim = "afalpercmstpsraswlnrdnon";
                };
                case handgunWeapon ACE_player: {
                    _anim = "afalpercmstpsraswpstdnon";
                };
            };
            ACE_player playMoveNow _anim;
        };
    };
    
    private _fuelBar = (uiNamespace getVariable [QGVAR(overlay), displayNull]) displayCtrl 1 controlsGroupCtrl 0;
    // Jetpack movement and fuel
    if ((GVAR(jetpackDown) && {isNull objectParent ACE_player} && {getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> animationState ACE_player >> "disableWeapons") == 0})) then {
        if (_heightTerrain > 1) then {
            GVAR(jetpackInAir) = true;
        };
        
        GVAR(jetpackFuel) = GVAR(jetpackFuel) - diag_deltaTime;
        if (GVAR(jetpackFuel) <= 0) then {
            GVAR(jetpackFuel) = 0;
        };
        GVAR(jetpackRechargeCooldown) = 1;
        _fuelBar ctrlShow true;
        _fuelBar progressSetPosition (GVAR(jetpackFuel) / GVAR(jetpackFuelMax));
        
        // Strafing
        private _vector = [0, 1, 14];
        if (inputAction "MoveForward" > 0) then {
            _vector = _vector vectorAdd [0, JETPACK_STRAFESPEED, 0];
        } else {
            if (inputAction "MoveBack" > 0) then {
                _vector = _vector vectorAdd [0, -JETPACK_STRAFESPEED, 0];
            };
        };
        if (inputAction "TurnRight" > 0) then {
            _vector = _vector vectorAdd [JETPACK_STRAFESPEED, 0, 0];
        } else {
            if (inputAction "TurnLeft" > 0) then {
                _vector = _vector vectorAdd [-JETPACK_STRAFESPEED, 0, 0];
            };
        };
        
        // Apply velocity change
        private _velocityAdd = (ACE_player vectorModelToWorld _vector) vectorMultiply diag_deltaTime;
        ACE_player setVelocity (velocity ACE_player vectorAdd _velocityAdd);
    } else {
        GVAR(jetpackRechargeCooldown) = (GVAR(jetpackRechargeCooldown) - diag_deltaTime) max 0;
        if (GVAR(jetpackRechargeCooldown) == 0) then {
            GVAR(jetpackFuel) = (GVAR(jetpackFuel) + diag_deltaTime * 0.75) min GVAR(jetpackFuelMax);
        };
        
        if (GVAR(jetpackFuel) == GVAR(jetpackFuelMax)) then {
            _fuelBar ctrlShow false;
        } else {
            _fuelBar progressSetPosition (GVAR(jetpackFuel) / GVAR(jetpackFuelMax));
            _fuelBar ctrlShow true;
            _fuelBar ctrlSetActiveColor [JETPACK_READYCOLOR];
        };
        
        private _velocity = velocity ACE_player;
        if (GVAR(jetpackInAir) && {_velocity select 2 < 0} && {_heightTerrain < 2} && {_heightTerrain > 0}) then {
            _velocity set [2, (_velocity select 2) * 0.95];
            ACE_player setVelocity _velocity;
            if (_heightTerrain < 0.1) then {
                GVAR(jetpackInAir) = false;
            };
        };
    };
}, 0] call CBA_fnc_addPerFrameHandler;
