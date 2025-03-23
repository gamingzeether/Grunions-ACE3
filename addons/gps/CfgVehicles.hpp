class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class ADDON {
                    displayName = CSTRING(Menu);
                    condition = QUOTE(call FUNC(canUseGPS));
                    statement = QUOTE(createDialog QQGVAR(gps_dialog));
                    exceptions[] = {"isNotInside"};
                    icon = "\A3\Weapons_F\Data\UI\gear_item_gps_CA.paa";
                    class Cancel {
                        displayName = CSTRING(Cancel);
                        condition = QUOTE(GVAR(isNavigating));
                        statement = QUOTE(call FUNC(cancelNavigation));
                        exceptions[] = {"isNotInside"};
                    };
                };
            };
        };
    };
};
