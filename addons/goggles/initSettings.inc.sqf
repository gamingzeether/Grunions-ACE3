[
    QGVAR(effects), "LIST",
    LSTRING(effects_displayName),
    localize LSTRING(SettingsName),
    [[0, 1, 2, 3], [ELSTRING(common,Disabled), LSTRING(effects_tintOnly), LSTRING(enabled_tintAndEffects), LSTRING(effects_effectsOnly)], 3],
    0,
    {[QGVAR(effects), _this] call EFUNC(common,cbaSettings_settingChanged)},
    true // Needs mission restart
] call CBA_fnc_addSetting;

[
    QGVAR(showInThirdPerson), "CHECKBOX",
    LSTRING(ShowInThirdPerson),
    localize LSTRING(SettingsName),
    false,
    0
] call CBA_fnc_addSetting;

[
    QGVAR(showClearGlasses), "CHECKBOX",
    [LSTRING(SettingShowClearGlasses), LELSTRING(common,showActionInSelfInteraction)],
    localize LSTRING(SettingsName),
    false, // default value
    0 // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(drawOverlay), "CHECKBOX",
    LSTRING(SettingDrawOverlay),
    localize LSTRING(SettingsName),
    true,
    0
] call CBA_fnc_addSetting;
