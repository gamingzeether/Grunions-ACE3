#include "script_component.hpp"

if (isServer) then {
    GVAR(lastFragTime) = -1;
    [QGVAR(frag_eh), {_this call FUNC(frago);}] call CBA_fnc_addEventHandler;
};

["CBA_settingsInitialized", {
    if (!GVAR(enabled)) exitWith {};

    // Register fire event handler
    ["ace_firedPlayer", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
    ["ace_firedNonPlayer", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
    ["ace_firedPlayerVehicle", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
    ["ace_firedNonPlayerVehicle", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
    [QGVAR(fragFired), DFUNC(fired)] call CBA_fnc_addEventHandler;
    [QGVAR(fragFired), {
        params ["_ammo", "_ammoConfig"];

        private _shouldTrack = false;
        if (GVAR(SpallEnabled)) then {
            private _caliber = getNumber(configFile >> "CfgAmmo" >> _roundType >> "caliber");
            private _explosive = getNumber(configFile >> "CfgAmmo" >> _roundType >> "explosive");
            private _idh = getNumber(configFile >> "CfgAmmo" >> _roundType >> "indirectHitRange");
            _shouldTrack = (_caliber >= 2.5) || {(_explosive > 0 && {_idh >= 1})};
        };
        if (_shouldTrack) exitWith {true};

        // Read configs and test if it would actually cause a frag, using same logic as FUNC(pfhRound)
        private _skip = getNumber (_ammoConfig >> QGVAR(skip));
        private _explosive = getNumber (_ammoConfig >> "explosive");
        private _indirectRange = getNumber (_ammoConfig >> "indirectHitRange");
        private _force = getNumber (_ammoConfig >> QGVAR(force));
        private _fragPower = getNumber(_ammoConfig >> "indirecthit")*(sqrt((getNumber (_ammoConfig >> "indirectHitRange"))));
        (_skip == 0) && {(_force == 1) || {_explosive > 0.5 && {_indirectRange >= 4.5} && {_fragPower >= 35}}}

    }, true, true, true, true, true, true] call EFUNC(common,registerAmmoFiredEvent);

    [FUNC(masterPFH), 0, []] call CBA_fnc_addPerFrameHandler;

    addMissionEventHandler ["EachFrame", {call FUNC(masterPFH)}];
}] call CBA_fnc_addEventHandler;

// Cache for ammo type configs
GVAR(cacheRoundsTypesToTrack) = [false] call CBA_fnc_createNamespace;


// Debug stuff:

#ifdef DRAW_FRAG_INFO
[] call FUNC(dev_startTracing);
#endif

#ifdef DEBUG_MODE_FULL
[true, true, 30] call FUNC(dev_debugAmmo);
#endif
