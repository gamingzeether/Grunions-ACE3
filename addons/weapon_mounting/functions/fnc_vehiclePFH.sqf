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

if (driver _vehicle != ACE_player) exitWith {};

private _mountedWeapon = _vehicle getVariable [QGVAR(mountedWeapon), objNull];

if (isNull _mountedWeapon) exitWith {
    [_handle] call CBA_fnc_removePerFrameHandler;
    _vehicle setVariable [QGVAR(pfhHandle), -1];
};

private _eyeForward = getCameraViewDirection ACE_player;

if ((_eyeForward vectorDotProduct (vectorDir _vehicle)) > 0.7) then {
    // weapon forward is the right side of the model
    private _eyeRight = _eyeForward vectorCrossProduct (vectorUp _vehicle);
    private _eyeUp = _eyeRight vectorCrossProduct _eyeForward;
    
    _eyeRight = _vehicle vectorWorldToModel _eyeRight;
    _eyeUp = _vehicle vectorWorldToModel _eyeUp;
    
    _mountedWeapon setVectorDirAndUp [_eyeRight, _eyeUp];
};

#ifdef DRAW_AIM_DIR
private _startPos = _mountedWeapon modelToWorldVisualWorld (_mountedWeapon getVariable QGVAR(muzzlePos));
private _vec = (vectorUp _mountedWeapon) vectorCrossProduct (vectorDir _mountedWeapon);
private _endPos = _startPos vectorAdd (_vec vectorMultiply 500);

_startPos = ASLtoAGL _startPos;
_endPos = ASLtoAGL _endPos;

drawLine3D [_startPos, _endPos, [1,0,0,1]];
#endif
