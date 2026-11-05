  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
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
            Color = Color3.fromRGB(255, 255, 0)
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
            Color = Color3.fromRGB(255, 255, 0)
        }
    }
};
v1.Summon = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart", "StandOffKatana" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.425,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = { v2 },
        HitSounds = {
            Hit = {
                SoundId = 13318990117,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Damage = 25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13318991755,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.5,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.52,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v2 },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.75,
        Cooldown = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 36, 42, "Attack" }, { 48, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13318991755,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p4, p5) -- Line: 188, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p4.Stats;

            if not Knit.CollectionService:HasTag(p4.Character, "Summoned") then
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
        PoseTransition = function(p6, p7) -- Line: 210, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p6.Character, true);
        end,

        PoseEnd = function(p8, p9) -- Line: 213, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p8.Character, false);
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
v1.Vines = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 9
    }
};
v1.Barrage = TableUtil.Reconcile({
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Hit = {
        Frequency = 6,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -5),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitRemotes = { v2 },
        HitSounds = {
            Hit = {
                SoundId = 13318993914,
                Volume = 1.5
            }
        }
    },
    Finisher = {
        Frequency = 360,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 10, 12),
            Debug = false,
            Offset = CFrame.new(0, 0, -6),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            BlockBreak = true
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13318992590,
                Volume = 1.5
            }
        }
    },
    ClashHit = {
        Frequency = 6,
        Damage = 1,
        Priority = EnumsModule.Intangible.Clash,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Stun = {
            Time = 0.1,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {},
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } }
    },
    ClashFinisher = {
        Frequency = 360,
        Damage = 15,
        Priority = EnumsModule.Intangible.Clash,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.15
        },
        Block = {
            BlockBreak = true
        }
    }
}, BaseStatsModule.Stand_Barrage);
v1["Root Stab"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Debug = false,
        Offset = CFrame.new(0, 0, -10)
    },
    Stun = {
        Time = 0.85,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 15,
        Time = 0.3,
        Velocity = Vector3.new(0, 5, 0)
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 8099073640,
            Volume = 1.5
        }
    }
};
v1["Heavy Attack"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Stun = {
        Time = 0.2,
        Priority = EnumsModule.Stun.Medium
    },
    Ragdoll = {
        Time = 0.4
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3,
        Velocity = Vector3.new(0, 0, 0)
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = true
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 6855276919,
            Volume = 5
        }
    }
};
v1["Self Heal"] = {
    Active = true,
    Heal = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 35
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 30
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "GEHeal", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 6882262715,
            Volume = 1
        }
    }
};
v1.Heal = {
    Active = true,
    Heal = 60,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(5, 5, 5),
        FriendlyFire = true,
        Debug = false,
        Offset = CFrame.new(0, 0, -5)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "GEHeal", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 6882262715,
            Volume = 1
        }
    }
};
v1.Restrain = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 15
    },
    SummonCooldown = {
        Name = "Summon",
        Time = 5,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6, 6, 6),
        Debug = false,
        Offset = CFrame.new(0, 0, -5)
    },
    Damage = 1.5,
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Unblockable = true
    },
    Kick = {
        Damage = 15,
        Meter = {
            MeterGain = 0
        },
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 8051702012,
                Volume = 1
            }
        }
    },
    Throw = {
        Damage = 10,
        Meter = {
            MeterGain = 0
        },
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3,
            Velocity = Vector3.new(0, 30, 0)
        },
        Ragdoll = {
            Time = 1.5
        }
    }
};
v1["Frog Defense"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    },
    Cooldown = {
        Time = 20
    }
};
v1["Consecutive Attacks"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 20
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Damage = 15,
    Meter = {
        RequiredAmount = 25
    },
    HitRemotes = { v3 },
    Stun = {
        Time = 0.52,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false
    },
    Hit = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v2 }
    },
    GroundHit = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Ragdoll = {
            Time = 0.7
        },
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = { v3 }
    }
};
v1["Snake Kick"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 40
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 25
    }
};
v1["Berserk Senses"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 35
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 50
    },
    Attempt = {
        CheckPVPSafe = true,
        Distance = 20,
        Duration = 0.5,
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        }
    },
    InitialPunch = {
        Damage = 17.5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v3 }
    },
    SlowMoPunch = {
        Damage = 0.25,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v2 }
    },
    Uppercut = {
        Damage = 30,
        LifePunchDuration = 7.5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 75,
            Time = 0.3,
            Velocity = Vector3.new(0, 35, 0)
        },
        HitRemotes = {
            v3,
            {
                Name = "Output",
                Arguments = { "FX", "BoxBloodParticle", "__Legacy" }
            }
        }
    }
};
v1.Tree = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "V",
        Time = 30
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.35,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3,
        Velocity = Vector3.new(0, 20, 0)
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true
    },
    HitRemotes = { v2 }
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
            Vines = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Slam the ground and summon vines that harm anyone who touches them."
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike."
            },
            ["Root Stab"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Touch the ground, causing a large root to spring forth, inflicting a powerful attack."
            },
            ["Heavy Attack"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Your stand performs a powerful kick."
            },
            ["Self Heal"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Heal yourself with the stand\'s life creation ability.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Heal = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Your stand reaches forward with its life creation and heals targets directly in front of you.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Restrain = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Your stand grabs the target, rendering them immobile and disabled for a period of time.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Frog Defense"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Summon a frog on your chest, redirecting any counterable attack onto you for a period of time.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Consecutive Attacks"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Your stand uppercuts the enemy in the air, doing a flurry of attacks before down slamming the target to the ground.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Berserk Senses"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Dash forward and grab the opponent, initializing a quick time event. If done correctly, the enemy will lose control of their body.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 8479407906,
            ["LMB-2"] = 8479409142,
            ["LMB-3"] = 8479410619,
            ["LMB-4"] = 8479412145,
            ["StandOff-LMB-1"] = 11203522877,
            ["StandOff-LMB-2"] = 11203526095,
            ["StandOff-LMB-3"] = 11203534927,
            ["StandOff-LMB-4"] = 11203540441,
            StandBlock = 10808688837,
            StandBlockHit1 = 10808692075,
            StandBlockHit2 = 10808695355,
            StandBlockHit3 = 10808697696,
            StandBlockBreak = 10808701329,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            Grab = 10906128504,
            Throw = 10906131878,
            ThrowVictim = 10906132668,
            HeavyPunch = 7189349499,
            HeavyKick = 8028012564,
            RootsStance = 7883668239,
            RootsRelease = 7883670789,
            CreateFrog = 8044771960,
            ConsAttacksUse = 7911757423,
            ConsAttackCombo = 8489433396,
            ConsAttackVictim = 8011467457,
            RestrainUse = 7923267037,
            RestrainHit = 7923271243,
            RestrainVictim = 7923273888,
            Vines = 8075486934,
            TreeSlam = 8127057861,
            ["Berserk Senses Startup"] = 8378668637,
            ["Berserk Senses Hit"] = 8378670324,
            ["Berserk Senses Camera"] = 8378666695,
            ["Berserk Senses Victim"] = 8378672813,
            TargetSleep = 8283607580,
            TargetSleeping = 8283609530,
            HealOther = 6878291078,
            SelfHeal = 8027965306,
            SnakeKick = 8052480435,
            PoseIdle = 10367143160,
            PoseTransition = 10367140898
        },
        Movement = {
            Sit = 5718978019,
            SummonedRun = 7037969480,
            SummonedWalk = 6707573199
        },
        Idle = {
            Idle = 7193377883,
            SummonedIdle = 7193350520
        }
    },
    Stats = v1,
    Sounds = {
        ["Tree Appear"] = {
            SoundId = "rbxassetid://5648739567",
            Volume = 1
        },
        ["Tree Appear 2"] = {
            SoundId = "rbxassetid://3378924410",
            Volume = 1
        },
        ["Tree Voiceline"] = {
            SoundId = "rbxassetid://6891991001",
            Volume = 2
        },
        ["7Page"] = {
            SoundId = "rbxassetid://9073487452",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://11533025771",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LowHpBarrageVoiceline = {
            SoundId = "rbxassetid://11533025629",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://11524884121",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BerserkSensesHit = {
            SoundId = "rbxassetid://13319740979",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BerserkSensesHitSFX = {
            SoundId = "rbxassetid://13319743257",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BerserkSensesUse = {
            SoundId = "rbxassetid://13319739996",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ConsecAttackHit = {
            SoundId = "rbxassetid://8051600926",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ConsecAttackUse = {
            SoundId = "rbxassetid://8051602100",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ConsecAttackUseSFX = {
            SoundId = "rbxassetid://8051601523",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://6846384151",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HealVC = {
            SoundId = "rbxassetid://6882263223",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyPunch = {
            SoundId = "rbxassetid://11765563201",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KickVoice = {
            SoundId = "rbxassetid://11765563160",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://6855317186",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://6855317584",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://6855317887",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://6855318216",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LifeCreate = {
            SoundId = "rbxassetid://6978860798",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LifeCreateSFX = {
            SoundId = "rbxassetid://6978861278",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LifeDetectBubble = {
            SoundId = "rbxassetid://7001353905",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LifeDetectRadar = {
            SoundId = "rbxassetid://7001353937",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LifeDetectWind = {
            SoundId = "rbxassetid://7001353861",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RestrainAttempt = {
            SoundId = "rbxassetid://8051674062",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RockKick = {
            SoundId = "rbxassetid://8731125088",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RockStartup = {
            SoundId = "rbxassetid://8731124474",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RootSpawnVoice = {
            SoundId = "rbxassetid://8099071966",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RootStartupVoice = {
            SoundId = "rbxassetid://8099073108",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SelfHeal = {
            SoundId = "rbxassetid://6880537673",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonEffects = {
            SoundId = "rbxassetid://6842212115",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://6842212442",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = "rbxassetid://6706981173",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Transform = {
            SoundId = "rbxassetid://7092647759",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TreeCreateSFX = {
            SoundId = "rbxassetid://6978861717",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TreeCreateVoice = {
            SoundId = "rbxassetid://6978862212",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Windup = {
            SoundId = "rbxassetid://6882261784",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://10382676531",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        StandPoseMusic = {
            SoundId = "rbxassetid://10382676531",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
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
                    SoundId = "rbxassetid://10432401101",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I, Giorno Giovanna have a dream!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://10432405205",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It\'s useless,",
                            ScaleTime = 1.45,
                            EndLag = 0
                        }, {
                            Quote = " and I hate that because it\'s useless.",
                            ScaleTime = 1.25
                        }, {
                            Quote = " Totally useless.",
                            ScaleTime = 2
                        } }
                }, {
                    SoundId = "rbxassetid://10432408351",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Looks like doing what you wanted was useless..",
                            ScaleTime = 0.9
                        }, {
                            Quote = " In the end.",
                            ScaleTime = 1.5
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p10) -- Line: 1448, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p10.Player;
            local Character = p10.Character;
            local SkinName = p10.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v11 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v11.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v11;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};