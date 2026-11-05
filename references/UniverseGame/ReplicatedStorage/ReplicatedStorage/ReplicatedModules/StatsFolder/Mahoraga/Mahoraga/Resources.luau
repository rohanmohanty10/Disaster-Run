  

 

local ClientAssets = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts).ClientAssets;

return {
    RushHit = {
        SoundId = 117036255917508,
        Volume = 2
    },
    BarrageHit = {
        SoundId = 133171788766829,
        Volume = 2
    },
    BarrageFinisher = {
        SoundId = 116047510013543,
        Volume = 2
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
                Particle = ClientAssets.Universal.Universal_HitVFX
            }
        }
    },
    BloodHit = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Blood",
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
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = ClientAssets.Universal.UniversalHeavyVFX
            }
        }
    }
};