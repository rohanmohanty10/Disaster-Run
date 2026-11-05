  

 

local v1 = game.ReplicatedStorage["Client Assets"];

return {
    LMB1 = {
        Hit = {
            SoundId = 71157995758537,
            Volume = 1
        }
    },
    LMB2 = {
        Hit = {
            SoundId = 96989976548800,
            Volume = 1
        }
    },
    DeathClaws1 = {
        Hit = {
            SoundId = 120015687747664,
            Volume = 1
        }
    },
    DeathClaws2 = {
        Hit = {
            SoundId = 78134613333223,
            Volume = 1
        }
    },
    Whisper = {
        Hit = {
            SoundId = 89721494239112,
            Volume = 1
        }
    },
    Grasp = {
        Hit = {
            SoundId = 74682311440125,
            Volume = 1
        }
    },
    Nightmare = {
        Hit = {
            SoundId = 83116122736111,
            Volume = 1
        }
    },
    Ghast = {
        Hit = {
            SoundId = 120464254057734,
            Volume = 1
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
                Color = Color3.fromRGB(255, 0, 0)
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
                Color = Color3.fromRGB(255, 0, 0)
            }
        }
    }
};