  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);

return {
    LMB1Hit = {
        Hit = {
            SoundId = 128760780879824,
            Volume = 1.5
        }
    },
    LMB2Hit = {
        Hit = {
            SoundId = 70455600688013,
            Volume = 1.5
        }
    },
    LMB3Hit = {
        Hit = {
            SoundId = 91352793677194,
            Volume = 1.5
        }
    },
    LMB4Hit = {
        Hit = {
            SoundId = 124688410738773,
            Volume = 1.5
        }
    },
    Barrage = {
        Whiff = {
            Hit = {
                SoundId = 109927020217920,
                Volume = 2
            }
        },
        Hit = {
            Hit = {
                SoundId = 95576623568812,
                Volume = 2
            }
        },
        Finisher = {
            Hit = {
                SoundId = 138384237791729,
                Volume = 2
            }
        },
        BlackFlashHitVFX = {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/RapidBlows/BlackFlash",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        }
    },
    Dismantle = {
        Hit = {
            SoundId = 70618068012358,
            Volume = 1.5
        }
    },
    ManjiKick = {
        Hit = {
            SoundId = 131332980800381,
            Volume = 1
        }
    },
    CleaveRock = {
        Hit = {
            SoundId = 103746069300270,
            Volume = 1
        }
    },
    LightHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
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
                Path = "Particles/Heavy",
                AutoSerialize = true,
                LookAt = "Attacker",
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    SerpentHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = PathShortcuts.ClientAssets.Universal.Universal_HitVFX,
                Color = Color3.fromRGB(255, 200, 75)
            }
        }
    }
};