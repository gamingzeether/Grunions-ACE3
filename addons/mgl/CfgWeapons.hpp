class Mode_SemiAuto;
class CfgWeapons {
    class Launcher;
    class Launcher_Base_F: Launcher {
        class Library;
        class WeaponSlotsInfo;
    };
    class ACE_MGL: Launcher_Base_F {
        EGVAR(overpressure,range) = 0;
        EGVAR(overpressure,damage) = 0;
        
        displayName = CSTRING(MGL_displayName);
        descriptionShort = CSTRING(MGL_description);
        drySound[] = {"A3\Sounds_F\arsenal\weapons\UGL\Dry_ugl", 0.562341, 1, 10};
        handAnim[] = {"OFP2_ManSkeleton", "\A3\Weapons_F_Exp\Launchers\RPG7\Data\Anim\RPG7V.rtm"};
        model = "\A3\Weapons_F_Exp\Launchers\RPG7\rpg7_F.p3d";
        magazines[] = {"ACE_6Rnd_40mm_HE", "ACE_6Rnd_40mm_Pike"};
        magazineWell[] = {"ACE_MGL_6Rnd_40x36"};
        modes[] = {"Single"};
        modelOptics = "-";
        muzzleEnd = "konec hlavne";
        muzzlePos = "usti hlavne";
        picture = "\A3\Weapons_F_Exp\Launchers\RPG7\Data\UI\icon_launch_RPG7_F_X_CA.paa";
        recoil = "recoil_default";
        reloadAction = "GestureReloadRPG7";
        reloadMagazineSound[] = {"A3\Sounds_F\arsenal\weapons\Rifles\Mk20\MK20_UGL_reload",0.794328,1,10};
        scope = 2;
        UiPicture = "\A3\Weapons_F\data\UI\icon_gl_CA.paa";
        weaponInfoType = "RscWeaponZeroing";
        
        class Single: Mode_SemiAuto {
            sounds[] = {"StandardSound"};
            reloadTime = 1;
            class BaseSoundModeType {
                closure1[] = {"A3\Sounds_F\arsenal\weapons\UGL\Closure_UGL", 1, 1, 10};
                soundClosure[] = {"closure1", 1};
            };
            class StandardSound: BaseSoundModeType {
                begin1[] = {"A3\Sounds_F\arsenal\weapons\UGL\UGL_01", 0.707946, 1, 200};
                begin2[] = {"A3\Sounds_F\arsenal\weapons\UGL\UGL_02", 0.707946, 1, 200};
                closure1[] = {"A3\Sounds_F\arsenal\weapons\UGL\Closure_UGL", 1, 1, 10};
                soundBegin[] = {"begin1",0.5,"begin2",0.5};
                soundClosure[] = {"closure1", 1};
                soundSetShot[] = {"UGL_shot_SoundSet", "UGL_Tail_SoundSet", "UGL_InteriorTail_SoundSet"};
            };
        };
        class OpticsModes {
            class irons {
                cameraDir = "look";
                discreteDistance[] = {200,300,400,500};
                discreteDistanceCameraPoint[] = {"eye_200","eye_300","eye_400","eye_500"};
                discreteDistanceInitIndex = 0;
                distanceZoomMax = 500;
                distanceZoomMin = 200;
                opticsDisablePeripherialVision = 0;
                opticsFlare = 0;
                opticsID = 1;
                opticsPPEffects[] = {};
                opticsZoomInit = 0.75;
                opticsZoomMax = 1.25;
                opticsZoomMin = 0.375;
                useModelOptics = 0;
                visionMode[] = {};
            };
        };
        class Library: Library {
            libTextDesc = "";
        };
        class WeaponSlotsInfo: WeaponSlotsInfo {
            mass = 100;
        };
    };
};
