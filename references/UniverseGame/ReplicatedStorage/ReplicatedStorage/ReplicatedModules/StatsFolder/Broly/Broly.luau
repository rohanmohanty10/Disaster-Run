  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
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
            Particle = ClientAssets.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(168, 255, 102)
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
            Particle = ClientAssets.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(168, 255, 102)
        }
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Damage = 11.25,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 0, "PlaySound", "LMB1" }, { 16, 20, "Attack" }, { 24, "End" } },
        HitRemotes = { v2 },
        HitSounds = {
            Hit = {
                SoundId = 6706979361,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 0, "PlaySound", "LMB4" }, { 16, 20, "Attack" }, { 24, "End" } },
        HitRemotes = { v3 }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1["Rush Attack"]["LMB-2"] = TableUtil.Copy(v1["Rush Attack"]["LMB-1"], true);
v1["Rush Attack"]["LMB-2"].Sequence[3] = { 0, "PlaySound", "LMB2" };
v1["Rush Attack"]["LMB-3"] = TableUtil.Copy(v1["Rush Attack"]["LMB-1"], true);
v1["Rush Attack"]["LMB-3"].Sequence[3] = { 0, "PlaySound", "LMB3" };
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Active = true
    },
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1["Eraser Blow"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 9.75
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.5, 7.5, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Finisher = {
        Priority = 100,
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.725,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 0.5
        }
    }
};
v1["Gigantic Crash"] = {
    Active = true,
    Damage = 3,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 17
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.5, 7.5, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Throw = {
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 15, 0),
                Speed = 35,
                Time = 0.1
            } }
    }
};
v1["Eraser Volley"] = {
    Active = true,
    HitAnimations = "Default",
    Damage = 5.25,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 10
    },
    Stun = {
        Time = 0.2
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    HitRemotes = { v2 },
    CollisionSounds = {
        Default = {
            ID = 7172258964,
            Props = {
                Volume = 1,
                RollOffMaxDistance = 60
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 6920222797,
            Volme = 0.6
        }
    }
};
v1["Planet Crusher"] = {
    Active = true,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 32.5
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 45,
        Offset = CFrame.new(0, 0, 0)
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Stun = {
        Time = 0.3,
        Priority = EnumsModule.Stun.Medium
    },
    HitRemotes = { v2 }
};
v1["Gigantic Breath"] = {
    Active = true,
    Armor = false,
    Damage = 3.35,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 10
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6, 6, 30),
        MaxRange = 100,
        Offset = CFrame.new(0, 2, -15)
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    }
};
v1.Omegastorm = {
    Active = true,
    Damage = 35,
    StunnedDamage = 20,
    HitAnimations = "Default",
    Actionable = {
        Stunned = false,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Block = {
        PerfectBlockable = false
    },
    Cooldown = {
        Time = 15,
        StunnedTimeMultiplier = 1.35,
        Manual = true
    },
    Meter = {
        MeterGain = 0
    },
    NonStunnedMeter = {
        MeterGain = 0,
        RequiredAmount = 25
    },
    StunnedMeter = {
        MeterGain = 0,
        RequiredAmount = 50
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 25,
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 55,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    StunnedRagdoll = {
        Time = 0.8
    }
};
v1["Legendary Super Saiyan"] = {
    Active = true,
    Duration = 120,
    Damage = 50,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Meter = {
        RequiredLevel = 3,
        MeterGain = 0
    },
    Cooldown = {
        Time = 150
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 25,
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 55,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 0.8
    },
    Priority = EnumsModule.Intangible.Quickstep
};
v1.Pulverizer = {
    Active = true,
    Damage = 5.416,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 14.5
    },
    Meter = {
        RequiredLevel = 1
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Throw = {
        Priority = 100,
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = -60,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        }
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Eraser Blow"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Wind up a grab whilst charging a ki blast. if landed release the ki blast, thrusting it into their chest at blasting target away."
            },
            ["Gigantic Crash"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Charge up ki in the palms of your hands, grabbing the targets head and dragging them across the ground."
            },
            ["Eraser Volley"] = {
                DefaultKeybind = "T",
                Description = "Release a barrage of ki blasts in front of you, locking on to enemies within range.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Planet Crusher"] = {
                DefaultKeybind = "Y",
                Description = "Amass huge amounts of ki in the air as a large ki sphere before launching it downward in the direction you are facing.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Gigantic Breath"] = {
                DefaultKeybind = "G",
                Description = "Produce ki within your mouth, firing the ki in a short ki wave in front of you.",
                LevelRequirement = 30,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Omegastorm = {
                DefaultKeybind = "H",
                Description = "Engulf yourself with overflowing ki then release it all at once, causing a AOE explosion around you.  ",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Legendary Super Saiyan"] = {
                DefaultKeybind = "J",
                Description = "Enter a state of rage and begin to overflow with power. You transform into the Legendary Super Saiyan, This form buffs all moves and gives you increased defense temporarily.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Pulverizer = {
                DefaultKeybind = "V",
                Description = "Grab your target and violently slam them on the ground back and forth multiple times before tossing them away.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 7484434387,
            ["LMB-2"] = 7484438489,
            ["LMB-3"] = 7484439114,
            ["LMB-4"] = 7484439814,
            PoseTransition = 7772902250,
            PoseIdle = 7772904787,
            HeavyBlowAttempt = 7454617308,
            HeavyBlowLoop = 7454620401,
            ChargeLoop = 7454624282,
            ChargeEnd = 7454627033,
            EraserAttempt = 7454630594,
            EraserBlow = 7454635736,
            OmegastormWindup = 7454638551,
            OmegastormLoop = 7454642789,
            OmegastormEnd = 7454646738,
            PulverizerAttempt = 7458023010,
            Pulverizer = 7458025881,
            GiganticBreath = 7500776853,
            EraserBall = 7508685914,
            PlanetCrusher = 7510053489,
            GiganticBreath1 = 7508680836,
            GiganticBreath2 = 7500776853,
            OmegastormStartup = 7454642789,
            PlanetCrusherStartup = 7510053489,
            ["Eraser Blow1"] = 7454630594,
            ["Eraser Blow2"] = 7454635736,
            ["Eraser Blo32"] = 7457490164,
            LSSJ1 = 7492873222,
            LSSJ2 = 7492876327,
            GiganticCrash2 = 7455023147,
            GiganticCrash3 = 7457490164,
            Grab = 11110729280,
            Throw = 11110730939,
            ThrowVictim = 11110732132
        },
        Movement = {
            Run = 7505927467,
            Walk = 7505925623
        },
        Idle = {
            Idle = 7505893429
        }
    },
    Stats = v1,
    Sounds = {
        PoseMusic = {
            SoundId = "rbxassetid://10394756259",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        EraserAttempt = {
            SoundId = "rbxassetid://7457613792",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        EraserAttemptSFX = {
            SoundId = "rbxassetid://7457617020",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        EraserHit = {
            SoundId = "rbxassetid://7457614681",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        EraserHitSFX = {
            SoundId = "rbxassetid://7457618637",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        EraserHitSFX2 = {
            SoundId = "rbxassetid://7457620319",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GiganticCrashWindup = {
            SoundId = "rbxassetid://7458363663",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GiganticCrash = {
            SoundId = "rbxassetid://7458364372",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PulverizerSFX = {
            SoundId = "rbxassetid://7458768447",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Pulverizer = {
            SoundId = "rbxassetid://7458767360",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Ground = {
            SoundId = "rbxassetid://7458769601",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB4 = {
            SoundId = "rbxassetid://7499564856",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB3 = {
            SoundId = "rbxassetid://7499563879",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB2 = {
            SoundId = "rbxassetid://7499562983",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB1 = {
            SoundId = "rbxassetid://7499562543",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LSSJ = {
            SoundId = "rbxassetid://7499572523",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LSSJSFX = {
            SoundId = "rbxassetid://7499575107",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        OmegastormCharge = {
            SoundId = "rbxassetid://7499737552",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        OmegastormEnd = {
            SoundId = "rbxassetid://7499738618",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BrolyTheme = {
            SoundId = "rbxassetid://9890944432",
            Volume = 2.15,
            PlaybackSpeed = 0.669,
            Looped = false,
            TimePosition = 20
        },
        EraserCharge = {
            SoundId = "rbxassetid://7509596252",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        EraserVolley = {
            SoundId = "rbxassetid://7509595032",
            Volume = 1,
            PlaybackSpeed = 3,
            Looped = false,
            TimePosition = 0
        },
        GiganticBreathWindup = {
            SoundId = "rbxassetid://7518084787",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GiganticBreath = {
            SoundId = "rbxassetid://7518087627",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PlanetCrusher = {
            SoundId = 13907120788,
            Volume = 1
        },
        ["PlanetCrusher Voiceline"] = {
            SoundId = 13907327525,
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
                    SoundId = "rbxassetid://7459019315",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Grr... GRAAAAGH! (How are you doing?)"
                        } }
                }, {
                    SoundId = "rbxassetid://7459022839",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "RAAAAAAGH! (Nice to meet you.)"
                        } }
                }, {
                    SoundId = "rbxassetid://7459025368",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "NRAAAAAAGH! (NRAAAAAAGH!)"
                        } }
                } }
        }
    }
};