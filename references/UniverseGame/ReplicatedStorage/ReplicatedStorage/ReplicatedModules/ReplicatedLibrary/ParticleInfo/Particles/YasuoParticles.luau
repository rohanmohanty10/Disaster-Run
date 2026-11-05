  

 

local Yasuo = game.ReplicatedStorage["Client Assets"].Yasuo;

return {
    YasuoTornado = {
        Object = Yasuo.Particles.TornadoAnimationActivate,
        ParticleInfo = {
            Circle = {
                State = "Emit",
                Emit = 3
            },
            Line1 = {
                State = "Emit",
                Emit = 45
            },
            Line3 = {
                State = "Emit",
                Emit = 25
            },
            Line2 = {
                State = "Emit",
                Emit = 25
            },
            ["star up"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
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
            Long2 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.02
            },
            Flare = {
                State = "Emit",
                Emit = 3
            }
        }
    },
    YasuoPierce = {
        Object = Yasuo.Particles["Yasuo Pierce"]
    },
    ["Yasuo-LMB-1"] = {
        Object = Yasuo.Particles.LMBHIT1,
        ParticleInfo = {
            ["Gun shot"] = {
                State = "Emit",
                Emit = 5
            },
            Long = {
                State = "Emit",
                Emit = 5,
                Delay = 0.02
            },
            ["star up"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 5,
                Delay = 0.15
            },
            EX1 = {
                State = "Emit",
                Emit = 5
            },
            Specs3 = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs2 = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Slash = {
                State = "Emit",
                Emit = 5
            },
            Blood1 = {
                State = "Emit",
                Emit = 5
            },
            EX2 = {
                State = "Emit",
                Emit = 5
            }
        }
    },
    ["Yasuo-LMB-2"] = {
        Object = Yasuo.Particles["LMB HIT2"],
        ParticleInfo = {
            ["Gun shot"] = {
                State = "Emit",
                Emit = 5
            },
            Long = {
                State = "Emit",
                Emit = 5,
                Delay = 0.02
            },
            ["star up"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs3 = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 5,
                Delay = 0.15
            },
            EX2 = {
                State = "Emit",
                Emit = 5
            },
            Specs2 = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Slash = {
                State = "Emit",
                Emit = 5
            },
            Blood1 = {
                State = "Emit",
                Emit = 5
            },
            EX1 = {
                State = "Emit",
                Emit = 5
            }
        }
    },
    ["Yasuo-LMB-3"] = {
        Object = Yasuo.Particles["LMB3 HIT3"],
        ParticleInfo = {
            ["Gun shot"] = {
                State = "Emit",
                Emit = 5
            },
            Long = {
                State = "Emit",
                Emit = 5,
                Delay = 0.02
            },
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Stars = {
                State = "Emit",
                Emit = 5,
                Delay = 0.15
            },
            EX2 = {
                State = "Emit",
                Emit = 5
            },
            Specs2 = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            ["star up"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Specs3 = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            },
            Slash = {
                State = "Emit",
                Emit = 5
            },
            Blood1 = {
                State = "Emit",
                Emit = 5
            },
            EX1 = {
                State = "Emit",
                Emit = 5
            }
        }
    },
    ["Yasuo-Left"] = {
        Object = Yasuo.Particles.YasuoHitLeft,
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
            Long3 = {
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
            Wave1 = {
                State = "Emit",
                Emit = 5
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
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            }
        }
    },
    ["Yasuo-Right"] = {
        Object = Yasuo.Particles.YasuoHitRight,
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
    ["Yasuo-Up"] = {
        Object = Yasuo.Particles.YasuoHitUp,
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
            Long3 = {
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
            Wave1 = {
                State = "Emit",
                Emit = 5
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
            ["star up2"] = {
                State = "Emit",
                Emit = 5,
                Delay = 0.05
            }
        }
    }
};