[
    QGVAR(invertX), "CHECKBOX",
    [LSTRING(invertX_displayName), LSTRING(invertX_description)],
    LSTRING(displayName),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(sensX), "SLIDER",
    [LSTRING(sensitivityX_displayName), LSTRING(sensitivityX_description)],
    LSTRING(displayName),
    [0, 100, 70, 1, false]
] call CBA_fnc_addSetting;

[
    QGVAR(invertY), "CHECKBOX",
    [LSTRING(invertY_displayName), LSTRING(invertY_description)],
    LSTRING(displayName),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(sensY), "SLIDER",
    [LSTRING(sensitivityY_displayName), LSTRING(sensitivityY_description)],
    LSTRING(displayName),
    [0, 100, 3, 1, false]
] call CBA_fnc_addSetting;
