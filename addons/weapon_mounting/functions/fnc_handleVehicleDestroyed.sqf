#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Handles vehicle being destroyed
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [quadbike] call ace_weapon_mounting_fnc_handleVehicleDestroyed
 *
 * Public: No
 */

params ["_vehicle"];

if (!local _vehicle) exitWith {};

_mountedWeapon = _vehicle getVariable [QGVAR(mountedWeapon), objNull];
if (isNull _mountedWeapon) exitWith {};

// Weapon holders with CSW bags aren't being simulated correctly
if (!(_vehicle getVariable QGVAR(cswMags))) then {
    private _weaponName = _mountedWeapon getVariable QGVAR(config);
    private _weaponClass = _mountedWeapon getVariable QGVAR(originalWeapon);
    private _addedVelocity = (vectorNormalized (getPosASL _vehicle vectorFromTo getPosASL _mountedWeapon)) vectorMultiply 8;
    private _weaponHolder = createVehicle ["WeaponHolderSimulated", [0, 0, 0], [], 0, "CAN_COLLIDE"];
    _weaponHolder addItemCargoGlobal [_weaponClass, 1];
    _weaponHolder setPosASL getPosASL _mountedWeapon;
    _weaponHolder setVelocity (velocity _vehicle vectorAdd _addedVelocity);
    _weaponHolder addTorque ([1 - random 2, 1 - random 2, 1 - random 2] vectorMultiply 0.1);
};

deleteVehicle _mountedWeapon;
