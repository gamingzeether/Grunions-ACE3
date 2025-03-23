class RscControlsGroup;
class RscProgress;
class RscTitles {
    class GVAR(overlay) {
        idd = -1;
        fadeIn = 0.1;
        fadeOut = 0.1;
        duration = "10e10";
        onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(overlay),_this select 0)]);
        onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(overlay),nil)]);
        class controls {
            class SmartPistol: RscControlsGroup {
                idc = 0;
                x = 0;
                y = 0;
                w = "safezoneW";
                h = "safezoneH";
                
                class Controls {
                };
            };
            class Jetpack: RscControlsGroup {
                idc = 1;
                x = 0;
                y = 0;
                w = "safezoneW";
                h = "safezoneH";
                
                class Controls {
                    class Fuel: RscProgress {
                        idc = 0;
                        
                        x = "0.550 * safezoneW + safezoneX";
                        y = "0.400 * safezoneH + safezoneY";
                        w = "0.020 * safezoneW";
                        h = "0.200 * safezoneH";
                        style = 1;
                        colorBar[] = {JETPACK_READYCOLOR};
                        colorBackground[] = {0, 0, 0, 0.4};
                        colorFrame[] = {0, 0, 0, 0.4};
                    };
                };
            };
        };
    };
};
