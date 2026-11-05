  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Sol.Nova.Sol_HitVFX
        }
    }
};
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Sol.Nova.Sol_HeavyVFX
        }
    }
};

return {
    Inherit = {
        AbilityName = "Sol"
    },
    Metadata = {
        ReconcileSounds = false
    },
    Stats = {
        ["Rush Attack"] = {
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14723552478,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14723552175,
                        Volume = 1
                    }
                },
                HitRemotes = { v3 }
            },
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14723552478,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14723552175,
                        Volume = 1
                    }
                },
                HitRemotes = { v3 }
            }
        },
        ["Nova Slicer"] = {
            Normal = {
                HitSounds = {
                    Hit = {
                        SoundId = 14723552784,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            },
            Final = {
                HitSounds = {
                    Hit = {
                        SoundId = 14723552596,
                        Volume = 1
                    }
                },
                HitRemotes = { v3 }
            }
        },
        ["Cosmos Barrage"] = {
            Barrage = {
                Hit = {
                    HitSounds = {
                        Hit = {
                            SoundId = 13927706875,
                            Volume = 1
                        }
                    },
                    HitRemotes = { v2 }
                },
                Finisher = {
                    HitSounds = {
                        Hit = {
                            SoundId = 13927707488,
                            Volume = 1
                        }
                    },
                    HitRemotes = { v3 }
                }
            }
        },
        ["Star Blast"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14723550505,
                    Volume = 1
                }
            },
            HitRemotes = { v3 }
        },
        Constellation = {
            HitSounds = {
                Hit = {
                    SoundId = 14723552842,
                    Volume = 1
                }
            }
        },
        ["Cosmic Greatsword"] = {
            HitRemotes = { v2 }
        },
        ["Bladed Retaliation"] = {
            HitRemotes = { v2 }
        }
    },
    Animations = {
        Action = {
            ["Armor Activation"] = 14725148641,
            ["Armor Deactivation"] = 12743926716,
            PoseIdle = 14734170075,
            PoseTransition = 14734172432
        },
        Movement = {
            Walk = 14734362352,
            Run = 14734360027,
            ["Summoned-Walk"] = 14734362352,
            ["Summoned-Run"] = 14734360027,
            ["Armor-Walk"] = 14725150998,
            ["Armor-Run"] = 14725147051
        },
        Idle = {
            Idle = 14725127910,
            ["Summoned-Idle"] = 14725127910,
            ["Armor-Idle"] = 14725145022
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 14723551238,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 14723551131,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 14723551041,
            Volume = 1
        },
        ["Desummon-Voiceline"] = {
            SoundId = 14723550404,
            Volume = 1
        },
        ["CosmicBarrage-Startup"] = {
            SoundId = 14723552720,
            Volume = 1
        },
        ["CosmicBarrage-Startup-Voiceline"] = {
            SoundId = 14723553035,
            Volume = 1
        },
        ["Blackhole-SFX"] = {
            SoundId = 14723549732,
            Volume = 1
        },
        ["Blackhole Voice"] = {
            SoundId = 14723553312,
            Volume = 1
        },
        ["Blackhole windup SFX"] = {
            SoundId = 14723549603,
            PlaybackSpeed = 1,
            Volume = 1
        },
        ["Stardust Blast Voice"] = {
            SoundId = 14723553537,
            Volume = 1
        },
        ["Stardust Blast Charge"] = {
            SoundId = 14723550983,
            Volume = 1
        },
        ["Stardust Blast SFX"] = {
            SoundId = 14723550916,
            Volume = 1
        },
        ["Star Blast Voice"] = {
            SoundId = 14723553475,
            Volume = 1
        },
        ["Star Blast SFX"] = {
            SoundId = 14723550337,
            Volume = 1
        },
        ConstellationCombo = {
            SoundId = 14723552249,
            Volume = 1
        },
        WindUpConstellation = {
            SoundId = 14723552374,
            Volume = 1
        },
        Teleport = {
            SoundId = "rbxassetid://13346148582",
            Volume = 1
        },
        ["Sol Armor"] = {
            SoundId = 14723550187,
            Volume = 1
        },
        ["Sol Armor Voice"] = {
            SoundId = 14723553382,
            Volume = 1
        },
        ["Sol Armor Off"] = {
            SoundId = 13346200109,
            Volume = 1
        },
        ["Terreno Voice"] = {
            SoundId = 14723553217,
            Volume = 1
        },
        ["Terreno Startup"] = {
            SoundId = 13346312778,
            Volume = 1
        },
        ["Nova Piercer Startup SFX"] = {
            SoundId = 14723550686,
            Volume = 1
        },
        ["Nova Piercer Hit"] = {
            SoundId = 14723550564,
            Volume = 1
        },
        ["Nova Piercer Hit SFX"] = {
            SoundId = 14723550787,
            Volume = 1
        },
        ["Nova Piercer Startup"] = {
            SoundId = 14723550627,
            Volume = 1
        },
        ["Nova Slicer Normal"] = {
            SoundId = 14723551808,
            Volume = 1
        },
        ["Nova Slicer Final"] = {
            SoundId = 14723552298,
            Volume = 1
        },
        ["NovaSlicer-Sword-Summon"] = {
            SoundId = 14723549225,
            Volume = 1
        },
        ["Counter Counter Startup"] = {
            SoundId = 14736000025,
            Volume = 1
        },
        ["Greatsword Startup"] = {
            SoundId = 14723549432,
            Volume = 1
        },
        ["Greatsword Voice"] = {
            SoundId = 14723549356,
            Volume = 1
        },
        ["Greatsword Summon"] = {
            SoundId = 14728369244,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 14736000643,
            Volume = 1,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 14723552119,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14723552049,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14723551910,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14723551644,
            Volume = 1
        },
        ["SwingLMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 1
        },
        ["SwingLMB 4"] = {
            SoundId = 11499912997,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 14723552119,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 14723552049,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 14723551910,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 14723551644,
            Volume = 1
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 1
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 11499912997,
            Volume = 1
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
                    SoundId = "rbxassetid://14723551720",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Weak...",
                            ScaleTime = 0.6
                        }, {
                            Quote = "Too weak.",
                            ScaleTime = 0.6
                        } }
                }, {
                    SoundId = "rbxassetid://14723551553",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Come on",
                            ScaleTime = 0.17,
                            EndLag = 0.5
                        }, {
                            Quote = ", entertain me.",
                            ScaleTime = 0.25
                        } }
                }, {
                    SoundId = "rbxassetid://14723551411",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What\'s wrong? Is that all?"
                        } }
                }, {
                    SoundId = "rbxassetid://14723551323",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I...",
                            ScaleTime = 0.6
                        }, {
                            Quote = "shall end everything.",
                            ScaleTime = 1
                        } }
                } }
        }
    }
};