#include "script_component.hpp"

["CBA_settingsInitialized", {
    [{
        params ["_projectile", "_posASL"];

        // check if a projectile is blacklisted and that it will inflict damage when it explodes to avoid
        // multiple events being sent from different clients for one explosion
        if (_projectile getVariable [QGVAR(blacklisted), false] || !(_projectile getShotInfo 5)) exitWith {};

        private _ammo = typeOf _projectile;
        if (GVAR(reflectionsEnabled)) then {
            [_posASL, _ammo] call FUNC(doReflections);
        };
        if (GVAR(enabled) && _ammo call FUNC(shouldFrag)) then {
            // only let a unit make a frag event once per second
            private _shotParents = getShotParents _projectile;
            private _instigator = _shotParents select !isNull (_shotParents#1);
            if (CBA_missionTime < (_instigator getVariable [QGVAR(nextFragEvent), -1])) exitWith { TRACE_1("skip",typeOf _instigator) };
            _instigator setVariable [QGVAR(nextFragEvent), CBA_missionTime + ACE_FRAG_FRAG_UNIT_HOLDOFF];

            // Wait a frame to make sure it doesn't target the dead
            [{
                [QGVAR(frag_eh), _this] call CBA_fnc_serverEvent
            }, [_posASL, _ammo]] call CBA_fnc_execNextFrame;
        };
    }] call EFUNC(common,addExplosionEventHandler);

    #ifndef DEBUG_MODE_DRAW
    if (GVAR(spallEnabled)) then {
    #else
    if true then {
    #endif
        ["ace_firedPlayer", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
        ["ace_firedNonPlayer", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
        ["ace_firedPlayerVehicle", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
        ["ace_firedNonPlayerVehicle", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
        [QGVAR(fragFired), LINKFUNC(fired)] call CBA_fnc_addEventHandler;
    };
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
#ifdef DEBUG_MODE_DRAW
    [QGVAR(dev_clearTraces), LINKFUNC(dev_clearTraces)] call CBA_fnc_addEventHandler;

    if (!hasInterface) exitWith {};
    GVAR(dev_drawPFEH) = [LINKFUNC(dev_drawTrace), 0] call CBA_fnc_addPerFrameHandler;
    ["ace_interact_menu_newControllableObject", {
        params ["_type"];

        private _action = [
            QGVAR(debugReset),
            "Reset ACE Frag traces",
            "",
            {[QGVAR(dev_clearTraces), []] call CBA_fnc_globalEvent;},
            {GVAR(dev_trackLines) isNotEqualTo createHashMap}
        ] call EFUNC(interact_menu,createAction);

        [_type, 1, ["ACE_SelfActions"], _action, true] call EFUNC(interact_menu,addActionToClass);
    }] call CBA_fnc_addEventHandler;
#endif
}] call CBA_fnc_addEventHandler;

#ifdef LOG_FRAG_INFO
[true, true] call FUNC(dev_debugAmmo);
#endif
