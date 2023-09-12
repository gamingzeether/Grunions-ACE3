#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0c
#define ST_TYPE           0xF0
#define ST_SINGLE         0
#define ST_MULTI          16
#define ST_TITLE_BAR      32
#define ST_PICTURE        48
#define ST_FRAME          64
#define ST_BACKGROUND     80
#define ST_GROUP_BOX      96
#define ST_GROUP_BOX2     112
#define ST_HUD_BACKGROUND 128
#define ST_TILE_PICTURE   144
#define ST_WITH_RECT      160
#define ST_LINE           176
#define FontM             "RobotoCondensed"

class RscMapControl;
class EGVAR(huntir,cam_dialog);
class GVAR(loitering_dialog): EGVAR(huntir,cam_dialog) {
    idd = 28880;
    onUnload = QUOTE(call FUNC(closeDialog));
    
    controls[] = {
        "TOP_BORDER",
        "BOTTOM_BORDER",
        "LEFT_BORDER",
        "RIGHT_BORDER",
        //"HELP_DIALOG",
        "CAM_BG",
        "MAP_BG",
        "HEIGHT_TXT",
        "MAP_CTRL"
    };
    
    class MAP_BG {
        idc = -1;
        
        style = ST_LEFT;
        type = CT_STATIC;
        
        colorBackground[] = {0.5, 0.5, 0.5, 1};
        colorText[] = {0.5, 0.5, 0.5, 1};
        font = FontM;
        sizeEx = 0.02;
        text = "";
        
        x = "SafeZoneW * 0.141146 + SafeZoneX";
        y = "SafeZoneH * 0.159259 + SafeZoneY";
        w = "SafeZoneW * 0.642188";
        h = "SafeZoneH * 0.542593";
    };
    class MAP_CTRL: RscMapControl {
        idc = 10;
        
        font = FontM;
        sizeEx = 0.02;
        
        x = "SafeZoneW * 0.141146 + SafeZoneX";
        y = "SafeZoneH * 0.159259 + SafeZoneY";
        w = "SafeZoneW * 0.642188";
        h = "SafeZoneH * 0.542593";
        
        onMouseButtonDown = QUOTE(_this call FUNC(onMouseDown));
        onMouseButtonUp = QUOTE(_this call FUNC(onMouseUp));
    };
    class HEIGHT_TXT {
        idc = 11;
        
        type = CT_STRUCTURED_TEXT;
        style = ST_LEFT;
        
        colorBackground[] = {0.1, 0.1, 0.1, 0.9};
        colorText[] = {1, 1, 1, 1};
        font = FontM;
        size = 0.025;
        text = CSTRING(height);
        
        x = "SafeZoneW * 0.076000 + SafeZoneX";
        y = "SafeZoneH * 0.166667 + SafeZoneY";
        w = "SafeZoneW * 0.059000";
        h = "SafeZoneH * 0.030000";
    };
};
