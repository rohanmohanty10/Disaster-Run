  

 

local v1 = game.ReplicatedStorage["Client Assets"].Assets.Abilities["Weather Report"];

return {
    WeatherReportHitEffect = {
        Object = v1.LightningHitEffect,
        ParticleInfo = {
            Lightning1 = {
                State = "Emit",
                Emit = 5
            },
            Lightning2 = {
                State = "Emit",
                Emit = 5
            },
            Lightning3 = {
                State = "Emit",
                Emit = 5
            },
            Summon = {
                State = "Toggle"
            },
            Blunt1 = {
                State = "Emit",
                Emit = 5
            },
            Blunt2 = {
                State = "Emit",
                Emit = 5
            },
            Circle1 = {
                State = "Emit",
                Emit = 15
            },
            Dots1 = {
                State = "Emit",
                Emit = 15
            },
            Dots2 = {
                State = "Emit",
                Emit = 15
            },
            Sparks = {
                State = "Emit",
                Emit = 15
            },
            Wind1 = {
                State = "Emit",
                Emit = 15
            },
            Wind2 = {
                State = "Emit",
                Emit = 15
            }
        }
    },
    LungExhaustion = {
        Object = v1.LungExhaustion.Particle,
        ParticleInfo = {
            Blunt1 = {
                State = "Emit",
                Emit = 1
            },
            sparks = {
                State = "Emit",
                Emit = 15
            },
            ["sparks small"] = {
                State = "Emit",
                Emit = 15
            },
            Shockwave = {
                State = "Emit",
                Emit = 5
            },
            Blunt3 = {
                State = "Emit",
                Emit = 1
            },
            Circle = {
                State = "Emit",
                Emit = 5
            },
            Lines = {
                State = "Emit",
                Emit = 15
            },
            Smoke = {
                State = "Emit",
                Emit = 3
            },
            Mid1 = {
                State = "Emit",
                Emit = 4
            },
            Mid2 = {
                State = "Emit",
                Emit = 4
            }
        }
    },
    WRExplosion = {
        Object = v1.Particles.Explosion,
        ParticleInfo = {
            dots = {
                State = "Emit",
                Emit = 15
            },
            spikes = {
                State = "Emit",
                Emit = 15
            },
            Smoke = {
                State = "Emit",
                Emit = 5
            },
            Smoke2 = {
                State = "Emit",
                Emit = 15
            },
            Flare = {
                State = "Emit",
                Emit = 1
            },
            Lines = {
                State = "Emit",
                Emit = 15
            },
            Words = {
                State = "Emit",
                Emit = 1
            },
            dots2 = {
                State = "Emit",
                Emit = 10
            },
            Spark1 = {
                State = "Emit",
                Emit = 3
            },
            Spark2 = {
                State = "Emit",
                Emit = 3
            }
        }
    },
    BloodOxHit = {
        Object = v1.Particles.BloodOxLastHit,
        ParticleInfo = {
            Circle = {
                State = "Emit",
                Emit = 10
            },
            Circle2 = {
                State = "Emit",
                Emit = 8
            },
            Circle3 = {
                State = "Emit",
                Emit = 10
            },
            Circle4 = {
                State = "Emit",
                Emit = 5
            },
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Line = {
                State = "Emit",
                Emit = 15
            },
            Line2 = {
                State = "Emit",
                Emit = 15
            },
            Mid = {
                State = "Emit",
                Emit = 3
            },
            Words = {
                State = "Emit",
                Emit = 1
            },
            ["sparks small"] = {
                State = "Emit",
                Emit = 15
            }
        }
    },
    WRIceBreath = {
        Object = v1.Particles.ICEBREATH,
        ParticleInfo = {
            Flare = {
                State = "Emit",
                Emit = 4
            },
            Fillingsmoke1 = {
                State = "Emit",
                Emit = 7
            },
            Lines = {
                State = "Emit",
                Emit = 20
            },
            Stars = {
                State = "Emit",
                Emit = 35
            },
            spin = {
                State = "Emit",
                Emit = 10
            },
            Snowflakes = {
                State = "Emit",
                Emit = 2
            }
        }
    },
    WRBlackHiteffect = {
        Object = v1.Particles.BlackHit,
        ParticleInfo = {
            Flare = {
                State = "Emit",
                Emit = 2
            },
            Ember = {
                State = "Emit",
                Emit = 15
            },
            Circle1 = {
                State = "Emit",
                Emit = 7
            },
            Hit1 = {
                State = "Emit",
                Emit = 4
            },
            Hit2 = {
                State = "Emit",
                Emit = 4
            },
            SparkBig = {
                State = "Emit",
                Emit = 15
            },
            SparkSmall = {
                State = "Emit",
                Emit = 15
            }
        }
    },
    WRWindeffect = {
        Object = v1.Particles.WindHiteffect,
        ParticleInfo = {
            Flare = {
                State = "Emit",
                Emit = 2
            },
            Ember = {
                State = "Emit",
                Emit = 15
            },
            Circle1 = {
                State = "Emit",
                Emit = 4
            },
            Hit1 = {
                State = "Emit",
                Emit = 4
            },
            Hit2 = {
                State = "Emit",
                Emit = 4
            }
        }
    },
    WRFlareRing = {
        Object = v1.Particles["Flare Ring"],
        ParticleInfo = {
            Mark = {
                State = "Emit",
                Emit = 25
            },
            Spin1 = {
                State = "Emit",
                Emit = 3
            },
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Spin2 = {
                State = "Emit",
                Emit = 3
            },
            Spin4 = {
                State = "Emit",
                Emit = 25
            },
            ["CenterStar "] = {
                State = "Emit",
                Emit = 1
            },
            Radial = {
                State = "Emit",
                Emit = 3
            },
            Flare2 = {
                State = "Emit",
                Emit = 3
            },
            Flare3 = {
                State = "Emit",
                Emit = 3
            },
            Spin3 = {
                State = "Emit",
                Emit = 3
            },
            Sparks = {
                State = "Emit",
                Emit = 25
            },
            Line = {
                State = "Emit",
                Emit = 25
            },
            ExplosionSmoke = {
                State = "Emit",
                Emit = 35
            },
            SmokeImpact = {
                State = "Emit",
                Emit = 35
            },
            ExplosionSmoke2 = {
                State = "Emit",
                Emit = 35
            },
            Explosion = {
                State = "Emit",
                Emit = 35
            },
            UhWIND = {
                State = "Emit",
                Emit = 35
            },
            Dots = {
                State = "Emit",
                Emit = 15
            },
            Dots2 = {
                State = "Emit",
                Emit = 15
            },
            ExplosionSmoke3 = {
                State = "Emit",
                Emit = 35
            }
        }
    },
    WRElementWindup = {
        Object = v1.Particles.ElementWindup,
        ParticleInfo = {
            ["CenterStar "] = {
                State = "Emit",
                Emit = 1
            },
            Radial2 = {
                State = "Emit",
                Emit = 3
            },
            tentacles = {
                State = "Emit",
                Emit = 5
            },
            Rune1 = {
                State = "Emit",
                Emit = 3
            },
            Mid = {
                State = "Emit",
                Emit = 2
            },
            dots = {
                State = "Emit",
                Emit = 20
            },
            Rune2 = {
                State = "Emit",
                Emit = 1
            },
            Radial1 = {
                State = "Emit",
                Emit = 3
            },
            Fillingsmoke2 = {
                State = "Emit",
                Emit = 25
            },
            Line3 = {
                State = "Emit",
                Emit = 30
            },
            Stars = {
                State = "Emit",
                Emit = 25
            },
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Words = {
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
            }
        }
    },
    WRFrogExplode = {
        Object = v1.Particles.FrogExplode,
        ParticleInfo = {
            Purple2 = {
                State = "Emit",
                Emit = 1,
                Delay = 0.75
            },
            Purple1 = {
                State = "Emit",
                Emit = 1,
                Delay = 0.75
            },
            Flare = {
                State = "Emit",
                Emit = 2
            },
            spin = {
                State = "Emit",
                Emit = 5
            },
            Lines2 = {
                State = "Emit",
                Emit = 15
            },
            Lines = {
                State = "Emit",
                Emit = 15
            },
            Purple3 = {
                State = "Emit",
                Emit = 1,
                Delay = 0.75
            }
        }
    },
    WRFrogLand = {
        Object = v1.Particles.FrogLand,
        ParticleInfo = {
            Purple3 = {
                State = "Emit",
                Emit = 1,
                Delay = 0.75
            },
            Purple2 = {
                State = "Emit",
                Emit = 1,
                Delay = 0.75
            },
            Purple1 = {
                State = "Emit",
                Emit = 1,
                Delay = 0.75
            },
            Lines = {
                State = "Emit",
                Emit = 15
            },
            SmallExplo2 = {
                State = "Emit",
                Emit = 35
            },
            SmallExplo = {
                State = "Emit",
                Emit = 35
            }
        }
    },
    WRSummon = {
        Object = v1.Particles.WRSummon,
        ParticleInfo = {
            Circle = {
                State = "Emit",
                Emit = 5
            },
            Circle3 = {
                State = "Emit",
                Emit = 3
            },
            Circle2 = {
                State = "Emit",
                Emit = 3
            },
            Fillingsmoke1 = {
                State = "Emit",
                Emit = 35
            },
            Flare = {
                State = "Emit",
                Emit = 3
            },
            Stars2 = {
                State = "Emit",
                Emit = 25
            },
            Stars = {
                State = "Emit",
                Emit = 25
            },
            Summon = {
                State = "Emit",
                Emit = 15
            },
            ["sparks small"] = {
                State = "Emit",
                Emit = 25
            }
        }
    },
    ["Anti-Venom-Summon"] = {
        ParticleInfo = {
            Light5 = {
                State = "Emit",
                Emit = 5
            },
            Wind2 = {
                State = "Emit",
                Emit = 1
            },
            Wind1 = {
                State = "Emit",
                Emit = 9
            },
            WindEffect = {
                State = "Emit",
                Emit = 35
            },
            Light = {
                State = "Emit",
                Emit = 5
            },
            Light3 = {
                State = "Emit",
                Emit = 5
            },
            Light4 = {
                State = "Emit",
                Emit = 5
            },
            Light2 = {
                State = "Emit",
                Emit = 5
            }
        }
    },
    ["MoonKnight-Summon"] = {
        ParticleInfo = {
            Wind2 = {
                State = "Emit",
                Emit = 9
            },
            Light4 = {
                State = "Emit",
                Emit = 5
            },
            Light6 = {
                State = "Emit",
                Emit = 5
            },
            Light3 = {
                State = "Emit",
                Emit = 5
            },
            Wind1 = {
                State = "Emit",
                Emit = 9
            },
            Light5 = {
                State = "Emit",
                Emit = 5
            },
            Light2 = {
                State = "Emit",
                Emit = 5
            }
        }
    }
};