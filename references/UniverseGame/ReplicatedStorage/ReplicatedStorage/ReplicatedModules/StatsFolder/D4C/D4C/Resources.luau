  

 

local v1 = game.ReplicatedStorage["Client Assets"];

return {
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    StandLMB1 = {
        Hit = {
            SoundId = 82751651214077,
            Volume = 2
        }
    },
    BloodLMB = {
        Hit = {
            SoundId = 105991262222010,
            Volume = 2
        }
    },
    StandLMB2 = {
        Hit = {
            SoundId = 108841004473701,
            Volume = 2
        }
    },
    BarrageHit = {
        Hit = {
            SoundId = 110385603725185,
            Volume = 2
        }
    },
    BarrageEnd = {
        Hit = {
            SoundId = 126436356701752,
            Volume = 2
        }
    },
    Storm1 = {
        Hit = {
            SoundId = 72253066957608,
            Volume = 2
        }
    },
    Storm2 = {
        Hit = {
            SoundId = 134923352135073,
            Volume = 2
        }
    },
    Storm3 = {
        Hit = {
            SoundId = 125169257879150,
            Volume = 2
        }
    },
    Fanfire = {
        Hit = {
            SoundId = 129997161204009,
            Volume = 2
        }
    },
    Precision = {
        Hit = {
            SoundId = 98231040127984,
            Volume = 2
        }
    },
    Chop = {
        Hit = {
            SoundId = 88340484595720,
            Volume = 2
        }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = v1.Universal.UniversalHeavyVFX,
                Offset = CFrame.Angles(0, 3.141592653589793, 0),
                Color = Color3.fromRGB(255, 255, 255)
            }
        }
    },
    LightHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = v1.Universal.Universal_HitVFX,
                Color = Color3.fromRGB(255, 255, 255)
            }
        }
    },
    Blood = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit",
                LookAt = "Attacker"
            } }
    }
};