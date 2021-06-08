[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(enabled_displayName), LSTRING(enabled_description)],
    LSTRING(Category),
    true
] call CBA_fnc_addSetting;

[
    QGVAR(maxCasings),
    "SLIDER",
    [LSTRING(maxCasings_displayName), LSTRING(maxCasings_description)],
    LSTRING(Category),
    [50, 1000, 200, 0]
] call CBA_fnc_addSetting;