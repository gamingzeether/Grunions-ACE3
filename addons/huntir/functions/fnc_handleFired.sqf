#include "..\script_component.hpp"
/*
 * Author: Norrin, Rocko, Ruthberg
 *
 * Handles HuntIR projectiles. Called from the ammo fired EH for the local player.
 *
 * Arguments:
 * None. Parameters inherited from EFUNC(common,firedEH)
 *
 * Return Value:
 * None
 *
 * Example:
 * call ACE_huntir_fnc_handleFired
 *
 * Public: No
 */

params ["_unit", "", "", "", "", "", "_projectile"];
TRACE_2("handleFired",_unit,_projectile);

// Don't run for non players, as they are too dumb to launch huntirs anyway
if (_unit != ACE_player) exitWith {};

[{
    params ["_projectile"];

    //If null (deleted or hit water) exit:
    if (isNull _projectile) exitWith {};
    //If it's not spinning (hit ground), bail:
    if ((vectorMagnitude (velocity _projectile)) < 0.1) exitWith {};

    "ACE_HuntIR_Propell" createVehicle (getPosATL _projectile);
    [{
        params ["_position"];
        private _huntir = createVehicle ["ACE_HuntIR", _position, [], 0, "FLY"];
        _huntir setPosATL _position;
        _huntir setVariable [QGVAR(startTime), CBA_missionTime, true];
        [{
            params ["_args", "_idPFH"];
            _args params ["_huntir"];
            if (isNull _huntir) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            private _parachuteDamage = _huntir getHitPointDamage "HitParachute";
            if (_parachuteDamage > 0) then {
                private _velocity = velocity _huntir;
                _velocity set [2, -1 min -20 * sqrt(_parachuteDamage)];
                _huntir setVelocity _velocity;
                _huntir setVectorUp [0, 0, 1];
            };
        }, 0, [_huntir]] call CBA_fnc_addPerFrameHandler;
    }, [getPosATL _projectile vectorAdd [0, 0, 50]], 2, 0] call CBA_fnc_waitAndExecute;
}, [_projectile], 5, 0] call CBA_fnc_waitAndExecute;
