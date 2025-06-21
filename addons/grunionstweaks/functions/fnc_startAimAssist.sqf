#include "..\script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

zeeth_aimassist_distance = 1000;

zeeth_aimassist_enabled = false;

["ACE " + LLSTRING(Category), QGVAR(toggleAimAssist), LLSTRING(ToggleAimAssist), {
    zeeth_aimassist_enabled = !zeeth_aimassist_enabled;
    false
}, {false}] call CBA_fnc_addKeybind;

//[zeeth_aimassist_eh1] call CBA_fnc_removePerFrameHandler;
//[zeeth_aimassist_eh2] call CBA_fnc_removePerFrameHandler;
//["muzzle", zeeth_aimassist_eh3] call CBA_fnc_removePlayerEventHandler;
//removeMissionEventHandler ["EntityKilled", zeeth_aimassist_eh4];

zeeth_aimassist_fnc_updateWeaponInfo = {
    private _magConfig = configFile >> "CfgMagazines" >> currentMagazine player;
    private _ammoConfig = configFile >> "CfgAmmo" >> getText (_magConfig >> "ammo");
    private _initSpeed = getNumber (_magConfig >> "initSpeed");
    if (_initSpeed > 0) then {
        zeeth_aimassist_projectileSpeed = _initSpeed;
        zeeth_aimassist_projectileFriction = getNumber (_ammoConfig >> "airFriction");
    };
};

zeeth_aimassist_eh1 = [{
    zeeth_aimassist_targets = (player nearObjects ["AllVehicles", zeeth_aimassist_distance]) select {
        (alive _x) &&
        {primaryWeapon _x != ""} &&
        {[side _x, side player] call BIS_fnc_sideIsEnemy}
    };

    // Sort targets by distance
    for "_i" from 0 to (count zeeth_aimassist_targets - 2) do {
        private _cur = zeeth_aimassist_targets select _i;
        private _canidateIndex = _i + 1;
        private _canidateDist = player distance (zeeth_aimassist_targets select _canidateIndex);
        for "_j" from _canidateIndex to (count zeeth_aimassist_targets - 1) do {
            private _tempDist = (zeeth_aimassist_targets select _j) distance player;
            if (_tempDist < _canidateDist) then {
                _canidateDist = _tempDist;
                _canidateIndex = _j;
            };
        };
        zeeth_aimassist_targets set [_i, zeeth_aimassist_targets select _canidateIndex];
        zeeth_aimassist_targets set [_canidateIndex, _cur];
    };

    call zeeth_aimassist_fnc_updateWeaponInfo;
}, 5] call CBA_fnc_addPerFrameHandler;

zeeth_aimassist_eh2 = [{
    if (!zeeth_aimassist_enabled) exitWith {};

    private _foundAimAssistTarget = false;
    {
        private _targetPos = aimPos _x;
        private _playerPos = aimPos player;
        private _realDistance = _playerPos distance _targetPos;
        private _distance = _realDistance;
        private _targetLeadPos = nil;
        private _windSqr = (vectorNormalized wind) vectorMultiply (vectorMagnitudeSqr wind);

        if (true) then {
            private _travelTime = _distance / zeeth_aimassist_projectileSpeed;
            _targetLeadPos = _targetPos;

            // Target lead
            _targetLeadPos = _targetLeadPos vectorAdd ((velocity _x) vectorMultiply (_travelTime + moveTime _x));
            _distance = _playerPos distance _targetLeadPos;
            _travelTime = _distance / zeeth_aimassist_projectileSpeed;

            // Wind
            // This doesnt look right lmao but im not doing the math
            _targetLeadPos = _targetLeadPos vectorAdd (wind vectorMultiply (0.5 * zeeth_aimassist_projectileFriction * zeeth_aimassist_projectileSpeed * _travelTime * _travelTime));
            _distance = _playerPos distance _targetLeadPos;
            _travelTime = _distance / zeeth_aimassist_projectileSpeed;

            // Gravity
            _targetLeadPos = _targetLeadPos vectorAdd [0, 0, 4.9 * _travelTime * _travelTime];

            // Zeroing
            //private _zero = [player] call ace_scopes_fnc_getCurrentZeroRange;
            //private _angle = _unit getVariable ["ace_scopes_Adjustment", [[0, 0, 0], [0, 0, 0], [0, 0, 0]]];
            //_targetLeadPos set [2, (_realDistance * sin _angle) + ((_targetLeadPos select 2) * cos _angle)];
        };

        private _alpha = 0.3;
        if (!isNil "_targetLeadPos") then {
            private _intersects1 = lineIntersectsSurfaces [_playerPos, _targetLeadPos, player, _x, true, 1, "FIRE"];
            private _intersects2 = lineIntersectsSurfaces [_playerPos, _targetPos, player, _x, true, 1, "FIRE"];
            if (_intersects1 isEqualTo [] && {_intersects2 isEqualTo []}) then {
                _alpha = 0.7;
                //if (!_foundAimAssistTarget) then {
                    //_foundAimAssistTarget = true;
                    // private _weaponVectorOff = (player weaponDirection currentWeapon player) vectorDiff (_playerPos vectorFromTo _targetLeadPos);
                    // player setVectorDir (vectorDir player vectorAdd (_weaponVectorOff vectorMultiply -1));
                    // player setDir (getDir player - (15 / _distance));
                //};
            };
        };

        // Draw icons and line
        _targetPos = ASLToAGL _targetPos;
        private _color = [1, 0, 0, _alpha];
        drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", _color, _targetPos, 1, 1, 0, format ["%1m | %2 | %3", round (_playerPos distance _x), 100 - round (100 * damage _x), getNumber (configOf _x >> "armor")]];
        if (!isNil "_targetLeadPos") then {
            _targetLeadPos = ASLToAGL _targetLeadPos;
            drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa", _color, _targetLeadPos, 0.5, 0.5, 0];
            drawLine3D [_targetPos, _targetLeadPos, _color];
        };

    } forEach zeeth_aimassist_targets;
}, 0] call CBA_fnc_addPerFrameHandler;

zeeth_aimassist_eh3 = ["muzzle", {call zeeth_aimassist_fnc_updateWeaponInfo}] call CBA_fnc_addPlayerEventHandler;

zeeth_aimassist_eh4 = addMissionEventHandler ["EntityKilled", {
    params ["_unit"];

    zeeth_aimassist_targets deleteAt (zeeth_aimassist_targets find _unit);
}];

//zeeth_aimassist_eh2
