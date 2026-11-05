  

 

local v1 = game.ReplicatedStorage["Client Assets"];

return {
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    SoundInfo = {},
    SOffLMBHit = {
        SoundId = 110520137346209,
        Volume = 2
    },
    SOffLMBFinisher = {
        SoundId = 124664276254407,
        Volume = 2
    },
    BarrageHitSound = {
        SoundId = 123480372676874,
        Volume = 2
    },
    BarrageFinisherSound = {
        SoundId = 119910454405726,
        Volume = 2
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
    RippleHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/RippleQTE/Hit",
                AutoSerialize = true
            } }
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
        Arguments = {
            "FX",
            "Shadow_Hit",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                Particle = v1.Universal.BloodVFX
            }
        }
    }
};