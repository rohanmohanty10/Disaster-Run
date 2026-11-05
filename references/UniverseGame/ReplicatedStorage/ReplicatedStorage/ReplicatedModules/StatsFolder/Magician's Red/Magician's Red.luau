  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v1 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};

return {
    Stats = {
        Summon = {
            From = "Combat.Summon",
            SummonV2 = true,
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(165, 80, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 133, 65)) }),
            LeaveParts = { "StandHumanoidRootPart" }
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = { { 0, "Start" }, { 25, 27, "Attack" }, { 28, "End" } },
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = {
                        SoundId = 14787330504,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 22, 24, "Attack" }, { 25, "End" } }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 20, 22, "Attack" }, { 23, "End" } }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.75,
                Sequence = { { 0, "Start" }, { 36, 38, "Attack" }, { 45, "End" } },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 14787332281,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher),
            ["StandOff-LMB-1"] = TableUtil.Reconcile({
                Endlag = 0.2,
                ActiveEndlag = 0.1,
                Speed = 1.25,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 8,
                    Time = 0.1
                },
                HitRemotes = { v1 },
                HitSounds = {}
            }, BaseStatsModule.Stand_Rush_Attack),
            ["StandOff-LMB-4"] = TableUtil.Reconcile({
                Speed = 1.85,
                Cooldown = 1,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 36, 42, "Attack" }, { 48, "End" } },
                HitRemotes = { v2 },
                HitSounds = {}
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                StateChecker = function(p3, p4) -- Line: 180, Name: StateChecker
                    -- upvalues: Knit (copy), TableUtil (copy)
                    local Stats = p3.Stats;

                    if not Knit.CollectionService:HasTag(p3.Character, "Summoned") then
                        Stats = TableUtil.Copy(Stats, true);
                        Stats.CustomPrefix = "StandOff-LMB";
                    end;

                    return Stats;
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Grab = {
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
        },
        ["Pyrokinetic Fan"] = {
            Active = true,
            Damage = 10,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 12.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 16),
                Offset = CFrame.new(0, 0, -7)
            },
            Stun = {
                Time = 1.15
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitRemotes = { v2 },
            HitSounds = {},
            Followup = {
                Damage = 25,
                Priority = Enums.Intangible.Move,
                Ragdoll = {
                    Time = 1.5
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Burn",
                        Damage = 1.5,
                        Overrides = {
                            Lifetime = 5,
                            Rate = 1
                        }
                    } },
                Stun = {
                    Time = 0.5
                },
                HitRemotes = { v2 }
            }
        },
        ["Stand Barrage"] = TableUtil.Reconcile({
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 14787332595,
                        Volume = 1
                    }
                },
                HitRemotes = { v1 }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 14787332786,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            }
        }, BaseStatsModule.Stand_Barrage),
        ["Fortuitous Dagger"] = {
            Active = true,
            Damage = 35,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Stun = {
                Time = 0.75
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 30,
                Time = 0.3
            },
            Ragdoll = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = true
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14787328612,
                    Volume = 1
                }
            }
        },
        ["Impact Strike"] = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
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
            Properties = {
                Armor = true
            },
            Stun = {
                Time = 0.75
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 40,
                Time = 0.3
            },
            Ragdoll = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = true
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Burn",
                    Damage = 1.5,
                    Overrides = {
                        Lifetime = 5,
                        Rate = 0.5
                    }
                } },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14787328824,
                    Volume = 1
                }
            }
        },
        ["Flame Exhaust"] = {
            Active = true,
            Damage = 1.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 17.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 18),
                Offset = CFrame.new(0, 0, -9)
            },
            Stun = {
                Time = 0.85
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitRemotes = { v1 },
            Finisher = {
                Stun = {
                    Time = 1.15
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 5,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 30, 0)
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = false
                },
                HitRemotes = { v2 }
            }
        },
        ["Flame Bracers"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Damage = 7.5,
            Stun = {
                Time = 1
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitRemotes = { v1 },
            HitSounds = {
                Hit = {
                    SoundId = 14787329630,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            ["Final Hit"] = {
                Damage = 10,
                Stun = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 5,
                    Time = 0.1
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = false
                },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 14787329385,
                        Volume = 1
                    }
                }
            }
        },
        ["Flare Drill"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 10),
                Offset = CFrame.new(0, 0, -4.75)
            },
            Properties = {
                Armor = true
            },
            Damage = 1.25,
            Stun = {
                Time = 0.85
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = true
            },
            HitRemotes = { v1 },
            HitSounds = {
                Hit = {
                    SoundId = 14787331701,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            Explosion = {
                Damage = 1.5,
                HitAnimations = "Default",
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(12.5, 12.5, 12.5),
                    Offset = CFrame.new(0, 0, -6.75)
                },
                Stun = {
                    Time = 1
                },
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 50,
                    Time = 0.3,
                    Velocity = Vector3.new(0, 15, 0)
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = false,
                    BlockBreak = true
                },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 14787331407,
                        Volume = 1
                    }
                }
            }
        },
        ["Seeking Flares"] = {
            Active = true,
            Damage = 1.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Stun = {
                Time = 0.45
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/Hit",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } },
            HitSounds = {
                Hit = {
                    SoundId = 14787332050,
                    Volume = 1
                }
            }
        },
        ["Red Bind"] = {
            Active = true,
            Damage = 20.5,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 14),
                Offset = CFrame.new(0, 0, -6.85)
            },
            Properties = {
                Armor = true
            },
            Stun = {
                Time = 2.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 30,
                Time = 0.3,
                Velocity = Vector3.new(0, 15, 0)
            },
            Block = {
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = true
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14787330906,
                    Volume = 1
                }
            }
        },
        ["Crossfire Hurricane"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 30,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1.5
            },
            Damage = 45,
            Stun = {
                Time = 0.5
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 50,
                Time = 0.3,
                Velocity = Vector3.new(0, 20, 0)
            },
            Block = {
                PerfectBlockable = false,
                Blockable = false,
                BlockBreak = true
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Burn",
                    Damage = 1.5,
                    Overrides = {
                        Lifetime = 5,
                        Rate = 0.5
                    }
                } },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14787329812,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            ["Fire Pit"] = {
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BlockBreak = false,
                    Unblockable = true,
                    BypassCounter = true
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Burn",
                        Damage = 1.5,
                        Overrides = {
                            Lifetime = 5,
                            Rate = 0.5
                        }
                    } }
            }
        },
        ["Crossfire Hurricane+"] = {
            Active = true,
            Damage = 15,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Priority = Enums.Intangible.Ragdoll,
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Stun = {
                Time = 0.5
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Burn",
                    Damage = 1.5,
                    Overrides = {
                        Lifetime = 5,
                        Rate = 1
                    }
                } },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 30,
                Time = 0.3
            },
            Ragdoll = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = false,
                Blockable = false,
                BlockBreak = true
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14787329812,
                    Volume = 1
                }
            }
        },
        ["Hellfire Charge"] = {
            Active = true,
            Damage = 30,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 18,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                HitboxType = "ClientHitbox",
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 0.85
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 30,
                Time = 0.3
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Burn",
                    Damage = 1.5,
                    Overrides = {
                        Lifetime = 5,
                        Rate = 0.5
                    }
                } },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14787332680,
                    Volume = 1
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 14556071830,
            ["LMB-2"] = 14556119994,
            ["LMB-3"] = 14556133858,
            ["LMB-4"] = 14556138958,
            BarrageStartup = 14559675296,
            Barrage = 14559676130,
            BarrageFinisher = 14559677108,
            ["Pyrokinetic Fan"] = 14691832051,
            ["Pyrokinetic Fan Success"] = 14691830586,
            ["Pyrokinetic Fan Victim"] = 14720946765,
            ["Impact Strike"] = 14556403001,
            ["Fortuitous Dagger"] = 14640225302,
            ["Flame Exhaust"] = 14640276663,
            ["Flame Bracers"] = 14556547358,
            ["Flare Drill"] = 14557235408,
            ["Seeking Flares"] = 14713469996,
            ["Red Bind"] = 14559794145,
            ["Red Bind Victim"] = 14640274557,
            ["Red Bind Victim Looped"] = 14795538149,
            ["Crossfire Hurricane"] = 14559791260,
            ["Hellfire Charge"] = 14559108165,
            PoseIdle = 14875769342,
            PoseTransition = 14875770152
        },
        Movement = {
            Walk = 14569929116,
            Run = 14569931876,
            SummonedWalk = 14569929116,
            SummonedRun = 14569931876
        },
        Idle = {
            Idle = 14752320977,
            SummonedIdle = 14526334977
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 14787328314,
            Volume = 1
        },
        SummonSound = {
            SoundId = 14787329250,
            Volume = 1
        },
        Desummon = {
            SoundId = 14787329113,
            Volume = 1
        },
        DesummonVoiceline = {
            SoundId = 14787329008,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 14787327424,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14787327799,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14787327424,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14787328169,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14787327424,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 14787327623,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14787327326,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14787327511,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 14787332402,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 14787332512,
            Volume = 1.25
        },
        ["Pyrokinetic Fan SFX"] = {
            SoundId = 14787330094,
            Volume = 1
        },
        ["Pyrokinetic Fan Voiceline"] = {
            SoundId = 14787330264,
            Volume = 1
        },
        ["Pyrokinetic Fan Success SFX"] = {
            SoundId = 14787330364,
            Volume = 1
        },
        ["Fortuitous Dagger SFX"] = {
            SoundId = 14787328044,
            Volume = 1
        },
        ["Fortuitous Dagger Voiceline"] = {
            SoundId = 14787327168,
            Volume = 1
        },
        ["Impact Strike SFX"] = {
            SoundId = 14787328733,
            Volume = 1
        },
        ["Impact Strike Voiceline"] = {
            SoundId = 14787328912,
            Volume = 1
        },
        ["Flame Exhaust SFX"] = {
            SoundId = 14787328514,
            Volume = 1
        },
        ["Flame Exhaust Voiceline"] = {
            SoundId = 14787327932,
            Volume = 1
        },
        ["Flame Bracers SFX"] = {
            SoundId = 14787329727,
            Volume = 1
        },
        ["Flame Bracers Voiceline"] = {
            SoundId = 14787329510,
            Volume = 1
        },
        ["Flare Drill SFX"] = {
            SoundId = 14787331851,
            Volume = 1
        },
        ["Flare Drill Voiceline"] = {
            SoundId = 14787331556,
            Volume = 1
        },
        ["Seeking Flares SFX"] = {
            SoundId = 14787332135,
            Volume = 1
        },
        ["Seeking Flares Voiceline"] = {
            SoundId = 14787481131,
            Volume = 1
        },
        ["Red Bind SFX"] = {
            SoundId = 14787331006,
            Volume = 1
        },
        ["Red Bind Voiceline"] = {
            SoundId = 14787331226,
            Volume = 1
        },
        ["Crossfire Hurricane SFX"] = {
            SoundId = 14793725267,
            Volume = 1
        },
        ["Crossfire Hurricane Voiceline"] = {
            SoundId = 14793725699,
            Volume = 1
        },
        ["Crossfire Hurricane+ SFX"] = {
            SoundId = 14787329928,
            Volume = 1
        },
        ["Crossfire Hurricane+ Voiceline"] = {
            SoundId = 14787330031,
            Volume = 1
        },
        ["Hellfire Charge SFX"] = {
            SoundId = 14787330203,
            Volume = 1
        },
        ["Hellfire Charge Voiceline"] = {
            SoundId = 14787330664,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 14875779909,
            Volume = 1,
            Looped = true
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
                    SoundId = "rbxassetid://14875788072",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "YES! I AM!"
                        } }
                }, {
                    SoundId = "rbxassetid://14875788209",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re going straight to hell... HELL 2 U!"
                        } }
                }, {
                    SoundId = "rbxassetid://14875788314",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Listen closely. You will not return in one piece."
                        } }
                } }
        }
    },
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
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
            Summon = {
                DefaultKeybind = "Q",
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
            ["Pyrokinetic Fan"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "The stand is quickly summoned while performing two strikes, if any one of them hits someone, the target is pulled back."
            },
            ["Stand Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike."
            },
            ["Fortuitous Dagger"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Bring out a dagger and then throw it foward."
            },
            ["Impact Strike"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand quickly kicks."
            },
            ["Flame Exhaust"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "The stand is quickly summoned while rapidly spitting out fire.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Flame Bracers"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "The stand performs a quick combo of attacks before finishing with a strong strike.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Flare Drill"] = {
                DefaultKeybind = "T+",
                State = "StandOn",
                Description = "The stand extends it\'s arm forward as it charges it before unleashing an explosion around the arm.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Seeking Flares"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "The stand is quickly summoned as it sends out multiples flares which ugo-target someone.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Red Bind"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "The stand unleashes a charged up strike, chaining a target hit with fire.",
                LevelRequirement = 85,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Crossfire Hurricane"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "The stand sends out a cross, upon impact with a target, it will explode, unleashing an active area of effect where it exploded.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Crossfire Hurricane+"] = {
                DefaultKeybind = "G+",
                State = "StandOn",
                LevelRequirement = 115,
                Description = "The stand sends out three crosses going in different directions, piercing through a target.",
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Hellfire Charge"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                LevelRequirement = 35,
                Description = "Dash forward, attacking anyone in your way.",
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            }
        }
    },
    Metadata = {
        BarrageColors = { Color3.fromRGB(165, 80, 80), Color3.fromRGB(218, 133, 65) }
    }
};