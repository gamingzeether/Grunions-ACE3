[
    QGVAR(enabled), "CHECKBOX",
    [LSTRING(displayName), LSTRING(description)],
    LSTRING(Settings_DisplayName),
    true,
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(maxCasings), "SLIDER",
    [LSTRING(maxCasings_displayName), LSTRING(maxCasings_description)],
    LSTRING(Settings_DisplayName),
    [50, 1000, 250, -1],
    false
] call CBA_fnc_addSetting;
