#include "script_component.hpp"
/*
 * Author: GamingZeether
 *
 * Arguments:
 * Guidance Arg Array <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_fyshing_fnc_Fysh_onFired
 *
 * Public: No
 */

params ["_firedEH", "_launchParams", "", "", "_stateParams"];
_firedEH params ["_shooter","","","","","","_projectile"];
_stateParams params ["", "_seekerStateParams"];
_launchParams params ["","_targetLaunchParams"];
_targetLaunchParams params ["_target"];

_seekerStateParams set [0, CBA_missionTime];
