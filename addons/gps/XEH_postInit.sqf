#include "script_component.hpp"

["CBA_settingsInitialized", {
    if (GVAR(enabled) && {hasInterface}) then {
        // Navigation variables
        GVAR(activeNavMarkers) = [];
        GVAR(turns) = [];
        GVAR(findingPath) = false;
        GVAR(isNavigating) = false;
        GVAR(nextMarkerIndex) = -1;
        GVAR(nextTurnIndex) = -1;
        GVAR(nextTurnDistanceSaid) = "";
        GVAR(nextTurnDirectionSaid) = false;
        GVAR(voiceLineQueue) = [];
        GVAR(speakerHelperActive) = false;
        
        // Initalize agent
        GVAR(pathingAgent) = createAgent ["B_Soldier_F", [0,0,0], [], 0, "CAN_COLLIDE"];
        [GVAR(pathingAgent), QUOTE(ADDON)] call EFUNC(common,hideUnit);
        GVAR(pathingAgent) addEventHandler ["PathCalculated", {
            params ["_agent", "_path"];
            if (!GVAR(findingPath)) exitWith {};
            GVAR(findingPath) = false;
            GVAR(activeNavMarkers) = _path;
            call FUNC(startNavigation);
            
            // Reset agent
            if (vehicle _agent != _agent) then {
                deleteVehicle vehicle _agent;
            };
            _agent setPosASL [0, 0, 0];
        }];
        
        // Scheduler to update trip progress
        [{
            if (GVAR(isNavigating)) then {
                call FUNC(navigationCode);
            };
        }, 0.2] call CBA_fnc_addPerFrameHandler;
        
        // Draw markers
        addMissionEventHandler ["Draw3D", {
            if (GVAR(isNavigating)) then {
                call FUNC(drawMarkers);
            };
        }];
        
        // Cancel navigation if player exits vehicle
        ACE_player addEventHandler ["GetOutMan", {
            params ["_unit", "_role", "_vehicle", "_turret"];
            if (GVAR(isNavigating)) then {
                call FUNC(cancelNavigation);
            };
        }];
    };
}] call CBA_fnc_addEventHandler;