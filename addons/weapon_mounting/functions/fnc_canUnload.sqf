#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if weapon can be unloaded
 *
 * Arguments:
 * Action args
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_weapon_mounting_fnc_canUnload
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

(count (_vehicle magazinesTurret [-1]) > 0)
