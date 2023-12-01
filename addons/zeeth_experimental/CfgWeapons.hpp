class CfgWeapons {
    class hgun_P07_F;
    class GVAR(SmartPistol_Weapon): hgun_P07_F {
        scope = 1;
        displayname = CSTRING(SmartPistol_Weapon_DisplayName);
        magazines[] = { QGVAR(12Rnd_SmartPistol_Mag) };
        magazineWell[] = { QGVAR(SmartPistol_9x21) };
        modes[] = {"Burst"};
        class Library {
            libTextDesc = CSTRING(SmartPistol_Weapon_LibDescription);
        };
        class Burst {
            aiDispersionCoefX = 1.9;
            aiDispersionCoefY = 2.4;
            aiRateOfFire = 2;
            aiRateOfFireDispersion = 1;
            aiRateOfFireDistance = 500;
            artilleryCharge = 1;
            artilleryDispersion = 1;
            autoFire = 0;
            burst = 3;
            burstRangeMax = -1;
            canShootInWater = 0;
            dispersion = 0.0029;
            displayName = "Burst";
            ffCount = 1;
            ffFrequency = 11;
            ffMagnitude = 0.5;
            flash = "gunfire";
            flashSize = 0.1;
            maxRange = 100;
            maxRangeProbab = 0.05;
            midRange = 50;
            midRangeProbab = 0.7;
            minRange = 2;
            minRangeProbab = 0.9;
            multiplier = 1;
            recoil = "recoil_pistol_light";
            recoilProne = "recoil_prone_pistol_light";
            reloadTime = 0.12;
            requiredOpticType = -1;
            showToPlayer = 1;
            sound[] = {"",10,1};
            soundBegin[] = {"sound",1};
            soundBeginWater[] = {"sound",1};
            soundBurst = 0;
            soundClosure[] = {"sound",1};
            soundContinuous = 0;
            soundEnd[] = {};
            soundLoop[] = {};
            sounds[] = {"StandardSound","SilencedSound"};
            textureType = "semi";
            useAction = 0;
            useActionTitle = "";
            weaponSoundEffect = "";
            
            class SilencedSound {
                soundSetShot[] = {"P07_silencerShot_SoundSet","P07_silencerTail_SoundSet","P07_silencerInteriorTail_SoundSet"};
            };
            class StandardSound {
                soundSetShot[] = {"P07_Shot_SoundSet","P07_Tail_SoundSet","P07_InteriorTail_SoundSet"};
            };
        };
    };
    
    class launch_B_Titan_F;
    class GVAR(Phoenix_Weapon): launch_B_Titan_F {
        scope = 2;
        canLock = 0;
        descriptionShort = CSTRING(Phoenix_Weapon_Description);
        displayname = CSTRING(Phoenix_Weapon_DisplayName);
        magazines[] = { QGVAR(1Rnd_Phoenix_Mag) };
        magazineWell[] = { QGVAR(Phoenix_Magwell) };
        modes[] = { "Single" };
        uiPicture = "\a3\weapons_f\data\ui\icon_at_ca.paa";
        class Library {
            libTextDesc = CSTRING(Phoenix_Weapon_LibDescription);
        };
    };
};
