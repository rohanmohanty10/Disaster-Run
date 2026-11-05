  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage["Client Assets"];
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = {
        AbilityName = "Sol"
    },
    Metadata = {
        ReconcileSounds = false
    },
    Stats = {
        Pose = {
            Callbacks = {
                PoseLoop = function(p2, p3) -- Line: 14, Name: PoseLoop
                    -- upvalues: u1 (copy), ParticleHandler (copy)
                    local v4 = p2.Character["Left Arm"];
                    local Trove = p3.Trove;
                    NumberSequence.new(1);
                    local u5 = u1.Sol.BlackHole.Black:Clone();
                    ParticleHandler.Unusualify(u5, {
                        IncludeParts = true,
                        Player = p2.Player,
                        Character = p2.Character
                    });
                    u5.CFrame = CFrame.new(0, -1.5, 0);
                    ParticleHandler.ScaleParticle(u5, 0.75);
                    local u6 = ParticleHandler.EnableParticle(u5, true);
                    Trove:Add(function() -- Line: 25
                        -- upvalues: ParticleHandler (ref), u5 (copy), u6 (copy)
                        ParticleHandler.EnableParticle(u5, false);
                        task.delay(u6, u5.Destroy, u5);
                    end);
                    u5.Parent = v4;
                end
            }
        },
        ["Bladed Retaliation"] = {
            Success = {
                HitSounds = {
                    Hit = {
                        SoundId = 13927707652,
                        Volume = 1
                    }
                }
            }
        },
        ["Rush Attack"] = {
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13927708533,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13927708437,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13927708349,
                        Volume = 1.5
                    }
                },
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "HitEffect V3",
                            {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                AutoSerialize = true,
                                LookAt = "Attacker",
                                Particle = u1.Sol.Polaris.Sol_HitVFX
                            }
                        }
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13927708281,
                        Volume = 1.5
                    }
                },
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "HitEffect V3",
                            {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                AutoSerialize = true,
                                LookAt = "Attacker",
                                Particle = u1.Sol.Polaris.Sol_HeavyVFX,
                                Offset = CFrame.Angles(0, 3.141592653589793, 0)
                            }
                        }
                    }
                }
            }
        },
        ["Nova Slicer"] = {
            Normal = {
                HitSounds = {
                    Hit = {
                        SoundId = 13346330123,
                        Volume = 1.5
                    }
                }
            },
            Final = {
                HitSounds = {
                    Hit = {
                        SoundId = 13346330118,
                        Volume = 2
                    }
                }
            }
        },
        ["Cosmos Barrage"] = {
            Barrage = {
                Hit = {
                    HitSounds = {
                        Hit = {
                            SoundId = 13927706875,
                            Volume = 1.5
                        }
                    }
                },
                Finisher = {
                    HitSounds = {
                        Hit = {
                            SoundId = 13927707488,
                            Volume = 1.5
                        }
                    }
                }
            }
        },
        ["Star Blast"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13927706198,
                    Volume = 2
                }
            }
        },
        Constellation = {
            HitSounds = {
                Hit = {
                    SoundId = 13927707976,
                    Volume = 1.65
                }
            }
        }
    },
    Animations = {
        Action = {
            PoseIdle = 13014257066,
            PoseTransition = 13014254885
        },
        Movement = {
            Walk = 13014252343,
            Run = 13014249615,
            ["Armor-Walk"] = 13014252343,
            ["Armor-Run"] = 13014249615
        },
        Idle = {
            Idle = 13014367524,
            ["Armor-Idle"] = 13014367524
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 13927707189,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://13346139003",
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 13927707075,
            Volume = 2
        },
        Grab = {
            SoundId = 13346419399,
            Volume = 2
        },
        Grabbed = {
            SoundId = 13346419406,
            Volume = 2
        },
        ["CosmicBarrage-Startup"] = {
            SoundId = "rbxassetid://13346370240",
            Volume = 2
        },
        ["CosmicBarrage-Startup-Voiceline"] = {
            SoundId = "rbxassetid://13346370249",
            Volume = 2
        },
        CosmicBarrage = {
            SoundId = 13927707426,
            Volume = 2
        },
        ["CosmicBarrage-Voiceline"] = {
            SoundId = "rbxassetid://13346370250",
            Volume = 2
        },
        ["Blackhole-SFX"] = {
            SoundId = 13927707874,
            Volume = 2
        },
        ["Blackhole Voice"] = {
            SoundId = "rbxassetid://13346174223",
            Volume = 2
        },
        ["Blackhole windup SFX"] = {
            SoundId = 13927707874,
            PlaybackSpeed = 1,
            Volume = 2
        },
        ["Stardust Blast Voice"] = {
            SoundId = "rbxassetid://13346307678",
            Volume = 2
        },
        ["Stardust Blast Charge"] = {
            SoundId = 13927706036,
            Volume = 2
        },
        ["Stardust Blast SFX"] = {
            SoundId = "rbxassetid://13346307684",
            Volume = 2
        },
        ["Star Blast Voice"] = {
            SoundId = "rbxassetid://13346396063",
            Volume = 2
        },
        ["Star Blast SFX"] = {
            SoundId = 13927706036,
            Volume = 2
        },
        MeterUp1 = {
            SoundId = 7146792142,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 7146792142,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 13927708803,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13927708611,
            Volume = 2
        },
        ConstellationCombo = {
            SoundId = 13927708031,
            Volume = 2
        },
        WindUpConstellation = {
            SoundId = 13927708118,
            Volume = 1.5
        },
        ["WindUpConstellation-Voiceline"] = {
            SoundId = "rbxassetid://13346412206",
            Volume = 1.5
        },
        Teleport = {
            SoundId = "rbxassetid://13346148582",
            Volume = 1.5
        },
        ["Sol Armor"] = {
            SoundId = 13927706131,
            PlaybackSpeed = 1,
            Volume = 1.5
        },
        ["Sol Armor Voice"] = {
            SoundId = "rbxassetid://13346200110",
            Volume = 2
        },
        ["Sol Armor Off"] = {
            SoundId = "rbxassetid://13346200109",
            Volume = 2
        },
        ["Terreno Voice"] = {
            SoundId = "rbxassetid://13346312783",
            Volume = 2
        },
        ["Terreno Startup"] = {
            SoundId = "rbxassetid://13346312778",
            Volume = 1.5
        },
        ["Terreno-SFX"] = {
            SoundId = 13927705939,
            Volume = 1.5
        },
        ["Terreno-End-SFX"] = {
            SoundId = "rbxassetid://13346312789",
            Volume = 1.5
        },
        ["Nova Piercer Startup SFX"] = {
            SoundId = 13927707356,
            Volume = 2
        },
        ["Nova Piercer Hit"] = {
            SoundId = 13927706709,
            Volume = 2
        },
        ["Nova Piercer Hit SFX"] = {
            SoundId = 13927707290,
            Volume = 2
        },
        ["Nova Piercer Startup"] = {
            SoundId = 13927706814,
            Volume = 2
        },
        ["Nova Slicer Normal"] = {
            SoundId = "rbxassetid://13346330117",
            Volume = 2
        },
        ["Nova Slicer Final"] = {
            SoundId = "rbxassetid://13346330117",
            Volume = 2
        },
        ["NovaSlicer-Sword-Summon"] = {
            SoundId = "rbxassetid://13346330115",
            Volume = 2
        },
        ["NovaSlicer-Sword-Desummon"] = {
            SoundId = "rbxassetid://13346330113",
            Volume = 2
        },
        ["Counter-Windup"] = {
            SoundId = 13927707737,
            Volume = 1
        },
        ["Counter-Windup-Voiceline"] = {
            SoundId = "rbxassetid://13346220321",
            Volume = 1
        },
        ["Counter-SFX"] = {
            SoundId = "rbxassetid://13346220309",
            Volume = 1
        },
        ["Counter-Blade-Summon"] = {
            SoundId = 13927707773,
            Volume = 1
        },
        ["Counter-Blade-Throw"] = {
            SoundId = "rbxassetid://13346220312",
            Volume = 1
        },
        ["Greatsword Startup"] = {
            SoundId = 13927706316,
            Volume = 2
        },
        ["Greatsword Voice"] = {
            SoundId = 13927705673,
            Volume = 2
        },
        ["Greatsword Summon"] = {
            SoundId = "rbxassetid://12926343321",
            Volume = 1.5
        },
        ["Greatsword Explode"] = {
            SoundId = 13927713493,
            Volume = 2.5
        },
        PoseMusic = {
            SoundId = 13346509899,
            Volume = 1.5,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 13346163743,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 13346163744,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 13346163745,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 13346163747,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 13927706987,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 13927706929,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13346163743,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13346163744,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13346163745,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13346163747,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 13346289993,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 13346289993,
            Volume = 2
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://13346084970",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Your demise beckons"
                        } }
                }, {
                    SoundId = "rbxassetid://13346084967",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The affairs of mortals are beneath me"
                        } }
                }, {
                    SoundId = "rbxassetid://13346084971",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I see the forces that hold the universe together"
                        } }
                }, {
                    SoundId = "rbxassetid://13346084987",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*crazed laughter*"
                        } }
                } }
        }
    }
};