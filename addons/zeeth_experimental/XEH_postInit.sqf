#include "script_component.hpp"

if (!hasInterface) exitWith {};

(QGVAR(overlay) call BIS_fnc_rscLayer) cutRsc [QGVAR(overlay), "PLAIN"];

private _fuelBar = (uiNamespace getVariable [QGVAR(overlay), displayNull]) displayCtrl 1 controlsGroupCtrl 0;
_fuelBar ctrlShow false;
//call FUNC(initJetpack);
call FUNC(initPhoenix);
call FUNC(initSmartPistol);

// Roll for a heart attack every 2 minutes
[{
    if (random 10000 < 1) then { // Approx 0.01% chance to die every 5 minutes
        player setDamage 1;
        [] spawn
        {
            ["You died of a heart attack.", "", "OK", "OK", [] call BIS_fnc_displayMission, false, false] call BIS_fnc_guiMessage;
        };
    };
},
300
] call CBA_fnc_addPerFrameHandler;
