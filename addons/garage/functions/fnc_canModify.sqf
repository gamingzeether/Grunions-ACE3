#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Checks if the vehicle can be modified
 *
 * Arguments:
 * 0: Target vehicle <OBJECT>
 * 1: Unit doing modification <OBJECT>
 *
 * Return Value:
 * Can modify vehicle <BOOL>
 *
 * Example:
 * [typeOf cursorObject] call ace_garage_fnc_canModify
 *
 * Public: No
 */

params ["_vehicle", "_unit"];

//copied from ace_repair_fnc_can_repair
private _return = true;
private _fullRepairLocations = getArray (configfile >> "ACE_Repair" >> "Actions" >> "FullRepair" >> "repairLocations");
if (!("All" in _fullRepairLocations)) then {
    private _repairFacility = {([_unit] call EFUNC(repair,isInRepairFacility)) || ([_vehicle] call EFUNC(repair,isInRepairFacility))};
    private _repairVeh = {([_unit] call EFUNC(repair,isNearRepairVehicle)) || ([_vehicle] call EFUNC(repair,isNearRepairVehicle))};
    {
        if (_x == "field") exitWith {_return = true;};
        if (_x == "RepairFacility" && _repairFacility) exitWith {_return = true;};
        if (_x == "RepairVehicle" && _repairVeh) exitWith {_return = true;};
        if (!isNil _x) exitWith {
            private _val = missionNamespace getVariable _x;
            if (_val isEqualType 0) then {
                _return = switch (_val) do {
                    case 0: {true}; //useAnywhere
                    case 1: {call _repairVeh}; //repairVehicleOnly
                    case 2: {call _repairFacility}; //repairFacilityOnly
                    case 3: {(call _repairFacility) || {call _repairVeh}}; //vehicleAndFacility
                    default {false}; //Disabled
                };
            };
        };
    } forEach _fullRepairLocations;
};

_return && {alive _vehicle};
