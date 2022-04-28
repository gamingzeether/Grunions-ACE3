#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Casts a fishing rod
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Bobber velocity in world space <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, [0,20,5]] call ace_fyshing_fnc_castRod;
 *
 * Public: No
 */

params ["_unit", "_vel"];

_unit playActionNow "ThrowGrenade";

[{
    params ["_unit", "_vel"];
    private _startPos = (eyePos _unit) vectorAdd (eyeDirection _unit);
    
    private _bobber = createVehicle [QGVAR(bobber), [0,0,0]];
    _bobber setPosASL (_startPos vectorAdd [0, 0, 0.5]);
    _bobber setVelocity _vel;
    _bobber enableRopeAttach true;
    _bobber setCenterOfMass [0,0.01,-0.1];
    
    private _ropeParent = createVehicle ["Land_PortableHelipadLight_01_F", [0,0,0]];
    hideObject _ropeParent;
    [_ropeParent, QUOTE(ADDON)] call EFUNC(common,hideUnit);
    _ropeParent setPosASL _startPos;
    
    private _ropeLength = getNumber (configFile >> "CfgWeapons" >> currentWeapon _unit >> QGVAR(ropeLength));
    private _line = ropeCreate [_ropeParent, [0,0,0], _bobber, [0,0,0], _ropeLength];
    GVAR(reeling) = false;
    
    [LINKFUNC(rodPFH), 0, [_bobber, _line, _ropeParent, _unit, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;
    GVAR(PFHRunning) = true;
    
    [{
        params ["_bobber"];
        
        if (isNull _bobber) exitWith {};
        if (!surfaceIsWater getPosASL _bobber) exitWith {};
        if (getPosASL _bobber select 2 > 0.1) exitWith {};
        
        private _fishType = call FUNC(getRandomFyshType);
        //private _fish = createAgent [_fishType, [0,0,0], [], 0, "CAN_COLLIDE"];
        private _fish = createVehicle [_fishType, [0,0,0], [], 0, "CAN_COLLIDE"];
        _fish attachTo [_bobber, [0,0,-0.2]];
        _fish setVectorDirAndUp [[0,0,1], [1,0,0]];
        _bobber setVariable [QGVAR(attachedFish), [_fish]];
        
        _bobber addForce [[0,0,-4], [0,0,0]];
        private _ps1 = "#particlesource" createVehicleLocal position _bobber;
        _ps1 setParticleClass "WaterSplash";
        _ps1 setDropInterval 0.01;
        [{
            params ["_particleSource"];
            deleteVehicle _particleSource;
        }, [_ps1], 0.2] call CBA_fnc_waitAndExecute;
    }, [_bobber], random [10, 20, 60]] call CBA_fnc_waitAndExecute;
}, _this, 0.5] call CBA_fnc_waitAndExecute;
