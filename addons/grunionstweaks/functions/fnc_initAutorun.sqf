#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

GVAR(autorunning) = false;
["ACE " + LLSTRING(Category), QGVAR(autorun), LLSTRING(Autorun), {
    if (currentWeapon ACE_player == "") then {
        GVAR(autorunning) = !GVAR(autorunning);
    } else {
        [ACE_player] call EFUNC(weaponselect,putWeaponAway);
        [{GVAR(autorunning) = !GVAR(autorunning)}, nil, 2.5] call CBA_fnc_waitAndExecute;
    };
    true
}, {false}] call CBA_fnc_addKeybind;

["ACE " + LLSTRING(Category), QGVAR(autorunCancel), LLSTRING(AutorunCancel), {
    if (GVAR(autorunning)) then {
        GVAR(autorunning) = false;
        ACE_player playMoveNow "";
    };
    false
}, {false}] call CBA_fnc_addKeybind;

[{
    if (GVAR(autorunning)) then {
        private _playerPos = getPosASL ACE_player vectorAdd [0, 0, 0.1];
        if ((!isNull (ACE_controlledUAV select 0)) || {vehicle ACE_player != ACE_player} || {surfaceIsWater (getPosASL ACE_player)} || {getFatigue ACE_player == 1} || {damage ACE_player >= 0.5} || {!(lifeState ACE_player in ["HEALTHY", "INJURED"])}) exitWith {
            GVAR(autorunning) = false;
        };
        
        private _heightDiff = abs ((getTerrainHeightASL _playerPos) - (getTerrainHeightASL (_playerPos vectorAdd vectorDir ACE_player)));
        private _speedIndex = if (_heightDiff < 0.3) then {
            2
        } else {
            if (_heightDiff < 0.55) then {
                1
            } else {
                0
            }
        };
        
        if (!isSprintAllowed ACE_player) then {
            _speedIndex = _speedIndex min 1;
        };
        if (isForcedWalk ACE_player) then {
            _speedIndex = 0;
        };
        
        private _anim = ["amovpercmwlksnonwnondf", "amovpercmrunsnonwnondf", "amovpercmevasnonwnondf"] select _speedIndex;
        ACE_player playMoveNow _anim;
    };
}, 0] call CBA_fnc_addPerFrameHandler;
