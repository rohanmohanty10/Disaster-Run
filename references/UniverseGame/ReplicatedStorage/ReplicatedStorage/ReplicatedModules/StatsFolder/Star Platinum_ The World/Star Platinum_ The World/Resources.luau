  

 

return {
    LeaveParts = { "StandHumanoidRootPart" },
    SoundInfo = {
        LMB = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        },
        Barrage = {
            Hit = {
                Hit = {
                    SoundId = 98793285437858,
                    Volume = 2
                }
            },
            Finisher = {
                Hit = {
                    SoundId = 99392105113268,
                    Volume = 2
                }
            }
        }
    },
    Blood = {
        Name = "Output",
        Arguments = {
            "FX",
            "Shadow_Hit",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                Particle = game.ReplicatedStorage["Client Assets"].Universal.BloodVFX
            }
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
                Particle = game.ReplicatedStorage["Client Assets"].Universal.UniversalHeavyVFX,
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
                Particle = game.ReplicatedStorage["Client Assets"].Universal.Universal_HitVFX,
                Color = Color3.fromRGB(255, 255, 255)
            }
        }
    }
};