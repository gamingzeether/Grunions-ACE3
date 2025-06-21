#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Initalizes phoenix
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_zeeth_experimental_fnc_initPhoenix
 * 
 * Public: No
 */

GVAR(phoenixRocket) = objNull;

#define TURN_RATE 0.01

GVAR(phoenixPitch) = 0;
GVAR(phoenixYaw) = 0;

[LLSTRING(Addon), QGVAR(phoenixExit), "Exit Phoenix", {
    GVAR(phoenixRocket) = objNull;
}, {}] call CBA_fnc_addKeybind;

[LLSTRING(Addon), QGVAR(phoenixUp), LLSTRING(Phoenix_KeybindUp), {
    if (!isNull GVAR(phoenixRocket)) then {
        GVAR(phoenixPitch) = TURN_RATE;
        true
    }
}, {
    GVAR(phoenixPitch) = 0;
}] call CBA_fnc_addKeybind;

[LLSTRING(Addon), QGVAR(phoenixDown), LLSTRING(Phoenix_KeybindDown), {
    if (!isNull GVAR(phoenixRocket)) then {
        GVAR(phoenixPitch) = -TURN_RATE;
        true
    }
}, {
    GVAR(phoenixPitch) = 0;
}] call CBA_fnc_addKeybind;

[LLSTRING(Addon), QGVAR(phoenixLeft), LLSTRING(Phoenix_KeybindLeft), {
    if (!isNull GVAR(phoenixRocket)) then {
        GVAR(phoenixYaw) = -TURN_RATE;
        true
    }
}, {
    GVAR(phoenixYaw) = 0;
}] call CBA_fnc_addKeybind;

[LLSTRING(Addon), QGVAR(phoenixRight), LLSTRING(Phoenix_KeybindRight), {
    if (!isNull GVAR(phoenixRocket)) then {
        GVAR(phoenixYaw) = TURN_RATE;
        true
    }
}, {
    GVAR(phoenixYaw) = 0;
}] call CBA_fnc_addKeybind;


[{
    if (isNull GVAR(phoenixRocket)) exitWith {};
    
    private _vectorChange = [GVAR(phoenixYaw), 0, GVAR(phoenixPitch)];
    private _vector = vectorDir GVAR(phoenixRocket) vectorAdd (GVAR(phoenixRocket) vectorModelToWorld _vectorChange);
    GVAR(phoenixRocket) setVectorDirAndUp [_vector, [0, 0, 1]];
    GVAR(phoenixRocket) setVelocity (_vector vectorMultiply vectorMagnitude velocity GVAR(phoenixRocket));
}, 0] call CBA_fnc_addPerFrameHandler;

// Handle firing weapon
[QGVAR(phoenix), {_this select 0 == QGVAR(Phoenix_Ammo)}, true, false, false, true, false, false] call EFUNC(common,registerAmmoFiredEvent);
[QGVAR(phoenix), {
    [{
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
        
        _projectile switchCamera "Internal";
        GVAR(phoenixRocket) = _projectile;
        
        [{isNull GVAR(phoenixRocket)}, {ACE_player switchCamera "Internal";}] call CBA_fnc_waitUntilAndExecute;
    }, _this, 0.1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
