#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Handles mouse events in dialog
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Distance <ARRAY>
 *  0: Min distance <NUMBER>
 *  1: Max distance <NUMBER>
 *
 * Example:
 * [] call ace_loitering_munitions_fnc_getLoiterDistance
 *
 * Public: No
 */

[
    [],
    {
        private _ammo = getText (configFile >> "CfgMagazines" >> currentMagazine (vehicle ACE_player) >> "ammo");
        private _ammoCfg = (configFile >> "CfgAmmo" >> _ammo >> QUOTE(ADDON));
        if (getNumber (_ammoCfg >> "enabled") != 1) exitWith {[-1, -1]};
        
        [getNumber (_ammoCfg >> "minLoiterRadius"), getNumber (_ammoCfg >> "maxLoiterRadius")]
    },
    missionNamespace,
    QGVAR(loiterDistance),
    5
] call EFUNC(common,cachedCall)
