#include "script_component.hpp"

GVAR(ZOOM) = 0;
GVAR(NV) = 0;
GVAR(IRON) = false;
GVAR(TI) = 0;
GVAR(cur_cam) = 0;
GVAR(ROTATE) = 0;
GVAR(ELEVAT) = 0.01;

// Register fire event handler
// Don't run for non players, as they are too dumb to launch huntirs anyway
["ace_huntir", {!GETMVAR(GVAR(stop),true)}] call CBA_fnc_registerFeatureCamera;
[QGVAR(huntirFired), DFUNC(handleFired)] call CBA_fnc_addEventHandler;

[QGVAR(huntirFired), {
    params ["_ammo", "_ammoConfig"];
    hasInterface && (_ammo == "F_HuntIR")
}, true, false, false, false, false, false] call EFUNC(common,registerAmmoFiredEvent);

// Control camera with mouse
GVAR(mouseDown) = false;
GVAR(mousePos) = getMousePosition;
[{
    if (!GVAR(mouseDown)) exitWith {};
    
    private _mousePos = getMousePosition;
    private _diff = _mousePos vectorDiff GVAR(mousePos);
    
    _diff = [(_diff select 0) * -GVAR(sensX) * ([1, -1] select GVAR(invertX)), (_diff select 1) * GVAR(sensY) * ([1, -1] select GVAR(invertY))];
    _diff = _diff vectorMultiply (1/2^GVAR(ZOOM));
    
    _diff params ["_xDiff", "_yDiff"];
    
    GVAR(ROTATE) = GVAR(ROTATE) + _xDiff;
    if ((GVAR(ELEVAT) < 4.01 && {_yDiff > 0}) || {GVAR(ELEVAT) > 0.01 && {_yDiff < 0}}) then {
        GVAR(ELEVAT) = (0.01 max (GVAR(ELEVAT) + _yDiff)) min 4.01;
    };
    
    GVAR(mousePos) = _mousePos;
}, 0] call CBA_fnc_addPerFrameHandler;
