  

 

local Umbra = game.ReplicatedStorage["Client Assets"].Umbra;

return {
    PikaSummon = {
        Object = Umbra.Particles.Pika.SummonPart,
        ParticleInfo = {
            PullSphere = {
                State = "Emit",
                Emit = 50
            },
            Glow = {
                State = "Emit",
                Emit = 2
            },
            Ring = {
                State = "Emit",
                Emit = 2
            },
            Star = {
                State = "Emit",
                Emit = 1
            },
            Waves = {
                State = "Emit",
                Emit = 3
            },
            ember = {
                State = "Emit",
                Emit = 12
            },
            PullLines = {
                State = "Emit",
                Emit = 50
            }
        }
    },
    PikaCounter = {
        Object = Umbra.Particles.Pika.PikaCounter,
        ParticleInfo = {
            Wave = {
                State = "Emit",
                Emit = 1
            },
            Ring = {
                State = "Emit",
                Emit = 2
            },
            Star = {
                State = "Emit",
                Emit = 3
            },
            Shockwaves = {
                State = "Emit",
                Emit = 15
            },
            Waves = {
                State = "Emit",
                Emit = 3
            },
            Specs = {
                State = "Emit",
                Emit = 25
            }
        }
    },
    PikaDash = {
        Object = Umbra.Particles.Pika.PikaDash,
        ParticleInfo = {
            ParticleEmitter = {
                State = "Emit",
                Emit = 2
            },
            Ring = {
                State = "Emit",
                Emit = 2
            },
            Glow = {
                State = "Emit",
                Emit = 2
            },
            ember = {
                State = "Emit",
                Emit = 12
            }
        }
    },
    PikaThrow = {
        Object = Umbra.Particles.Pika.PikaThrow,
        ParticleInfo = {
            Circle = {
                State = "Emit",
                Emit = 3
            },
            Stars = {
                State = "Emit",
                Emit = 25
            },
            Circle4 = {
                State = "Emit",
                Emit = 1
            },
            Line3 = {
                State = "Emit",
                Emit = 1
            },
            Circle3 = {
                State = "Emit",
                Emit = 1
            },
            Circle2 = {
                State = "Emit",
                Emit = 1
            },
            Line = {
                State = "Emit",
                Emit = 12
            },
            Line2 = {
                State = "Emit",
                Emit = 12
            }
        }
    },
    PikaHeavy = {
        Object = Umbra.Particles.Pika.PikaHeavy,
        ParticleInfo = {
            Slash = {
                State = "Emit",
                Emit = 15
            },
            Circle1 = {
                State = "Emit",
                Emit = 3
            },
            Blood1 = {
                State = "Emit",
                Emit = 125
            },
            sparks = {
                State = "Emit",
                Emit = 15
            },
            sparks2 = {
                State = "Emit",
                Emit = 20
            },
            Dots = {
                State = "Emit",
                Emit = 5
            },
            Glow = {
                State = "Emit",
                Emit = 2
            },
            Ring = {
                State = "Emit",
                Emit = 2
            },
            Shockwave2 = {
                State = "Emit",
                Emit = 5
            },
            Shockwave1 = {
                State = "Emit",
                Emit = 5
            },
            winds = {
                State = "Emit",
                Emit = 10
            },
            Slash2 = {
                State = "Emit",
                Emit = 15
            }
        }
    },
    PikaHit = {
        Object = Umbra.Particles.Pika.PikaHit,
        ParticleInfo = {
            Slash = {
                State = "Emit",
                Emit = 15
            },
            Circle1 = {
                State = "Emit",
                Emit = 3
            },
            Blood1 = {
                State = "Emit",
                Emit = 125
            },
            Circle2 = {
                State = "Emit",
                Emit = 3
            },
            sparks = {
                State = "Emit",
                Emit = 15
            },
            sparks2 = {
                State = "Emit",
                Emit = 20
            },
            Dots = {
                State = "Emit",
                Emit = 5
            },
            Glow = {
                State = "Emit",
                Emit = 2
            },
            Ring = {
                State = "Emit",
                Emit = 2
            }
        }
    }
};