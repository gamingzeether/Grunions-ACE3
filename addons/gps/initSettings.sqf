[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled_DisplayName), LSTRING(Enabled_Description)],
    LSTRING(Category),
    true
] call CBA_fnc_addSetting;

[
    QGVAR(waypointAlpha),
    "SLIDER",
    [LSTRING(WaypointAlpha_DisplayName), LSTRING(WaypointAlpha_Description)],
    LSTRING(Category),
    [0, 1, 0.4, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(turnAlpha),
    "SLIDER",
    [LSTRING(TurnAlpha_DisplayName), LSTRING(TurnAlpha_Description)],
    LSTRING(Category),
    [0, 1, 0.4, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(waypointCount),
    "SLIDER",
    [LSTRING(WaypointCount_DisplayName), LSTRING(WaypointCount_Description)],
    LSTRING(Category),
    [0, 100, 10, 0]
] call CBA_fnc_addSetting;
