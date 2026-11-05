  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);

return {
    SoundInfo = {
        LMB = {
            Hit = {
                SoundId = 18179078077,
                Volume = 1
            }
        },
        SilhouetteSlashes = {
            Hit = {
                SoundId = 18179079700,
                Volume = 1
            }
        },
        UmbralCharge = {
            Hit = {
                SoundId = 18359777597,
                Volume = 1
            }
        },
        BirdcageOfDarkness = {
            Hit = {
                SoundId = 18311049605,
                Volume = 1
            }
        },
        ImminentBlink = {
            Hit = {
                SoundId = 18179072416,
                Volume = 1
            }
        },
        AtomicSword = {
            Hit = {
                SoundId = 18179074531,
                Volume = 1
            }
        }
    },
    ParticleInfo = {
        Hit = {
            Name = "Output",
            Arguments = {
                "FX",
                "Shadow_Hit",
                {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    LookAt = "Attacker",
                    Particle = PathShortcuts.ClientAssets.Universal.BloodVFX
                }
            }
        },
        Slime = {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/EidolonTears/Hit",
                    LookAt = "Target"
                } }
        },
        Impale = {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/BloodBlowStab",
                    LookAt = "Target"
                } }
        },
        Heal = {
            Name = "Output",
            Arguments = { "FX", "Shadow_Hit", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Heal",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        }
    }
};