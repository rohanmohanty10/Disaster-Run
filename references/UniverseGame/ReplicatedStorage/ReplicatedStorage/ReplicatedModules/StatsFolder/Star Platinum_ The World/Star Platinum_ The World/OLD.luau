  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local v2 = { {
        Name = "Output",
        Arguments = { "FX", "Box Emit Particle", "__Legacy" }
    } };
local v3 = {
    EmitType = "Enabled",
    EmitDuration = 0.2,
    Particle = ClientAssets["Crazy Diamond"].BarrageEffect.Attachment
};
local v4 = {
    EmitType = "Enabled",
    EmitDuration = 0.2,
    Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect.Attachment
};
v1.Summon = {
    From = "Combat.Summon",
    Active = true,
    IgnoreParts = { "StandHumanoidRootPart" },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = { { 0, "Start" }, { 15, 20, "Attack" }, { 25, "End" } },
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = v2,
        HitData = v3,
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = { { 0, "Start" }, { 15, 20, "Attack" }, { 25, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = v2,
        HitData = v4,
        HitSounds = {
            Hit = {
                SoundId = 14343735168,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = v2,
        HitData = v3,
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.75,
        Cooldown = 0.75,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 36, 42, "Attack" }, { 48, "End" } },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = v2,
        HitData = v4,
        HitSounds = {
            Hit = {
                SoundId = 11713885288,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p5, p6) -- Line: 187, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p5.Stats;

            if not Knit.CollectionService:HasTag(p5.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
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
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p7, p8) -- Line: 209, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p7.Character, true);
        end,

        PoseEnd = function(p9, p10) -- Line: 212, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p9.Character, false);
        end
    }
};
v1.Grab = {
    From = "Combat.Grab",
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
v1.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Hit = {
        HitRemotes = v2,
        HitData = v3,
        HitSounds = {
            Hit = {
                SoundId = 6753788004,
                Volume = 0.85
            }
        }
    },
    Finisher = {
        HitRemotes = v2,
        HitData = v4,
        HitSounds = {
            Hit = {
                SoundId = 14343735476,
                Volume = 1.5
            }
        }
    },
    ClashHit = {},
    ClashFinisher = {}
}, BaseStatsModule.Stand_Barrage);
v1.Jab = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        HitboxType = "ClientHitbox",
        Offset = CFrame.identity
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 0.3
    },
    Ragdoll = {
        Time = 0.6
    },
    Block = {
        PerfectBlockable = false
    },
    HitRemotes = v2,
    HitSounds = {
        Hit = {
            SoundId = 14343736518,
            Volume = 1.5
        }
    },
    HitData = v3
};
v1["Chin Crusher"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 65,
        Time = 0.3
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = v2,
    HitData = v4,
    HitSounds = {
        Hit = {
            SoundId = 14343737348,
            Volume = 0.5
        }
    }
};
v1["Bearing Shot"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Ragdoll = {
        Time = 0.45
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    HitRemotes = v2,
    HitData = v4,
    HitSounds = {
        Hit = {
            SoundId = 6773836020,
            Volume = 2
        }
    }
};
v1["Arm Crush"] = {
    Active = true,
    Cooldown = 10,
    Damage = 25,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 1.5,
        Priority = EnumsModule.Stun.Medium
    },
    HitAnimations = { 6772530816 },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = v2,
    HitData = v4,
    HitSounds = {
        Hit = {
            SoundId = 14343736313,
            Volume = 2
        }
    }
};
v1["Liver Shot"] = {
    Active = true,
    Cooldown = 10,
    Damage = 25,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Block = {
        PerfectBlockable = true
    },
    Stun = {
        Time = 1.5,
        Priority = EnumsModule.Stun.Medium
    },
    HitAnimations = { 10046328617 },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = v2,
    HitData = v4,
    HitSounds = {
        Hit = {
            SoundId = 14343736837,
            Volume = 1
        }
    },
    Meter = {
        RequiredLevel = 1
    }
};
v1["Ground Slam"] = {
    Active = true,
    Damage = 37.5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.new(0, 0, -7)
    },
    Block = {
        BlockBreak = true
    },
    Stun = {
        Time = 0.5
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 35,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 0.75
    },
    HitSounds = {
        Hit = {
            SoundId = 10627143930,
            Volme = 3
        }
    },
    HitRemotes = v2,
    HitData = v4
};
v1.Beatdown = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 3
    },
    Grab = {
        Damage = 5,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            IgnoreNPCS = true,
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Unblockable = true
        }
    },
    Hit = {
        Damage = 1.5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 7243326637,
                Volme = 1
            }
        },
        HitRemotes = v2,
        HitData = v3
    },
    Throw = {
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 35, 0),
                Speed = 85,
                Time = 0.3
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.3
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 7243326637,
                Volme = 5
            }
        }
    }
};
v1.Resolve = {
    Active = true,
    Heal = 30,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v1.Drink = {
    Active = true,
    Heal = 25,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Meter = {
        RequiredLevel = 1
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    }
};
v1.Timestop = {
    Active = true,
    Speed = 1.5,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true,
        CanTimestop = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "PlaySound", "TSVoice" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 54, "Timestop" }, { 95, "End" } },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 3,
        Size = 150,
        StopSounds = { "TSSFX" },
        ResumeSounds = { "Timestop End SFX", "Timestop End Voiceline" }
    }
};
v1.Teleport = {
    From = "Combat.Teleport"
};
v1["Timestop Movement"] = {
    From = "Combat.Timestop Movement"
};

return {
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
            Jab = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Quickly dash forward to perform an uppercut to the target, causing them to be knocked back."
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike."
            },
            ["Chin Crusher"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Swiftly deliver a low blow to your target while knocking them back in the process."
            },
            ["Bearing Shot"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Quickly shoot out a steel bearing at your target.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Arm Crush"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Instantly teleport behind your target to crush their arms.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Liver Shot"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Perform a quick low blow to the liver, causing the target to be incapacitated for a split second.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Drink = {
                DefaultKeybind = "B",
                Description = "Pull out a drink to heal yourself up.",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Ground Slam"] = {
                DefaultKeybind = "G",
                State = "Universal",
                Description = "Slam the ground knocking back anyone hit within it.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Beatdown = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Grab the target to deliver a devastating cutscene beatdown on them.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "Z",
                State = "StandOn",
                Description = "Briefly stop time in a radius.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Resolve = {
                DefaultKeybind = "J",
                State = "StandOn",
                Description = "Enter an enraged state causing your moves to be stronger for a short period of time.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleports you a short distance.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "K",
                Description = "Gives you the ability to move during a timestop.",
                LevelRequirement = 80
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 11371980872,
            ["StandOff-LMB-2"] = 11371981731,
            ["StandOff-LMB-3"] = 11371982707,
            ["StandOff-LMB-4"] = 11371983463,
            StandBlock = 10808688837,
            StandBlockHit1 = 10808692075,
            StandBlockHit2 = 10808695355,
            StandBlockHit3 = 10808697696,
            StandBlockBreak = 10808701329,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            AttackPoseTransition = 6568465045,
            AttackPoseLooped = 6568461661,
            Timestop = 6590354245,
            HeavyPunch = 6663831578,
            GroundSlam = 6647782995,
            ArmCrush = 6768572898,
            ArmCrushVictim = 6772530816,
            Drink = 6473199424,
            Bearing = 6736397929,
            JabDash = 6589691798,
            Jab = 6773671645,
            BeatdownUser = 6718445417,
            BeatdownVictim = 6718397667,
            Crush = 6768572898,
            Resolve = 7405890993,
            ChinCrusher = 10517708934,
            LiverShot = 10518423859,
            BeatdownPunch = 10446639889,
            BurstTimestop = 10518646803,
            PoseIdle = 6582571947,
            PoseTransition = 6582573647
        },
        Movement = {
            Walk = 7386804902,
            Run = 88267173546743,
            SummonedWalk = 7386804902,
            SummonedRun = 88267173546743
        },
        Idle = {
            Idle = 6645554296,
            SummonedIdle = 7176811862
        }
    },
    Stats = v1,
    Sounds = {
        Teleport = {
            SoundId = 6773724319,
            Volume = 1
        },
        Resolve = {
            SoundId = "rbxassetid://14343735831",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ResolveVC = {
            SoundId = "rbxassetid://14343735732",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Themeee = {
            SoundId = "rbxassetid://10523807185",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 138
        },
        AlternateSummon = {
            SoundId = "rbxassetid://5965069559",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        AlternateSummon2 = {
            SoundId = "rbxassetid://6706982465",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://14343736781",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0.5
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://14343736713",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BearingShot = {
            SoundId = "rbxassetid://14343737009",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CanOpen = {
            SoundId = "rbxassetid://6470651681",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CrushOra = {
            SoundId = "rbxassetid://14343736392",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CrushOraVoiceline = {
            SoundId = "rbxassetid://14343736636",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Dash = {
            SoundId = "rbxassetid://6589909825",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://14343735265",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Drink = {
            SoundId = "rbxassetid://3637899507",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DrinkVoiceline = {
            SoundId = "rbxassetid://6470652524",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FloorHitSFX = {
            SoundId = "rbxassetid://14343736214",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FloorHitScream = {
            SoundId = "rbxassetid://6630438404",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FloorHitScream2 = {
            SoundId = "rbxassetid://14343736070",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        He = {
            SoundId = "rbxassetid://6863633231",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HealSound = {
            SoundId = "rbxassetid://6474876847",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Chin Crusher"] = {
            SoundId = "rbxassetid://14343737424",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Chin Crusher Voiceline"] = {
            SoundId = "rbxassetid://14343737248",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyPunch = {
            SoundId = "rbxassetid://6541267000",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KickBarrage = {
            SoundId = "rbxassetid://6717176745",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://14343734839",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://14343734642",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://6579757792",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://14343734506",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MusicBD = {
            SoundId = "rbxassetid://5585275063",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LiverShot = {
            SoundId = "rbxassetid://14343736928",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LiverShotVoiceline = {
            SoundId = "rbxassetid://14343737089",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://9073500457",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Quickjab = {
            SoundId = "rbxassetid://14343737560",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        QuickjabVoiceline = {
            SoundId = "rbxassetid://14343737489",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["SPTW Beatdown"] = {
            SoundId = "rbxassetid://14343735971",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["SPTW Beatdown Voiceline"] = {
            SoundId = "rbxassetid://14343735649",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["SPTW Heavy"] = {
            SoundId = "rbxassetid://6541267000",
            Volume = 0.699999988079071,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonEffects = {
            SoundId = "rbxassetid://14343735319",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://14343734745",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = "rbxassetid://6706981173",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSEndSFX = {
            SoundId = "rbxassetid://6575421609",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSSFX = {
            SoundId = "rbxassetid://14343735390",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSVoice = {
            SoundId = "rbxassetid://14343735072",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        AlternateCall = {
            SoundId = "rbxassetid://14343737009",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            },
            Resolve = {
                Visible = false
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://6934117767",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Next time we meet, I\'m gonna land a thousand punches on that face of yours."
                        } }
                }, {
                    SoundId = "rbxassetid://6574934472",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Good Grief...Hmph"
                        } }
                }, {
                    SoundId = "rbxassetid://6934118392",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Better give up."
                        } }
                }, {
                    SoundId = "rbxassetid://6934118107",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m sick and tired of hearing that things are *impossible* or *futile*."
                        } }
                } },
            Resolve = { {
                    SoundId = "",
                    SoundVolume = 2,
                    Visible = true,
                    FullQuote = { {
                            Quote = "No one could stay calm...",
                            EraseQuote = true
                        }, {
                            Quote = "After seeing something like that!"
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p11) -- Line: 1414, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p11.Player;
            local Character = p11.Character;
            local SkinName = p11.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v12 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v12.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v12;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};