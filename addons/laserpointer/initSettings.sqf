[
    QGVAR(laserPointerRange),
    "SLIDER",
    ["Laser Pointer Range", "Max range of laser pointer"],
    "ACE Laser Pointer",
    [50, 5000, 100, 0],
    0
] call CBA_fnc_addSetting;

[
    QGVAR(enabled),
    "CHECKBOX",
    LSTRING(DisplayName),
    "ACE Laser Pointer",
    true
] call CBA_fnc_addSetting;