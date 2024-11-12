#include "\z\ace\addons\common\define.hpp"
#include "defines.hpp"

class RscButtonArsenal;
class RscText;
class GVAR(display) {
    idd = IDD_ACE_GARAGE;
    enableSimulation = 1;
    //onLoad = QUOTE(_this call FUNC(onGarageOpen)); //called from action
    onUnload = QUOTE(_this call FUNC(onGarageClose));
    class controls {
        class componentTabButton: RscButtonArsenal {
            idc = IDC_ACE_TABCOMPONENTS;
            text = "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\AnimationSources_ca.paa";
            onMouseButtonClick = QUOTE(_this call FUNC(onTabButtonClicked));
            
            x = QUOTE(77.00 * GUI_GRID_W + GUI_GRID_X);
            y = QUOTE(-15.0 * GUI_GRID_H + GUI_GRID_Y);
            w = QUOTE(2.000 * GUI_GRID_W);
            h = QUOTE(2.000 * GUI_GRID_H);
        };
        class camosTabButton: RscButtonArsenal {
            idc = IDC_ACE_TABCAMO;
            text = "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\TextureSources_ca.paa";
            onMouseButtonClick = QUOTE(_this call FUNC(onTabButtonClicked));
            
            x = QUOTE(77.00 * GUI_GRID_W + GUI_GRID_X);
            y = QUOTE(-12.0 * GUI_GRID_H + GUI_GRID_Y);
            w = QUOTE(2.000 * GUI_GRID_W);
            h = QUOTE(2.000 * GUI_GRID_H);
        };
        class blockBackground: RscText {
            idc = IDC_ACE_BACKGROUND;
            
            x = QUOTE(62.00 * GUI_GRID_W + GUI_GRID_X);
            y = QUOTE(-15.0 * GUI_GRID_H + GUI_GRID_Y);
            w = QUOTE(14.00 * GUI_GRID_W);
            h = QUOTE(20.00 * GUI_GRID_H);
        };
        class optionsList: RscListBox {
            idc = IDC_ACE_LISTBOX;
            onLBSelChanged = QUOTE(_this call FUNC(onListClicked));
            
            x = QUOTE(62.00 * GUI_GRID_W + GUI_GRID_X);
            y = QUOTE(-15.0 * GUI_GRID_H + GUI_GRID_Y);
            w = QUOTE(14.00 * GUI_GRID_W);
            h = QUOTE(20.00 * GUI_GRID_H);
        };
    };
};
