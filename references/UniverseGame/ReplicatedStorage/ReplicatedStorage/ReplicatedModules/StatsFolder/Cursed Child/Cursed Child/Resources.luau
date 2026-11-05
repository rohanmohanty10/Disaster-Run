  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets;

return {
    LightHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit/Light",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit/Heavy",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    BloodHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit/Blood",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    SFX_Katana_LMB_1 = {
        SoundId = 15665753956,
        Volume = 2
    },
    SFX_Katana_LMB_2 = {
        SoundId = 15665754470,
        Volume = 2
    },
    SFX_Katana_LMB_3 = {
        SoundId = 15665761601,
        Volume = 2
    },
    SFX_Katana_LMB_4 = {
        SoundId = 15665753308,
        Volume = 2
    },
    SFX_SteelArm_LMB_1 = {
        SoundId = 15665760078,
        Volume = 2
    },
    SFX_SteelArm_LMB_2 = {
        SoundId = 15665759862,
        Volume = 2
    },
    SFX_SteelArm_LMB_3 = {
        SoundId = 15665759570,
        Volume = 2
    },
    SFX_SteelArm_LMB_4 = {
        SoundId = 15665759370,
        Volume = 2
    },
    SFX_BladeworkRush_1 = {
        SoundId = 15665776003,
        Volume = 2
    },
    SFX_BladeworkRush_2 = {
        SoundId = 15665757904,
        Volume = 2
    },
    SFX_BladeworkRush_3 = {
        SoundId = 15665775532,
        Volume = 2
    },
    SFX_FeintSlash_1 = {
        SoundId = 15665786806,
        Volume = 2
    },
    SFX_FeintSlash_2 = {
        SoundId = 15665787081,
        Volume = 2
    },
    SFX_CursedSpeech = {
        SoundId = 15668934923,
        Volume = 2
    },
    SFX_Batter_1 = {
        SoundId = 15665760760,
        Volume = 2
    },
    SFX_Batter_2 = {
        SoundId = 15665760615,
        Volume = 2
    },
    SFX_ThinIceBreaker = {
        SoundId = 15665750055,
        Volume = 2
    },
    SFX_Cleave_1 = {
        SoundId = 15665754674,
        Volume = 2
    },
    SFX_Cleave_2 = {
        SoundId = 15665754855,
        Volume = 2
    },
    SFX_Strike = {
        SoundId = 15665755701,
        Volume = 2
    },
    SFX_Rampage_1 = {
        SoundId = 15665756939,
        Volume = 2
    },
    SFX_Rampage_2 = {
        SoundId = 15665756663,
        Volume = 2
    }
};