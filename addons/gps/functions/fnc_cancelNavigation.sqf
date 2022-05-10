#include "script_component.hpp"
/*
 * Author: GamingZeether
 * Cancels active navigation
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_gps_fnc_cancelNavigation
 * 
 * Public: Yes
 */

GVAR(activeNavMarkers) = [];
GVAR(turns) = [];
GVAR(findingPath) = false;
GVAR(isNavigating) = false;
GVAR(nextMarkerIndex) = -1;
GVAR(nextTurnIndex) = -1;
["StatusNoPath", 3, "Status"] call FUNC(sayVoiceLine);
