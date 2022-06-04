#include "script_component.hpp"

["ace_settingsInitialized", {
    if (!hasInterface || !GVAR(enabled)) exitWith {};
    
    GVAR(cachedCasings) = createHashMap;
    GVAR(ejectDistance) = createHashMap;
    
    GVAR(casings) = [];
    for "_i" from 0 to GVAR(maxCasings) - 1 do {
        GVAR(casings) set [_i, objNull];
    };
    GVAR(currentIndex) = 0;
    
    ["CAManBase", "FiredMan", {call FUNC(createCasing)}] call CBA_fnc_addClassEventHandler;

    ["ace_settingsChanged", {
        if (count GVAR(casings) == GVAR(maxCasings)) exitWith {};
    
        // If maxCasings changed, then delete casings and resize the array
        for "_i" from (count GVAR(casings)) to GVAR(maxCasings) - 1 do {
            deleteVehicle (GVAR(casings) select _i);
        };
        GVAR(casings) resize GVAR(maxCasings);
        
        // Also adjust the index
        if (GVAR(currentIndex) >= GVAR(maxCasings)) then {
            GVAR(currentIndex) = GVAR(maxCasings);
        };
    }] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;
