  

 

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
    InstantStrikeHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/InstantStrike/Hit",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    ViceGripThrow = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/ViceGrip/Throw",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    RushAttack1SFX = {
        SoundId = 15587941306,
        Volume = 2
    },
    RushAttack2SFX = {
        SoundId = 15587941506,
        Volume = 2
    },
    RushAttack3SFX = {
        SoundId = 15587941880,
        Volume = 2
    },
    RushAttack4SFX = {
        SoundId = 15587941681,
        Volume = 2
    },
    FlashComboSFX1 = {
        SoundId = 15587937442,
        Volume = 2
    },
    FlashComboSFX2 = {
        SoundId = 15587938529,
        Volume = 2
    },
    FlashComboSFX3 = {
        SoundId = 15587939119,
        Volume = 2
    },
    FlashComboSFX4 = {
        SoundId = 15587937866,
        Volume = 2
    },
    TwofoldKickSFX1 = {
        SoundId = 15105162640,
        Volume = 2
    },
    TwofoldKickSFX2 = {
        SoundId = 15105162176,
        Volume = 2
    },
    GleamingStrikeHit = {
        SoundId = 15105162952,
        Volume = 2
    },
    LapseCollapseSFX = {
        SoundId = 15105163197,
        Volume = 2
    },
    ReversalPushSFX = {
        SoundId = 15105162561,
        Volume = 2
    },
    BlackFlash = {
        SoundId = 100082263294237,
        Volume = 2
    },
    ReversalForceSFX = {
        SoundId = 15105162828,
        Volume = 2
    }
};