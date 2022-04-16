
#define MACRO_ATTACHTOVEHICLE \
    class ACE_Actions { \
        class ACE_MainActions { \
            class GVAR(AttachVehicle) { \
                displayName = CSTRING(AttachDetach); \
                condition = QUOTE(_this call FUNC(canAttach)); \
                insertChildren = QUOTE(_this call FUNC(getChildrenActions)); \
                exceptions[] = {"isNotSwimming"}; \
                showDisabled = 0; \
                icon = QPATHTOF(UI\attach_ca.paa); \
            }; \
            class GVAR(DetachVehicle) { \
                displayName = CSTRING(Detach); \
                condition = QUOTE(_this call FUNC(canDetach)); \
                statement = QUOTE(_this call FUNC(detach) ); \
                exceptions[] = {"isNotSwimming"}; \
                showDisabled = 0; \
                icon = QPATHTOF(UI\detach_ca.paa); \
            }; \
        }; \
    };

class CfgVehicles {
    class LandVehicle;
    class Car: LandVehicle {
        MACRO_ATTACHTOVEHICLE
    };

    class Tank: LandVehicle {
        MACRO_ATTACHTOVEHICLE
    };

    class Air;
    class Helicopter: Air {
        MACRO_ATTACHTOVEHICLE
    };

    class Plane: Air {
        MACRO_ATTACHTOVEHICLE
    };

    class Ship;
    class Ship_F: Ship {
        MACRO_ATTACHTOVEHICLE
    };

    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(Attach) {
                    displayName = CSTRING(AttachDetach);
                    condition = QUOTE(_this call FUNC(canAttach));
                    insertChildren = QUOTE(_this call FUNC(getChildrenActions));
                    exceptions[] = {"isNotDragging", "isNotSwimming"};
                    showDisabled = 0;
                    icon = QPATHTOF(UI\attach_ca.paa);
                };
                class GVAR(Detach) {
                    displayName = CSTRING(Detach);
                    condition = QUOTE(_this call FUNC(canDetach));
                    statement = QUOTE(_this call FUNC(detach));
                    exceptions[] = {"isNotDragging", "isNotSwimming"};
                    showDisabled = 0;
                    icon = QPATHTOF(UI\detach_ca.paa);
                };
            };
        };
        MACRO_ATTACHTOVEHICLE
    };

    class All;

    class NVG_TargetBase: All {
        class NVGMarker {
            maxLifetime = "8 * 60 * 60";
        };
    };
};
