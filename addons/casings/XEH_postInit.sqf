#include "script_component.hpp"

if (!hasInterface) exitWith {};

["CBA_settingsInitialized", {
    if (!GVAR(enabled)) exitWith {};
    
    GVAR(cachedCasings) = createHashMap;
    GVAR(ejectDistance) = createHashMap;
    
    GVAR(casings) = [];
    for "_i" from 0 to GVAR(maxCasings) - 1 do {
        GVAR(casings) set [_i, objNull];
    };
    GVAR(currentIndex) = 0;
    
    ["CAManBase", "FiredMan", LINKFUNC(createCasing)] call CBA_fnc_addClassEventHandler;

    ["CBA_SettingChanged", {
        // If maxCasings changed, then delete casings and resize the array
        for "_i" from (GVAR(maxCasings) - 1) to (count GVAR(casings) - 1) do {
            deleteVehicle (GVAR(casings) select _i);
        };
        GVAR(casings) resize GVAR(maxCasings);
        
        // Also adjust the index
        if (GVAR(currentIndex) >= GVAR(maxCasings)) then {
            GVAR(currentIndex) = GVAR(maxCasings);
        };
    }] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;
