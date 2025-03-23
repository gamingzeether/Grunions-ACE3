#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Opens loitering munition control dialog
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_loitering_munitions_fnc_openDialog
 *
 * Public: No
 */

createDialog QGVAR(loitering_dialog);
GVAR(startPosWorld) = getPosASL ACE_player;
GVAR(radius) = ([] call FUNC(getLoiterDistance)) select 0;
GVAR(altitude) = (getPosASL ACE_player select 2) + 100;

private _map = findDisplay 28880 displayCtrl 10;
_map ctrlMapAnimAdd [0, ctrlMapScale _map, ACE_player];
ctrlMapAnimCommit _map;

(findDisplay 28880 displayCtrl 11) ctrlSetStructuredText parseText format [LLSTRING(altitude), round GVAR(altitude), round (GVAR(altitude) - getTerrainHeightASL GVAR(startPosWorld))];

_map ctrlAddEventHandler ["Draw", {
    (_this select 0) drawEllipse [GVAR(startPosWorld), GVAR(radius), GVAR(radius), 0, [1, 0, 0, 1], ""]; 
    (_this select 0) drawIcon ["\A3\ui_f\data\IGUI\Cfg\Targeting\ImpactPoint_ca.paa", [1, 0, 0, 1], GVAR(startPosWorld), 30, 30, 45];
}];
