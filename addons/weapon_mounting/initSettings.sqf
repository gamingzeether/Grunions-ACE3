private _category = format ["ACE %1", LLSTRING(displayName)];

[
    QGVAR(maxTypes), "SLIDER",
    [LSTRING(maxTypes_displayName), LSTRING(maxTypes_description)],
    _category,
    [1, 10, 1, 0],
    1
] call CBA_settings_fnc_init;

[
    QGVAR(maxOfType), "SLIDER",
    [LSTRING(maxOfType_displayName), LSTRING(maxOfType_description)],
    _category,
    [1, 10, 2, 0],
    1
] call CBA_settings_fnc_init;
