  

 

local Yone = game.ReplicatedStorage["Client Assets"].Yone;

return {
    YoneUltStart = {
        ParticleInfo = {
            Long = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Long3 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Shockwave3 = {
                State = "Emit",
                Emit = 15
            },
            Stars3 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Long2 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Shockwave5 = {
                State = "Emit",
                Emit = 15
            },
            Stars4 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Stars2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Shockwave2 = {
                State = "Emit",
                Emit = 15
            },
            Shockwave4 = {
                State = "Emit",
                Emit = 15
            },
            Shockwave6 = {
                State = "Emit",
                Emit = 15
            },
            Shockwave = {
                State = "Emit",
                Emit = 2
            },
            Smoke = {
                State = "Emit",
                Emit = 15
            },
            Rocks = {
                State = "Emit",
                Emit = 125
            }
        }
    },
    YoneUltEnd = {
        ParticleInfo = {
            Long2 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Shockwave2 = {
                State = "Emit",
                Emit = 15
            },
            Stars2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Long = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Shockwave3 = {
                State = "Emit",
                Emit = 15
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Shockwave5 = {
                State = "Emit",
                Emit = 15
            },
            Shockwave4 = {
                State = "Emit",
                Emit = 15
            },
            Shockwave = {
                State = "Emit",
                Emit = 2
            },
            Smoke = {
                State = "Emit",
                Emit = 15
            },
            Rocks = {
                State = "Emit",
                Emit = 125
            }
        }
    },
    YonePierce = {
        Object = Yone.Particles["Yone Pierce"],
        ParticleInfo = {
            flash = {
                State = "Emit",
                Emit = 10
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Long2 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Long3 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Stars2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            Shockwave = {
                State = "Emit",
                Emit = 15
            },
            Shockwave2 = {
                State = "Emit",
                Emit = 15
            },
            Stars3 = {
                State = "Emit",
                Emit = 1
            },
            Long = {
                State = "Emit",
                Emit = 5,
                Delay = 0.02
            },
            Shockwave3 = {
                State = "Emit",
                Emit = 15
            },
            Long4 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Smoke = {
                State = "Emit",
                Emit = 15
            },
            Rocks = {
                State = "Emit",
                Emit = 65
            },
            Specs = {
                State = "Emit",
                Emit = 25,
                Delay = 0.05
            },
            Specs2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.05
            }
        }
    },
    ["Yone-LMB-1"] = {
        Object = Yone.Particles.LMBHIT1,
        ParticleInfo = {
            ["Gun shot"] = {
                State = "Emit",
                Emit = 5
            },
            Long = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 2,
                Delay = 0.05
            },
            flash = {
                State = "Emit",
                Emit = 2
            },
            Specs = {
                State = "Emit",
                Emit = 15,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            ["star up"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            }
        }
    },
    ["Yone-LMB-2"] = {
        Object = Yone.Particles["LMB HIT2"],
        ParticleInfo = {
            ["Gun shot"] = {
                State = "Emit",
                Emit = 5
            },
            Long2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            Specs = {
                State = "Emit",
                Emit = 15,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            flash = {
                State = "Emit",
                Emit = 2
            },
            ["star up"] = {
                State = "Emit",
                Emit = 2,
                Delay = 0.05
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Long = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            }
        }
    },
    ["Yone-LMB-3"] = {
        Object = Yone.Particles["LMB3 HIT3"],
        ParticleInfo = {
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs3 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.05
            },
            Specs4 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.05
            },
            ["star up"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs = {
                State = "Emit",
                Emit = 25,
                Delay = 0.05
            },
            Specs2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.05
            },
            flash = {
                State = "Emit",
                Emit = 10
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            ["Gun shot"] = {
                State = "Emit",
                Emit = 5
            },
            Long = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            ["star up3"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            }
        }
    },
    ["Yone-Left"] = {
        Object = Yone.Particles.YoneHitLeft,
        ParticleInfo = {
            Long1 = {
                State = "Emit",
                Emit = 5
            },
            Long2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            Specs = {
                State = "Emit",
                Emit = 15,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            flash = {
                State = "Emit",
                Emit = 2
            },
            ["star up1"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Long3 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 1,
                Delay = 0.05
            },
            Wave1 = {
                State = "Emit",
                Emit = 5
            }
        }
    },
    ["Yone-Right"] = {
        Object = Yone.Particles.YoneHitRight,
        ParticleInfo = {
            Long1 = {
                State = "Emit",
                Emit = 5
            },
            Long2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            Specs = {
                State = "Emit",
                Emit = 15,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            flash = {
                State = "Emit",
                Emit = 2
            },
            ["star up1"] = {
                State = "Emit",
                Emit = 2,
                Delay = 0.05
            },
            Long3 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            Wave1 = {
                State = "Emit",
                Emit = 5
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            }
        }
    },
    ["Yone-Up"] = {
        Object = Yone.Particles.YoneHitUp,
        ParticleInfo = {
            Long1 = {
                State = "Emit",
                Emit = 5
            },
            Long2 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            Specs = {
                State = "Emit",
                Emit = 15,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 25,
                Delay = 0.15
            },
            flash = {
                State = "Emit",
                Emit = 2
            },
            ["star up1"] = {
                State = "Emit",
                Emit = 2,
                Delay = 0.05
            },
            Long3 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.02
            },
            Wave1 = {
                State = "Emit",
                Emit = 5
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            }
        }
    }
};