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

[{
    if (GVAR(autorunning)) then {
        private _heightDiff = abs ((getTerrainHeightASL getPosASL ACE_player) - (getTerrainHeightASL (getPosASL ACE_player vectorAdd vectorDir ACE_player)));
        private _speedIndex = if (_heightDiff < 0.3) then {
            0
        } else {
            if (_heightDiff < 0.55) then {
                1
            } else {
                2
            }
        };
        private _anim = ["amovpercmevasnonwnondf", "amovpercmrunsnonwnondf", "amovpercmwlksnonwnondf"] select _speedIndex;
        ACE_player playMoveNow _anim;
        
        if ((!isNull (ACE_controlledUAV select 0)) || {vehicle ACE_player != ACE_player} || {surfaceIsWater (getPosASL ACE_player)} || {!(lifeState ACE_player in ["HEALTHY", "INJURED"])}) then {
            GVAR(autorunning) = false;
        };
    };
}, 0] call CBA_fnc_addPerFrameHandler;
