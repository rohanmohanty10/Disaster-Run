  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local Vampire = PathShortcuts.ClientAssets.Vampire;
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnableTrail = require(script.EnableTrail);
local v1 = {};
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
            Particle = Vampire.Global.HitEffect
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
            Particle = Vampire.Global.HeavyEffect
        }
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 23, 25, "Attack" }, { 27, "End" } },
        Stun = {
            Time = 0.75
        },
        HitSounds = {
            Hit = {
                SoundId = 14255013145,
                Volume = 1
            }
        },
        HitRemotes = { v2 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 21, 23, "Attack" }, { 25, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 18, 20, "Attack" }, { 23, "End" } },
        Stun = {
            Time = 1
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 25, 27, "Attack" }, { 40, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 14255013727,
                Volume = 1
            }
        },
        HitRemotes = { v3 }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p4, p5) -- Line: 129, Name: PreAnim
            -- upvalues: EnableTrail (copy)
            local _ = p4.Player;
            local Character = p4.Character;
            local _ = p4.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            local _ = Character.Stand;
            local Count = p5.MoveState.Count;

            if Count == 1 then
                EnableTrail(Character, { "Right", true });

                return;
            end;

            if Count == 2 then
                EnableTrail(Character, { "Right", true });

                return;
            end;

            if Count == 3 then
                EnableTrail(Character, { "Left", true });

                return;
            end;

            if Count == 4 then
                EnableTrail(Character, { "Left", true });
            end;
        end,

        PostAnim = function(p6, p7) -- Line: 150, Name: PostAnim
            -- upvalues: EnableTrail (copy)
            local _ = p6.Player;
            local Character = p6.Character;
            local _ = p6.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            local _ = Character.Stand;
            EnableTrail(Character, { "Both", false });
        end
    }
};
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
v1["Supernatural Regeneration"] = {
    Active = true,
    Heal = 1,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p8) -- Line: 204, Name: Check
            return p8.Humanoid.Health < p8.Humanoid.MaxHealth;
        end
    },
    Cooldown = {
        Time = 2.5,
        AfterMove = true
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
                    Particle = Vampire["Life Drain"].HealingTick
                }
            }
        }
    }
};
v1["Throat Slice"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14255014929,
            Volume = 1
        }
    },
    HitRemotes = { v2 }
};
v1["Crushing Strike"] = {
    Active = true,
    Damage = 22.5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.45
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 14255014575,
            Volume = 1
        }
    },
    HitRemotes = { v3 }
};
v1["Skeletal Fracture"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Active = true,
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    ["First Kick"] = {
        Damage = 8,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 14255014342,
                Volume = 1
            }
        },
        HitRemotes = { v2 }
    },
    ["Second Kick"] = {
        Damage = 12,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 14255302582,
                Volume = 1
            }
        },
        HitRemotes = { v2 }
    }
};
v1["Driving Force"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.65
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 14255014852,
            Volume = 1
        }
    },
    HitRemotes = { v3 }
};
v1["Flash Freeze"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Meter = {
        RequiredLevel = 1
    },
    Cooldown = {
        Time = 22.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 20,
    Stun = {
        Time = 0.45
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Freeze"
        } },
    HitSounds = {
        Hit = {
            SoundId = 14242949897,
            Volume = 1
        }
    },
    HitAnimations = "Default",
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
                    Particle = Vampire.Freeze.FreezeHit
                }
            }
        }
    },
    Followup = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3,
            Velocity = Vector3.new(0, 15, 0)
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
                        Particle = Vampire.Freeze.Explosion
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 14391968949,
                Volume = 1
            }
        }
    }
};
v1["Space Ripper Stingy Eyes"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 2
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        RelativePart = "Head",
        Size = Vector3.new(4, 4, 60),
        Offset = CFrame.new(0, 0, -30)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.45
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 14255014125,
            Volume = 1
        }
    },
    HitRemotes = { v3 }
};
v1["Piercing Glare"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5, 5, 15),
        Offset = CFrame.new(0, 0, -7)
    },
    Stun = {
        Time = 1.25
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    HitRemotes = { v3 }
};
v1["Shadow Step"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    }
};
v1["Life Drain"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 0.85
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    HitAnimations = "Default",
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
                    Particle = Vampire["Life Drain"].Hit
                }
            }
        }
    },
    Drain = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Lifesteal = {
            Type = "Flat",
            Amount = 8.5
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
                        Particle = Vampire["Life Drain"].BloodTick
                    }
                }
            }
        }
    },
    Throw = {
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5
        }
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};

return {
    Stats = v1,
    Animations = {
        Action = {
            ["LMB-1"] = 14240808143,
            ["LMB-2"] = 14240826244,
            ["LMB-3"] = 14240841237,
            ["LMB-4"] = 14240857749,
            ["Supernatural Regeneration"] = 14181919108,
            ["Supernatural Regeneration Loop"] = 14181921902,
            ["Throat Slice"] = 14181608418,
            ["Crushing Strike"] = 14181602583,
            ["Skeletal Fracture"] = 14181618499,
            ["Driving Force"] = 14181929084,
            ["Flash Freeze"] = 14181652402,
            ["Flash Freeze Followup"] = 14181664244,
            ["Flash Freeze Victim"] = 14181666498,
            ["Space Ripper Stingy Eyes Startup"] = 14181677801,
            ["Space Ripper Stingy Eyes"] = 14181685586,
            ["Piercing Glare"] = 14181697598,
            ["Shadow Step"] = 14181873778,
            ["Life Drain"] = 14181990737,
            ["Life Drain Followup"] = 14181912031,
            ["Life Drain Victim"] = 14181914457,
            PoseTransition = 14264362441,
            PoseIdle = 14264363820,
            ["Transformation Camera"] = 14392141390,
            ["Vampire Transformation"] = 14392143436
        },
        Movement = {
            Walk = 14331609856,
            Run = 14331606363
        },
        Idle = {
            Idle = 14182505619
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 14255013038,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14255013310,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14255012565,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14255013227,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14255012455,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 14255012946,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14255012159,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14255012832,
            Volume = 1
        },
        ["Supernatural Regeneration Voiceline"] = {
            SoundId = 14255013395,
            Volume = 1
        },
        ["Supernatural Regeneration SFX"] = {
            SoundId = 14255013487,
            Looped = true,
            Volume = 1
        },
        ["Throat Slice Voiceline"] = {
            SoundId = 14255014752,
            Volume = 1
        },
        ["Throat Slice SFX"] = {
            SoundId = 14255015002,
            Volume = 1
        },
        ["Crushing Strike Voiceline"] = {
            SoundId = 14255014469,
            Volume = 1
        },
        ["Crushing Strike SFX"] = {
            SoundId = 14255014668,
            Volume = 1
        },
        ["Skeletal Fracture Voiceline"] = {
            SoundId = 14255014022,
            Volume = 1
        },
        ["Skeletal Fracture SFX"] = {
            SoundId = 14255410380,
            Volume = 1
        },
        ["Driving Force Voiceline"] = {
            SoundId = 14255015195,
            Volume = 1
        },
        ["Driving Force SFX"] = {
            SoundId = 14255015084,
            Volume = 1
        },
        ["Flash Freeze Voiceline"] = {
            SoundId = 14242949340,
            Volume = 1
        },
        ["Flash Freeze SFX"] = {
            SoundId = 14242949447,
            Volume = 1
        },
        ["Flash Freeze Success Voiceline"] = {
            SoundId = 14391968825,
            Volume = 1
        },
        ["Flash Freeze Success SFX"] = {
            SoundId = 14391969093,
            Volume = 1
        },
        ["Space Ripper Stingy Eyes Voiceline"] = {
            SoundId = 14255013614,
            Volume = 1
        },
        ["Space Ripper Stingy Eyes SFX"] = {
            SoundId = 14255013824,
            Volume = 1
        },
        ["Piercing Glare Voiceline"] = {
            SoundId = 14242949789,
            Volume = 1
        },
        ["Piercing Glare SFX"] = {
            SoundId = 14242949677,
            Volume = 1
        },
        ["Life Drain Voiceline"] = {
            SoundId = 14242949165,
            Volume = 1
        },
        ["Life Drain SFX"] = {
            SoundId = 14242949268,
            Volume = 1
        },
        ["Life Drain Success Voiceline"] = {
            SoundId = 14242949037,
            Volume = 1
        },
        ["Life Drain Success SFX"] = {
            SoundId = 14242949572,
            Volume = 1
        },
        ["Shadow Step SFX"] = {
            SoundId = 14255541295,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 14969465632,
            Volume = 3,
            Looped = true,
            PlaybackRegionsEnabled = true,
            LoopRegion = NumberRange.new(12.023, 600000)
        }
    },
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
            ["Supernatural Regeneration"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Heal yourself up in exchange for meter."
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
            ["Throat Slice"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Perform a quick jab while slicing the targets throat in the process."
            },
            ["Crushing Strike"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Unleash a strong blow, knocking away any target hit by it."
            },
            ["Skeletal Fracture"] = {
                DefaultKeybind = "T",
                Description = "Perform two swift dashes forward while striking the target in the process.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Driving Force"] = {
                DefaultKeybind = "Y",
                Description = "Perform a quick spinning punch, knocking the target away.",
                LevelRequirement = 20,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Flash Freeze"] = {
                DefaultKeybind = "G",
                Description = "Grab the target to freeze them in place. Recasting the move again while the target is being frozen triggers a finisher.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Space Ripper Stingy Eyes"] = {
                DefaultKeybind = "U",
                Description = "Unleash two beams out of your eyes, piercing anyone that comes in contact with the beam.",
                LevelRequirement = 105,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Piercing Glare"] = {
                DefaultKeybind = "H",
                Description = "Glare at your target, leaving them to be immobilized for a short time.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Shadow Step"] = {
                DefaultKeybind = "V",
                Description = "You briefly vanish for a split second while also moving forward in the process.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Life Drain"] = {
                DefaultKeybind = "B",
                Description = "Swiftly pierce the targets body to drain their blood, giving you health in return.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
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
                    SoundId = "rbxassetid://14969464216",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I, Dio, have no need for you anymore."
                        } }
                }, {
                    SoundId = "rbxassetid://14969465758",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Immortality, power... I will rule the world!"
                        } }
                }, {
                    SoundId = "rbxassetid://14969465343",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "How weak! You think you can beat ME, you idiot?"
                        } }
                }, {
                    SoundId = "rbxassetid://14969464091",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Can a monkey like you keep up? Compared to me, Dio, you are but a mere monkey!"
                        } }
                } }
        }
    }
};