  

 

local Effects = game.ReplicatedStorage["Client Assets"]["Silver Chariot"].Effects;

return {
    SCMultiSlashHit = {
        Object = Effects.MultiSlashHit,
        ParticleInfo = {
            Blood1 = {
                State = "Emit",
                Emit = 25
            },
            Blood2 = {
                State = "Emit",
                Emit = 25
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
            Wave2 = {
                State = "Emit",
                Emit = 5,
                Delay = 0.025
            },
            Wave3 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.05
            },
            Flash = {
                State = "Emit",
                Emit = 2
            }
        }
    },
    SCEyeOfTheStorm = {
        Object = Effects.EyeOfTheStorm,
        ParticleInfo = {
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Mid1 = {
                State = "Emit",
                Emit = 2
            },
            Mid2 = {
                State = "Emit",
                Emit = 2
            },
            Mid3 = {
                State = "Emit",
                Emit = 5
            },
            Mid4 = {
                State = "Emit",
                Emit = 5
            },
            Mid5 = {
                State = "Emit",
                Emit = 5
            },
            Smoke1 = {
                State = "Emit",
                Emit = 125
            },
            Smoke2 = {
                State = "Emit",
                Emit = 125
            },
            Smoke3 = {
                State = "Emit",
                Emit = 125
            },
            Smoke4 = {
                State = "Emit",
                Emit = 5
            },
            Smoke5 = {
                State = "Emit",
                Emit = 125
            },
            Sparks1 = {
                State = "Emit",
                Emit = 10
            },
            Sparks2 = {
                State = "Emit",
                Emit = 20
            },
            Sparks3 = {
                State = "Emit",
                Emit = 15
            },
            Wave1 = {
                State = "Emit",
                Emit = 5
            },
            Wave2 = {
                State = "Emit",
                Emit = 5
            },
            Wave3 = {
                State = "Emit",
                Emit = 12
            },
            Wave4 = {
                State = "Emit",
                Emit = 12
            },
            Dots = {
                State = "Emit",
                Emit = 20
            },
            Rocks = {
                State = "Emit",
                Emit = 25
            },
            Stars = {
                State = "Emit",
                Emit = 75
            }
        }
    },
    SCRicochetSurface = {
        Object = Effects.RapierSurface,
        ParticleInfo = {
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Smoke = {
                State = "Emit",
                Emit = 65
            },
            Sparks1 = {
                State = "Emit",
                Emit = 25,
                Delay = 0.03
            },
            Sparks2 = {
                State = "Emit",
                Emit = 15
            }
        }
    },
    SCRicochetFire = {
        Object = Effects.RapierFire,
        ParticleInfo = {
            Circle1 = {
                State = "Emit",
                Emit = 1
            },
            Circle2 = {
                State = "Emit",
                Emit = 1
            },
            Circle3 = {
                State = "Emit",
                Emit = 3
            },
            Circle4 = {
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
                Emit = 12
            },
            Line4 = {
                State = "Emit",
                Emit = 25
            }
        }
    },
    SCLMBHitEffect = {
        Object = Effects["SC LMB Effect"],
        ParticleInfo = {
            Circle = {
                State = "Emit",
                Emit = 3
            },
            Mid = {
                State = "Emit",
                Emit = 4
            },
            Slash = {
                State = "Emit",
                Emit = 15
            },
            Sparks = {
                State = "Emit",
                Emit = 15
            },
            Stars = {
                State = "Emit",
                Emit = 15
            },
            Blood = {
                State = "Emit",
                Emit = 125
            },
            Line1 = {
                State = "Emit",
                Emit = 25
            },
            Shockwave = {
                State = "Emit",
                Emit = 1
            }
        }
    },
    SCBarrageHitEffect = {
        Object = Effects["SC Barrage Effect"],
        ParticleInfo = {
            Line = {
                State = "Emit",
                Emit = 15
            },
            Shockwave = {
                State = "Emit",
                Emit = 3
            },
            Stars1 = {
                State = "Emit",
                Emit = 15
            },
            Stars2 = {
                State = "Emit",
                Emit = 5
            },
            Swirl1 = {
                State = "Emit",
                Emit = 5
            },
            Swirl2 = {
                State = "Emit",
                Emit = 2
            }
        }
    },
    SCRHitEffect = {
        Object = Effects["SC R Effect"],
        ParticleInfo = {
            Blood = {
                State = "Emit",
                Emit = 125
            },
            Slash1 = {
                State = "Emit",
                Emit = 15
            },
            Slash2 = {
                State = "Emit",
                Emit = 15
            },
            Blood2 = {
                State = "Emit",
                Emit = 125
            },
            Circle1 = {
                State = "Emit",
                Emit = 3
            },
            Circle2 = {
                State = "Emit",
                Emit = 3
            },
            Line1 = {
                State = "Emit",
                Emit = 25
            },
            Shockwave = {
                State = "Emit",
                Emit = 1
            }
        }
    }
};