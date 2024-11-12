#include "..\script_component.hpp"
/*
 * Author: GamingZeether
 * Initalizes smart pistol stuff
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_zeeth_experimental_fnc_initSmartPistol
 * 
 * Public: No
 */

#define HEADPOS(var1) (var1 modelToWorldVisualWorld (var1 selectionPosition "head_hit") vectorAdd [0, 0, 0.05])

GVAR(smartPistolEquipped) = false;
GVAR(smartPistolTargets) = [];
GVAR(smartPistolPrimaryTarget) = objNull;

// Handle weapon switching
["weapon", {
    params ["_unit", "_newWeapon", "_oldWeapon"];
    
    if (_newWeapon == QGVAR(SmartPistol_Weapon)) then {
        GVAR(smartPistolEquipped) = true;
        private _sidePlayer = side ACE_player;
        [(ACE_player nearEntities ["Man", 300]) select {[_sidePlayer, side _x] call BIS_fnc_sideIsEnemy}] call FUNC(smartPistolUpdateTargets);
    } else {
        GVAR(smartPistolEquipped) = false;
        [[]] call FUNC(smartPistolUpdateTargets);
    };
}, true] call CBA_fnc_addPlayerEventHandler;

// Rescan for targets
[{
    if (!GVAR(smartPistolEquipped)) exitWith {};
    
    private _sidePlayer = side ACE_player;
    [(ACE_player nearEntities ["Man", 300]) select {[_sidePlayer, side _x] call BIS_fnc_sideIsEnemy}] call FUNC(smartPistolUpdateTargets);
}, 10] call CBA_fnc_addPerFrameHandler;

private _muzzleProxyName = getText (configFile >> "CfgWeapons" >> QGVAR(SmartPistol_Weapon) >>  "muzzlePos");
private _dummyWeapon = createSimpleObject [getText (configFile >> "CfgWeapons" >> QGVAR(SmartPistol_Weapon) >> "model"), [0,0,0], true];
GVAR(smartPistolMuzzleOffset) = _dummyWeapon selectionPosition [_muzzleProxyName, 1];
deleteVehicle _dummyWeapon;

// Draw icons and line
addMissionEventHandler ["Draw3D", {
    if (!GVAR(smartPistolEquipped)) exitWith {};
    
    private _zoom = call EFUNC(common,getZoom);
    
    private _gunPos = ACE_player modelToWorldWorld (ACE_player selectionPosition "proxy:\a3\characters_f\proxies\pistol.001");
    private _weaponDirAndUp = ACE_player selectionVectorDirAndUp ["proxy:\a3\characters_f\proxies\pistol.001", 1];
    private _v2 = ACE_player vectorModelToWorld (_weaponDirAndUp select 0);  //right
    private _v3 = ACE_player vectorModelToWorld (_weaponDirAndUp select 1);  //up
    private _v1 = _v3 vectorCrossProduct _v2;                                //forward
    GVAR(smartPistolMuzzleOffset) params ["_o1", "_o2", "_o3"];
    private _muzzlePos = _gunPos vectorAdd (_v1 vectorMultiply -_o1) vectorAdd (_v2 vectorMultiply _o2) vectorAdd (_v3 vectorMultiply _o3);
    
    private _lockedTargets = [];
    {
        private _target = _x;
        private _targetPos = HEADPOS(_target);
        private _distance = _muzzlePos vectorDistance _targetPos;
        
        private _angle = (_muzzlePos vectorFromTo _targetPos) vectorDotProduct _v1; // Actually cosine of angle
        
        // Lock targets
        private _lockProgress = _target getVariable [QGVAR(smartPistol_lockProgress), 0];
        if (_angle >= SMARTPISTOL_CONE && {_distance <= SMARTPISTOL_LOCKDISTANCE} && {!(terrainIntersectASL [_muzzlePos, _targetPos])} && {!(lineIntersects [_muzzlePos, _targetPos, ACE_player, _x])}) then {
            _lockProgress = _lockProgress + diag_deltaTime * (_distance / SMARTPISTOL_LOCKDISTANCE);
            _target setVariable [QGVAR(smartPistol_lockProgress), _lockProgress];
        } else {
            _target setVariable [QGVAR(smartPistol_lockProgress), 0];
        };
        
        // Draw icon over targets' heads
        private _reticuleSize = 5 / sqrt (_distance) * _zoom;
        if (_lockProgress > 0) then {
            if (_lockProgress >= SMARTPISTOL_LOCKTHRESHOLD) then {
                drawIcon3D [
                    "\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa",
                    [1.0, 0.0, 0.1, 0.9],
                    ASLToAGL _targetPos,
                    _reticuleSize, _reticuleSize,
                    45
                ];
                
                // Draw segment of circle
                // Tangent to _v1 & intersect w/ _targetPos
                private _offset = _targetPos vectorDiff _muzzlePos;
                private _forwardOffset = _offset vectorDotProduct _v1;
                private _rightOffset = _offset vectorDotProduct _v2;
                private _upOffset = _offset vectorDotProduct _v3;
                
                private _yOffset = _forwardOffset;
                private _xOffset = sqrt (_upOffset * _upOffset + _rightOffset * _rightOffset);
                private _radius = (_yOffset * _yOffset + _xOffset * _xOffset) / (2 * _xOffset);
                
                private _xVector = vectorNormalized ((_v2 vectorMultiply _rightOffset) vectorAdd (_v3 vectorMultiply _upOffset));
                private _xStep = _xOffset / 25; // Could probably lower this for performance but it probably wont make much of an impact unless theres lots of targets
                private _prevPos = _muzzlePos;
                for "_lineX" from 0 to _xOffset step _xStep do {
                    // y = \sqrt{2xr-x^{2}}
                    private _lineY = sqrt (_lineX * (2 * _radius - _lineX));
                    
                    private _nextPos = _muzzlePos vectorAdd (_v1 vectorMultiply _lineY) vectorAdd (_xVector vectorMultiply _lineX);
                    
                    drawLine3D [
                        ASLToAGL _prevPos,
                        ASLToAGL _nextPos,
                        [1, 0, 0, 1]
                    ];
                    _prevPos = _nextPos;
                };
                
                _lockedTargets pushBack [_angle, _target];
            };
            
            // Icon with size that changes w/ _lockProgress
            _reticuleSize = _reticuleSize max (_reticuleSize + (SMARTPISTOL_LOCKTHRESHOLD - _lockProgress));
            drawIcon3D [
                "\a3\ui_f\data\IGUI\Cfg\Cursors\selectover_ca.paa",
                [1.0, (SMARTPISTOL_LOCKTHRESHOLD - _lockProgress) / SMARTPISTOL_LOCKTHRESHOLD, 0.1, 0.8],
                ASLToAGL _targetPos,
                _reticuleSize, _reticuleSize,
                0
            ];
        };
    } forEach GVAR(smartPistolTargets);
    
    // Select target closest to center
    private _maxAngle = -1;
    GVAR(smartPistolPrimaryTarget) = objNull;
    {
        _x params ["_angle", "_target"];
        if (_angle > _maxAngle) then {
            GVAR(smartPistolPrimaryTarget) = _target;
            _maxAngle = _angle;
        };
    } forEach _lockedTargets;
    
    [ACE_player, currentWeapon ACE_player, isNull GVAR(smartPistolPrimaryTarget)] call EFUNC(safemode,setWeaponSafety);
}];

// Handle firing weapon
[QGVAR(smartPistol), {_this select 0 == QGVAR(SmartPistol_Ammo)}, true, false, false, true, false, false] call EFUNC(common,registerAmmoFiredEvent);
[QGVAR(smartPistol), {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
    
    private _target = GVAR(smartPistolPrimaryTarget);
    private _vector = vectorDir _target;
    
    _projectile setPosASL (getPosASL _target vectorAdd (_vector vectorMultiply -10));
    _projectile setVelocity ((getPosASL _projectile vectorFromTo HEADPOS(_target)) vectorMultiply speed _projectile);
    
    // Wait and check if target died to remove them
    [{
        params ["_target"];
        
        if (!alive _target && {_target in GVAR(smartPistolTargets)}) then {
            GVAR(smartPistolTargets) deleteAt (GVAR(smartPistolTargets) find _target);
        };
    }, [_target], 0.5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
