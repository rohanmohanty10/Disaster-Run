  

 

local CollectionService = game:GetService("CollectionService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Trove = require(Knit.Util.Trove);
local EnumsModule = require(PathShortcuts.EnumsModule);
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
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/HeavyErasure",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v4 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Attacker",
            Path = "Particles/BloodLight",
            AutoSerialize = true,
            PartName = "HumanoidRootPart",
            Offset = CFrame.new(0, -2.5, -3.5)
        }
    }
};
local v5 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Attacker",
            Path = "Particles/BloodHeavy",
            AutoSerialize = true,
            PartName = "HumanoidRootPart",
            Offset = CFrame.new(0, -2.5, -3.5)
        }
    }
};
local v6 = {
    SoundId = 13745077037,
    Volume = 1.5
};
local v7 = {
    SoundId = 13745077170,
    Volume = 1.5
};

return {
    Stats = {
        Summon = {
            From = "Combat.Summon",
            SummonV2 = true,
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(74, 165, 227)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 216, 247)) }),
            LeaveParts = { "StandHumanoidRootPart" }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = false
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
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            AnimationTimed = false,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = v6
                }
            }, BaseStatsModule.Stand_Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v7
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher),
            ["StandOff-LMB-1"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = v6
                }
            }, BaseStatsModule.Rush_Attack),
            ["StandOff-LMB-4"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v7
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                StateChecker = function(p8, p9) -- Line: 251, Name: StateChecker
                    -- upvalues: CollectionService (copy), TableUtil (copy)
                    local Stats = p8.Stats;

                    if not CollectionService:HasTag(p8.Character, "Summoned") then
                        Stats = TableUtil.Copy(Stats, true);
                        Stats.CustomPrefix = "StandOff-LMB";
                    end;

                    return Stats;
                end
            }
        },
        Punch = {
            Active = true,
            Damage = 25,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = false
            },
            Cooldown = {
                Time = 8.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 6, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                BlockBreak = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 55,
                Time = 0.15
            },
            HitSounds = {
                Hit = {
                    SoundId = 14695218907,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        ["Power Crusher"] = {
            Frequency = 25,
            Active = true,
            Damage = 5,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Stun = {
                Time = 0.8
            },
            HitSounds = {
                Hit = {
                    SoundId = 14695218793,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        ["Vertical Swipe"] = {
            Active = true,
            Damage = 25,
            Animations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 25,
                Time = 0.15
            },
            HitSounds = {
                Hit = {
                    SoundId = 14695219330,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        ["Lights Out"] = {
            Active = true,
            Damage = 30,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Properties = {
                Armor = true
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                BlockBreak = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 55,
                Time = 0.15
            },
            HitSounds = {
                Hit = {
                    SoundId = 14693886191,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        Shakedown = {
            Actionable = {
                Active = true
            },
            Active = true,
            CheckPVPSafe = true,
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 6, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true
            },
            HitSounds = {
                Hit = v6
            },
            HitRemotes = { v1 },
            Hit = {
                Damage = 40,
                Priority = EnumsModule.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 55,
                    Time = 0.15
                },
                HitSounds = {
                    Hit = {
                        SoundId = 14695219514,
                        Volume = 2
                    }
                },
                HitRemotes = { v2 }
            }
        },
        ["Blunt Strike"] = {
            Active = true,
            Damage = 10,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 11,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                BlockBreak = true
            },
            Meter = {
                RequiredAmount = 0
            },
            Stun = {
                Time = 1
            },
            HitSounds = {
                Hit = {
                    SoundId = 14693886324,
                    Volume = 2
                }
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/ChopHit",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } }
        },
        ["Quick Swipe"] = {
            Active = true,
            Damage = 5,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 13,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(20, 15, 30),
                Offset = CFrame.new(0, -2.5, -15)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 14693887083,
                    Volume = 2
                }
            },
            Stun = {
                Time = 1
            },
            Knockback = {
                Speed = 15,
                Time = 0.1
            },
            Proximity = {
                Damage = 25,
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(9, 7, 6),
                    Offset = CFrame.new(0, 0, -3.5)
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitSounds = {
                    Hit = {
                        SoundId = 14693887736,
                        Volume = 2
                    }
                },
                HitRemotes = { v3 }
            }
        },
        ["Erasure Teleportation"] = {
            Active = true,
            Damage = 35,
            TrueDamage = true,
            Uses = 2,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 8, 8),
                Offset = CFrame.new(0, -1, -4)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 14693887736,
                    Volume = 2
                }
            },
            HitRemotes = { v3 }
        },
        ["The Hand"] = {
            Active = true,
            Damage = 45,
            TrueDamage = true,
            IgnoreLoveTrain = true,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 2
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            Stun = {
                Time = 1
            },
            HitSounds = {
                Hit = {
                    SoundId = 14693887736,
                    Volume = 2
                }
            },
            HitRemotes = { v3 }
        },
        ["Crumpling Blow"] = {
            Active = true,
            Damage = 35,
            Animations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 13,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                BlockBreak = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 55,
                Time = 0.15
            },
            HitSounds = {
                Hit = {
                    SoundId = 14693887542,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        ["The Foot"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Active = true,
            Cooldown = {
                Time = 45,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 75
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                PerfectBlockable = true
            },
            Damage = 5,
            MinHealth = 1,
            HitRemotes = { v1 },
            Hit = {
                MinHealth = 1,
                Damage = 2,
                Priority = EnumsModule.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v4 }
            },
            Stomp = {
                MinHealth = 1,
                Damage = 20,
                Priority = EnumsModule.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v5 }
            },
            Kick = {
                MinHealth = 1,
                Damage = 15,
                Priority = EnumsModule.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v1 }
            },
            Finisher = {
                Damage = 20,
                Priority = EnumsModule.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 65,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 15, 0)
                },
                HitRemotes = { v2 }
            }
        },
        Timestop = {
            Active = true,
            Actionable = {
                Active = true,
                Summoned = true,
                CanTimestop = true
            },
            Cooldown = {
                Time = 30,
                AfterMove = true
            },
            Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "PlaySound", "Timestop Startup" }, { 0, "PlaySound", "Timestop Startup Voiceline" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 53, "Timestop" }, { 72, "End" } },
            Meter = {
                RequiredLevel = 2,
                RemoveMeter = false
            },
            Timestop = {
                Time = 6.5,
                Size = 100,
                StopSounds = { "Timestop SFX" },
                ResumeSounds = { "Timestop End SFX", "Timestop End Voiceline" }
            }
        },
        ["Timestop Movement"] = {
            Time = 3.5,
            Actionable = {
                Timestopped = false
            },
            Meter = {
                RequiredLevel = 1,
                RemoveMeter = false
            }
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
            },
            Unlock = {
                Show = false,
                Visible = false,
                Priority = 4
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
            Punch = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Perform a simple punch."
            },
            ["Power Crusher"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand performs multiple swipes, holding this move will allow it to continue performing swipes."
            },
            ["Vertical Swipe"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "The stand temporarily comes out as it performs a quick jab."
            },
            ["Lights Out"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand performs a quick strike, blinding the victim."
            },
            Shakedown = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Grab someone and then punch them away.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Blunt Strike"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "The stand performs a very quick jab.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Quick Swipe"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "The stand performs a swipe pulling and damaging nearby targets.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["The Hand"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "The stand charges up before performing a strong swipe, erasing out the limbs of a victim. Executes non-boss targets below 10% HP",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["The Foot"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Grab a target before crushing them with a devastating beatdown.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Crumpling Blow"] = {
                DefaultKeybind = "B",
                State = "StandOn",
                Description = "The stand performs a kick using both legs very swiftly.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Erasure Teleportation"] = {
                DefaultKeybind = "V",
                State = "StandOn",
                Description = "The stand quickly swipes the air in-front before launching up the sky. If recasted, you\'ll perform another dash. This move can damage nearby enemies.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "U",
                State = "Unlock",
                Description = "LOOK JOSUKE I STOPPED TIME WITH MY THE HAND ISN\'T THAT WACKY?!",
                Unlocked = true
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "U+",
                State = "Unlock",
                Unlocked = true
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            Punch = 14288172810,
            ["Power Crusher"] = 11639127011,
            ["Vertical Swipe"] = 14288329819,
            ["Lights Out"] = 13761847748,
            ["Blunt Strike"] = 13761903416,
            ["Quick Swipe"] = 13761999608,
            ["The Hand"] = 13762351145,
            ["Crumpling Blow"] = 13762484801,
            Shakedown = 14288409818,
            ["Shakedown Success"] = 14288415467,
            ["Shakedown Target"] = 14288421322,
            ["The Foot"] = 13754169592,
            ["The Foot Success"] = 13754560684,
            ["The Foot Target"] = 13755101985,
            ["The Foot Camera"] = 13754548090,
            Timestop = 87491471107319,
            PoseIdle = 14629786029,
            PoseTransition = 14629784601
        },
        Movement = {
            SummonedWalk = 11544799120,
            SummonedRun = 11544797506,
            Walk = 11544799120,
            Run = 11544797506,
            FallSecondary = 14607619417
        },
        Idle = {
            SummonedIdle = 11544786240,
            Idle = 11544786240
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 13744978242,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 13744978311,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 13744978368,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 13745077313,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13745076954,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13745076889,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13745077255,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13745077313,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13745076954,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13745076889,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13745077255,
            Volume = 1
        },
        ["SwingLMB 1-3"] = {
            SoundId = 13745077207,
            Volume = 1
        },
        ["SwingLMB 4"] = {
            SoundId = 13745077106,
            Volume = 1
        },
        Punch = {
            SoundId = 14695219113,
            Volume = 1
        },
        ["Punch Voiceline"] = {
            SoundId = 14695219207,
            Volume = 1
        },
        ["Vertical Swipe"] = {
            SoundId = 14695219417,
            Volume = 1
        },
        ["Vertical Swipe Voiceline"] = {
            SoundId = 14695219973,
            Volume = 1
        },
        Shakedown = {
            SoundId = 14695219628,
            Volume = 1
        },
        ["Shakedown Success"] = {
            SoundId = 14695219855,
            Volume = 1
        },
        ["Shakedown Success Voiceline"] = {
            SoundId = 14695219708,
            Volume = 1
        },
        ["Power Crusher Voiceline"] = {
            SoundId = 14693886438,
            Volume = 1.5
        },
        ["Power Crusher"] = {
            SoundId = 14693886685,
            Volume = 1.5
        },
        ["Blunt Strike"] = {
            SoundId = 14693886098,
            Volume = 1.5
        },
        ["Blunt Strike Voiceline"] = {
            SoundId = 14693886532,
            Volume = 1.5
        },
        ["Lights Out"] = {
            SoundId = 14693886834,
            Volume = 1.5
        },
        ["Lights Out Voiceline"] = {
            SoundId = 14693887862,
            Volume = 1.5
        },
        ["Quick Swipe"] = {
            SoundId = 14693886933,
            Volume = 1.5
        },
        ["Quick Swipe Voiceline"] = {
            SoundId = 14693887224,
            Volume = 1.5
        },
        ["Crumpling Blow"] = {
            SoundId = 14693887400,
            Volume = 1.5
        },
        ["Crumpling Blow Voiceline"] = {
            SoundId = 14693887977,
            Volume = 1.5
        },
        ["The Hand"] = {
            SoundId = 14693887649,
            Volume = 1.5
        },
        ["The Hand Voiceline"] = {
            SoundId = 14695220197,
            Volume = 1.5
        },
        Grab = {
            SoundId = 13745242122,
            Volume = 1
        },
        Grabbed = {
            SoundId = 13745241953,
            Volume = 1
        },
        GrabbedVoiceline = {
            SoundId = 13745242045,
            Volume = 2
        },
        ["The Foot"] = {
            SoundId = 13755278372,
            Volume = 2
        },
        ["Erasure Teleportation"] = {
            SoundId = 14833544895,
            Volume = 2
        },
        ["Erasure Teleportation Voiceline"] = {
            SoundId = 14833482299,
            Volume = 2
        },
        ["The Foot Success"] = {
            SoundId = 13755278328,
            Volume = 2
        },
        ["The Foot Success Voiceline"] = {
            SoundId = 13755278519,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 14695220481,
            Volume = 2,
            PlaybackSpeed = 1.2
        },
        MeterUp4 = {
            SoundId = 14695220313,
            Volume = 2
        },
        ["Timestop SFX"] = {
            SoundId = 17269822500,
            Volume = 1.5
        },
        ["Timestop End SFX"] = {
            SoundId = 11498446637,
            Volume = 2.5
        },
        ["Timestop End Voiceline"] = {
            SoundId = 88797513208136,
            Volume = 2
        },
        ["Timestop Startup"] = {
            SoundId = 17073996336,
            Volume = 2.5
        },
        ["Timestop Startup Voiceline"] = {
            SoundId = 124009545872887,
            Volume = 2.5
        },
        PoseMusic = {
            SoundId = 14629872627,
            Volume = 1.5
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://14695218499",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m shavin\' away space! Look, I\'m comin\' closer! See that? TELEPORTATION! BOOYAH!"
                        } }
                },
                {
                    SoundId = "rbxassetid://14695218346",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "IDIOT!"
                        } }
                },
                {
                    SoundId = "rbxassetid://14695218619",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "DELICIOUS!"
                        } }
                },
                {
                    SoundId = "rbxassetid://14695219008",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Shut yer trap, you idiot!"
                        } }
                },
                {
                    SoundId = "rbxassetid://14695218708",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll smash you to pieces"
                        } }
                },
                {
                    SoundId = "rbxassetid://14695220082",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Za Hando, Za Warudo! Sorry, I just thought it might work."
                        } }
                }
            }
        }
    },
    Metadata = {
        PostRig = function(p10) -- Line: 1508, Name: PostRig
            -- upvalues: Knit (copy), Trove (copy)
            local Player = p10.Player;
            local Character = p10.Character;

            if not (game:GetService("RunService"):IsServer() and Player) then
                return;
            end;

            local u11 = Knit.GetService("MoveIndicatorService");
            local v12 = Trove.new();
            v12:AttachToInstance(Character);

            local function MoveVisiblity(p13) -- Line: 1518
                -- upvalues: u11 (copy), Player (copy)
                u11:SetStateVisible(Player, "Unlock", p13);
                u11:SetGroupVisible(Player, "Unlock", p13);
            end;

            if Player:FindFirstChild("PersonalUnlocker") then
                u11:SetStateVisible(Player, "Unlock", false);
                u11:SetGroupVisible(Player, "Unlock", false);
                task.delay(0.3, function() -- Line: 1525
                    -- upvalues: Character (copy), u11 (copy), Player (copy)
                    if not (Character and Character.Parent) then
                        return;
                    end;

                    u11:SetStateVisible(Player, "Unlock", true);
                    u11:SetGroupVisible(Player, "Unlock", true);
                end);
            end;

            v12:Connect(Player.ChildAdded, function(p14) -- Line: 1530
                -- upvalues: u11 (copy), Player (copy)
                if p14:IsA("ValueBase") and p14.Name == "PersonalUnlocker" then
                    u11:SetStateVisible(Player, "Unlock", true);
                    u11:SetGroupVisible(Player, "Unlock", true);
                end;
            end);
            v12:Connect(Player.ChildRemoved, function(p15) -- Line: 1535
                -- upvalues: u11 (copy), Player (copy)
                if p15:IsA("ValueBase") and p15.Name == "PersonalUnlocker" then
                    u11:SetStateVisible(Player, "Unlock", false);
                    u11:SetGroupVisible(Player, "Unlock", false);
                end;
            end);
        end
    }
};