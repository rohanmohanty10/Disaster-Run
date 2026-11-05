  

 

local GER = game.ReplicatedStorage["Client Assets"].GER;

return {
    BarrageHitEffect = {
        Object = GER.BarrageHitEffect,
        ParticleInfo = {
            Hit1 = {
                State = "Emit",
                Emit = 2
            },
            ember2 = {
                State = "Emit",
                Emit = 12
            },
            ["sparks small"] = {
                State = "Emit",
                Emit = 12
            },
            Hit2 = {
                State = "Emit",
                Emit = 2
            },
            ember3 = {
                State = "Emit",
                Emit = 1
            },
            ember = {
                State = "Emit",
                Emit = 1
            },
            Hit3 = {
                State = "Emit",
                Emit = 2
            },
            ember1 = {
                State = "Emit",
                Emit = 1
            }
        }
    },
    LightEffectGER = {
        Object = GER.LightHit,
        ParticleInfo = {
            ember = {
                State = "Emit",
                Emit = 12
            },
            ["sparks small"] = {
                State = "Emit",
                Emit = 12
            },
            Hit2 = {
                State = "Emit",
                Emit = 1
            },
            BlackHit = {
                State = "Emit",
                Emit = 1
            },
            Blunt = {
                State = "Emit",
                Emit = 1
            }
        }
    },
    HeavyEffectGER = {
        Object = GER.HeavyHit,
        ParticleInfo = {
            ["sparks small"] = {
                State = "Emit",
                Emit = 12
            },
            Hit2 = {
                State = "Emit",
                Emit = 1
            },
            ["Shockwave 5"] = {
                State = "Emit",
                Emit = 5
            },
            ["sparks small2"] = {
                State = "Emit",
                Emit = 40
            },
            winds = {
                State = "Emit",
                Emit = 10
            },
            ember = {
                State = "Emit",
                Emit = 12
            },
            ["Shockwave 52"] = {
                State = "Emit",
                Emit = 5
            },
            Circle1 = {
                State = "Emit",
                Emit = 5
            },
            Flare = {
                State = "Emit",
                Emit = 2
            }
        }
    },
    HealEffectGER = {
        Object = GER.Heal,
        ParticleInfo = {
            Heal1 = {
                State = "Emit",
                Emit = 15
            },
            Dots2 = {
                State = "Emit",
                Emit = 35
            },
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Lines = {
                State = "Emit",
                Emit = 25
            },
            Circle3 = {
                State = "Emit",
                Emit = 3
            },
            Circle2 = {
                State = "Emit",
                Emit = 3
            },
            Circle1 = {
                State = "Emit",
                Emit = 1
            },
            Dots1 = {
                State = "Emit",
                Emit = 12
            },
            Heal2 = {
                State = "Emit",
                Emit = 3
            }
        }
    },
    ["RTZ Activation"] = {
        Object = GER["RTZ Activation"],
        ParticleInfo = {
            Smoke4 = {
                State = "Emit",
                Emit = 5
            },
            Smoke2 = {
                State = "Emit",
                Emit = 25
            },
            Wave3 = {
                State = "Emit",
                Emit = 12
            },
            Mid2 = {
                State = "Emit",
                Emit = 2
            },
            Mid1 = {
                State = "Emit",
                Emit = 2
            },
            Sparks1 = {
                State = "Emit",
                Emit = 10,
                Delay = 0.03
            },
            Sparks3 = {
                State = "Emit",
                Emit = 15
            },
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Mid3 = {
                State = "Emit",
                Emit = 2
            },
            Words = {
                State = "Emit",
                Emit = 1
            },
            ["CenterStar "] = {
                State = "Emit",
                Emit = 1
            },
            Radial1 = {
                State = "Emit",
                Emit = 3
            },
            ["Stars(125)"] = {
                State = "Emit",
                Emit = 75
            },
            Dots = {
                State = "Emit",
                Emit = 20
            }
        }
    },
    ["RTZ Cancel"] = {
        Object = GER["RTZ Cancel"],
        ParticleInfo = {
            Wave2 = {
                State = "Emit",
                Emit = 5
            },
            Sparks2 = {
                State = "Emit",
                Emit = 20,
                Delay = 0.03
            },
            Wave4 = {
                State = "Emit",
                Emit = 12
            },
            Smoke4 = {
                State = "Emit",
                Emit = 5
            },
            Smoke2 = {
                State = "Emit",
                Emit = 65
            },
            Smoke3 = {
                State = "Emit",
                Emit = 65
            },
            Wave3 = {
                State = "Emit",
                Emit = 12
            },
            Mid3 = {
                State = "Emit",
                Emit = 2
            },
            Mid2 = {
                State = "Emit",
                Emit = 2
            },
            Sparks3 = {
                State = "Emit",
                Emit = 15
            },
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Mid1 = {
                State = "Emit",
                Emit = 2
            },
            ["Stars(125)"] = {
                State = "Emit",
                Emit = 75
            },
            Dots = {
                State = "Emit",
                Emit = 20
            },
            Circle2 = {
                State = "Emit",
                Emit = 3
            }
        }
    },
    DebrisShotFire = {
        Object = GER.DebrisShotFire,
        ParticleInfo = {
            Stars = {
                State = "Emit",
                Emit = 25
            },
            Circle2 = {
                State = "Emit",
                Emit = 1
            },
            Circle7 = {
                State = "Emit",
                Emit = 5
            },
            Circle1 = {
                State = "Emit",
                Emit = 5
            },
            Circle3 = {
                State = "Emit",
                Emit = 1
            },
            Circle4 = {
                State = "Emit",
                Emit = 3
            },
            Circle8 = {
                State = "Emit",
                Emit = 3
            },
            Circle9 = {
                State = "Emit",
                Emit = 3
            },
            Circle5 = {
                State = "Emit",
                Emit = 5
            },
            Circle6 = {
                State = "Emit",
                Emit = 1
            },
            Line1 = {
                State = "Emit",
                Emit = 25
            },
            Line2 = {
                State = "Emit",
                Emit = 25
            },
            Line3 = {
                State = "Emit",
                Emit = 25
            },
            Line4 = {
                State = "Emit",
                Emit = 25
            },
            Line5 = {
                State = "Emit",
                Emit = 25
            },
            Line6 = {
                State = "Emit",
                Emit = 25
            },
            Line7 = {
                State = "Emit",
                Emit = 25
            },
            Line8 = {
                State = "Emit",
                Emit = 25
            }
        }
    },
    Beamhit = {
        Object = GER.Beamhit,
        ParticleInfo = {
            ["sparks small2"] = {
                State = "Emit",
                Emit = 12
            },
            ["sparks small"] = {
                State = "Emit",
                Emit = 12
            },
            shot = {
                State = "Emit",
                Emit = 5
            },
            Long = {
                State = "Emit",
                Emit = 1,
                Delay = 0.02
            },
            Slash = {
                State = "Emit",
                Emit = 5
            }
        }
    }
};