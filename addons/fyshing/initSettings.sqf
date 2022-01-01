private _category = format ["ACE %1", localize LSTRING(component_DisplayName)];

[
    QGVAR(enableStress), "CHECKBOX",
    LLSTRING(enableStress_DisplayName),
    _category,
    false
] call CBA_fnc_addSetting;
