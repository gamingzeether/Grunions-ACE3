#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Updates smart pistol targets
 *
 * Arguments:
 * 0: New targets <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, jeff]] call ace_zeeth_experimental_fnc_smartPistolUpdateTargets
 * 
 * Public: No
 */

params ["_targets"];
{
    if (!(_x in _targets)) then {
        _x setVariable [QGVAR(smartPistol_lockProgress), 0];
    };
} forEach GVAR(smartPistolTargets);
GVAR(smartPistolTargets) = _targets;
