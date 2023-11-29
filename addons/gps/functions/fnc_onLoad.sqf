#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Handles GPS dialog opening
 *
 * Arguments:
 * Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_onLoad
 *
 * Public: No
 */

params ["_display"];

private _map = _display displayCtrl 10;
_map ctrlMapAnimAdd [0, ctrlMapScale _map, vehicle ACE_player];
ctrlMapAnimCommit _map;
