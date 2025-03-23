#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if weapon can be mounted
 *
 * Arguments:
 * 0: CfgWeapons classname <STRING>
 * 1: Vehicle <OBJECT>
 * 2: Position relative (Default: []) <ARRAY>
 *
 * Return Value:
 * Can mount <BOOL>
 *
 * Example:
 * ["MMG_01_base_F", quadbike] call ace_weapon_mounting_fnc_canMountWeapon
 *
 * Public: Yes
 */

params ["_weapon", "_vehicle", ["_position", []]];

if (!alive _vehicle) exitWith {false};

private _wCfg = (configFile >> "CfgWeapons" >> _weapon);
private _vCfg = configOf _vehicle;

if (!isClass _wCfg) exitWith {false};

// Check if it has free spots
private _ret = false;
if (_position isEqualTo []) then {
    private _mountingPositions = _vehicle getVariable QGVAR(freePositions);
    if (isNil "_mountingPositions") then {
        _mountingPositions = getArray (_vCfg >> QGVAR(mountingPositions));
    };
    _ret = (count _mountingPositions == 0);
};
if (_ret) exitWith {false};

if (getText (_wCfg >> "model") == "") exitWith {false};

// Check if weapon has carryable magazine
/*
private _mags = getArray (_wCfg >> "magazines");
private _hasCarryable = false;
{
    private _mCfg = (configFile >> "CfgMagazines" >> _x);
    if (getNumber (_mCfg >> "scope") == 2 && {getNumber (_mCfg >> "type") == 256}) then {
        _hasCarryable = true;
        break;
    };
} forEach _mags;
if (!_hasCarryable) exitWith {false};
*/

// Check if vehicle type allows launchers
// Some vehicles like quadbikes are incompatible with launchers and the projectile disappears
if ((_weapon isKindOf ["Launcher", configFile >> "CfgWeapons"]) && {getNumber (_vCfg >> QGVAR(launchersAllowed)) != 1}) exitWith {false};

true
