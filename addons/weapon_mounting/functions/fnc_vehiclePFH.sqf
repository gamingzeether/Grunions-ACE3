#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Per frame handler that handles rotating weapon to camera direction
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_weapon_mounting_fnc_vehiclePFH
 *
 * Public: No
 */

params ["_args", "_handle"];
_args params ["_vehicle"];

private _mountedWeapon = _vehicle getVariable [QGVAR(mountedWeapon), objNull];

if (isNull _mountedWeapon) exitWith {
    [_handle] call CBA_fnc_removePerFrameHandler;
    _vehicle setVariable [QGVAR(pfhHandle), -1];
};

private _direction = [_vehicle] call FUNC(getWeaponDirection);

if (count _direction > 0) then {
    // weapon forward is the right side of the model
    private _right = _direction vectorCrossProduct (vectorUp _vehicle);
    private _up = _right vectorCrossProduct _direction;
    
    _right = _vehicle vectorWorldToModel _right;
    _up = _vehicle vectorWorldToModel _up;
    
    _mountedWeapon setVectorDirAndUp [_right, _up];
};

#ifdef DRAW_AIM_DIR
private _startPos = _mountedWeapon modelToWorldVisualWorld (_mountedWeapon getVariable QGVAR(muzzlePos));
private _vec = (vectorUp _mountedWeapon) vectorCrossProduct (vectorDir _mountedWeapon);
private _endPos = _startPos vectorAdd (_vec vectorMultiply 500);

_startPos = ASLtoAGL _startPos;
_endPos = ASLtoAGL _endPos;

drawLine3D [_startPos, _endPos, [1,0,0,1]];
#endif
