  

 

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
    FiendishFinisher = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/FiendishRush/Finisher",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    CleaveContact = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Cleave/Contact",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    CleaveHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Cleave/Slash",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    CleaveFinisher = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Cleave/Finisher",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    ShrineHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Dismantle/HitOnce",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    RushAttack1SFX = {
        SoundId = 17503296456,
        Volume = 2
    },
    RushAttack2SFX = {
        SoundId = 17503294721,
        Volume = 2
    },
    RushAttack3SFX = {
        SoundId = 17503294936,
        Volume = 2
    },
    RushAttack4SFX = {
        SoundId = 17503295184,
        Volume = 2
    },
    FiendishRushSFX = {
        SoundId = 17503296753,
        Volume = 2
    },
    AxeKickSFX = {
        SoundId = 17503293527,
        Volume = 2
    },
    AxeKickAerialSFX = {
        SoundId = 17503292076,
        Volume = 2
    },
    DismantleHit = {
        SoundId = 17503292493,
        Volume = 2
    },
    DismantleAerialHit = {
        SoundId = 17503290191,
        Volume = 2
    },
    SkullCrasherHit = {
        SoundId = 17503300547,
        Volume = 2
    },
    ShrineHitSFX = {
        SoundId = 17503294936,
        Volume = 1.25
    },
    BlackFlash = {
        SoundId = 100082263294237,
        Volume = 2
    },
    ShrineTechniqueHit = {
        SoundId = 121268437845434,
        Volume = 2
    }
};