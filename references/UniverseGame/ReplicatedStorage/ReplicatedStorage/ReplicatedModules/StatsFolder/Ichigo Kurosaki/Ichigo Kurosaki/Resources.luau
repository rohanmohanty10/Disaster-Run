  

 

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
    Hit = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit",
                LookAt = "Attacker"
            } }
    },
    BladeCombo1 = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/BladeCombo/BloodRight",
                LookAt = "Attacker"
            } }
    },
    BladeCombo2 = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/BladeCombo/BloodLeft",
                LookAt = "Attacker"
            } }
    },
    BladeCombo3 = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/BladeCombo/BloodUp",
                LookAt = "Attacker"
            } }
    },
    ParticleInfo = {
        Hit = {
            Name = "Output",
            Arguments = { "FX", "Shadow_Hit", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Hit",
                    LookAt = "Attacker"
                } }
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