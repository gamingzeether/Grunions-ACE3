[
    QGVAR(laserPointerRange), "SLIDER",
    ["Laser Pointer Range", "Max range of laser pointer"],
    localize ELSTRING(common,ACEKeybindCategoryWeapons),
    [50, 5000, 100, 0],
    0
] call CBA_fnc_addSetting;

[
    QGVAR(enabled), "CHECKBOX",
    LSTRING(DisplayName),
    ELSTRING(common,ACEKeybindCategoryWeapons),
    true,
    1
] call CBA_fnc_addSetting;
