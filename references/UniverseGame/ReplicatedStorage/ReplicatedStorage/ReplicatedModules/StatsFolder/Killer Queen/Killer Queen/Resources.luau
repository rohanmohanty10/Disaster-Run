  

 

local v1 = game.ReplicatedStorage["Client Assets"];

return {
    LeaveParts = { "StandHumanoidRootPart", "" },
    SoundInfo = {
        LMB = {
            Hit = {
                SoundId = 18179078077,
                Volume = 1
            }
        },
        GoBeyond = {
            Hit = {
                SoundId = 73970838516797,
                Volume = 1
            }
        },
        ExplosiveBurst = {
            Hit = {
                SoundId = 131919783283643,
                Volume = 1
            }
        },
        SoSlippery = {
            Hit = {
                SoundId = 136388007995351,
                Volume = 1
            }
        },
        SkullCaving = {
            Hit = {
                SoundId = 108058569283886,
                Volume = 1
            }
        },
        ShovelSlam = {
            Hit = {
                SoundId = 91575324757523,
                Volume = 1
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
        },
        ZeroFriction = {
            First = {
                Hit = {
                    SoundId = 86996187685908,
                    Volume = 1
                }
            },
            Second = {
                Hit = {
                    SoundId = 71726670599148,
                    Volume = 1
                }
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
    }
};