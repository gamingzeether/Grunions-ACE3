#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Throw fish event handler
[QGVAR(fyshThrown), LINKFUNC(handleFired)] call CBA_fnc_addEventHandler;
[QGVAR(fyshThrown), {
    params ["_ammo", "_ammoConfig"];
    (_ammo in [QGVAR(fysh_explosive), QGVAR(fysh)])
}, true, false, true, true, false, true] call EFUNC(common,registerAmmoFiredEvent);

// Loitering fish event handler
[QGVAR(loiteringFyshThrown), {
    [{
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
    
        // If null (deleted or hit water) exit:
        if (isNull _projectile) exitWith {};
        
        // Minimum arming distance
        if (_projectile distance _unit <= 10) exitWith {};
    
        // Save grenade state
        private _posASL = getPosASL _projectile;
        private _vel = velocity _projectile;
    
        // Swap fired GL to a missile type
        deleteVehicle _projectile;
        private _rocket = QGVAR(fysh_loitering) createVehicle (getPosATL _projectile);
        [QEGVAR(common,setShotParents), [_rocket, _unit, _unit]] call CBA_fnc_serverEvent;
    
        // Set correct position, velocity and direction (must set velocity before changeMissileDirection)
        _rocket setPosASL _posASL;
        _rocket setVelocity _vel;
        [_rocket, vectorNormalized _vel] call EFUNC(missileguidance,changeMissileDirection);
    
        // Start missile guidance
        [_unit, _weapon, _muzzle, _mode, QGVAR(fysh_loitering), _magazine, _rocket] call EFUNC(missileguidance,onFired);
    }, _this, 1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
[QGVAR(loiteringFyshThrown), {
    params ["_ammo", "_ammoConfig"];
    (_ammo == QGVAR(fysh_loitering_throw))
}, true, false, true, true, false, true] call EFUNC(common,registerAmmoFiredEvent);

// Fyshing rod stuff
["weapon", LINKFUNC(handleWeaponChanged)] call CBA_fnc_addPlayerEventHandler;
GVAR(PFHRunning) = false;
