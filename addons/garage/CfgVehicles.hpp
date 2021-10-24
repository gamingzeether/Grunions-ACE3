#define GARAGE_ACTION \
class ACE_Actions { \
    class ACE_MainActions { \
        class GVAR(modifyVehicle) { \
            displayName = CSTRING(modifyActionDisplayName); \
            condition = QUOTE(_this call FUNC(canModify)); \
            statement = QUOTE(_this call FUNC(onGarageOpen)); \
        }; \
    }; \
};
    
class CfgVehicles {
    class AllVehicles;
    class LandVehicle;
    class Air;
    
    class Boat: AllVehicles {
        GARAGE_ACTION
    };
    
    class Car: LandVehicle {
        GARAGE_ACTION
    };
    
    class Helicopter: Air {
        GARAGE_ACTION
    };
    
    class Plane: Air {
        GARAGE_ACTION
    };
    
    class Tank: LandVehicle {
        GARAGE_ACTION
    };
};
