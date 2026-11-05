  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage.Remotes;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local v2 = ReplicatedStorage["Client Assets"];
game:GetService("CollectionService");
game:GetService("ServerStorage");
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);
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
            Particle = v2.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(0, 170, 255)
        }
    }
};
local v4 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v2.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(0, 170, 255)
        }
    }
};
local CurrentCamera = game:GetService("Workspace").CurrentCamera;

local function GetFacing(p5, p6) -- Line: 50
    -- upvalues: CurrentCamera (copy)
    local v7 = nil;
    local v8 = nil;
    local v9 = p6 or 10;
    local HumanoidRootPart = p5:FindFirstChild("HumanoidRootPart");
    local Humanoid = p5:FindFirstChild("Humanoid");

    if HumanoidRootPart and Humanoid then
        for _, child in ipairs(workspace.Living:GetChildren()) do
            if child ~= p5 then
                local Humanoid2 = child:FindFirstChild("Humanoid");
                local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

                if Humanoid2 and (HumanoidRootPart2 and (Humanoid.Health > 0 and (Humanoid2.Health > 0 and CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector:Dot(CurrentCamera.CFrame.LookVector) > 0))) then
                    local _, v10 = CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                    if v10 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude;

                        if v9 >= Magnitude then
                            if v7 then
                                if Magnitude < v8 then
                                    v7 = child;
                                end;
                            else
                                v7 = child;
                                v8 = Magnitude;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v7;
    end;
end;

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
v1.Summon = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart", "P1", "P2", "P3", "P4", "P5" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 186, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 129, 234)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Stun = 0.75,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-1" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 6706979361,
                Volume = 0.8
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-2" }, { 16, 18, "Attack" }, { 19, "End" } }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-3" }, { 16, 18, "Attack" }, { 19, "End" } }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.45,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-4" }, { 16, 18, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 10466221970,
                Volume = 1
            }
        },
        StatusEffects = {}
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.1,
        Stun = 0.75,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 28, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = v2["D4C: Love Train"].KnifeHit.Attachment
        },
        HitSounds = {
            Hit = {
                SoundId = 11038124693,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 8, 13, "Attack" }, { 18, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 10, 13, "Attack" }, { 18, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 11038126028,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.1,
        Sequence = { { 0, "Start" }, { 36, 42, "Attack" }, { 48, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = v2["C-Moon"].Effects.HeavyHit,
            Offset = CFrame.Angles(1.5707963267948966, 0, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 11038126198,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p11, p12) -- Line: 283, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p11.Stats;

            if not Knit.CollectionService:HasTag(p11.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v1["Rib Crusher"] = {
    Active = true,
    Cooldown = 10,
    Damage = 35,
    Stun = 1,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Ragdoll = {
        Time = 1
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 7043345930,
            Volume = 1
        }
    }
};
v1.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Cooldown = 10,
    Hit = {
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    Finisher = {
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    ClashFinisher = {
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v1.Slam = {
    Active = true,
    Cooldown = 10,
    Damage = 15,
    Stun = 1,
    Actionable = {
        Active = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v4 },
    Block = {
        Unblockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 10086010512,
            Volume = 1
        }
    }
};
v1["Heavy Punch"] = {
    Active = true,
    Cooldown = 10,
    Damage = 30,
    Stun = 0.5,
    Actionable = {
        Active = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        BlockBreak = true
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 10086010512,
            Volume = 1
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3,
        Velocity = Vector3.new(0, 5, 0)
    }
};
v1["Revolver Shot"] = {
    Active = true,
    Cooldown = 10,
    Damage = 35,
    Distance = 5,
    Piercing = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 36,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = true
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "BulletHitEffect", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 7086617073,
            Volume = 1,
            PlaybackSpeed = 1
        }
    }
};
v1.Uppercut = {
    Active = true,
    Damage = 30,
    Stun = 0.5,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v4 },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3,
        Velocity = Vector3.new(0, 5, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 7076941842,
            Volume = 1,
            PlaybackSpeed = 1
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    }
};
v1.Counter = {
    Active = true,
    Cooldown = 20,
    Actionable = {
        Active = true
    },
    FirstPunch = {
        Damage = 20,
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 7086617073,
                Volume = 1,
                PlaybackSpeed = 1
            }
        }
    },
    SecondPunch = {
        Damage = 25,
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 7076942084,
                Volume = 1,
                PlaybackSpeed = 1
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 80,
            Time = 0.3,
            Velocity = Vector3.new(0, 5, 0)
        }
    }
};
v1["Clone Bomb"] = {
    Cooldown = 15,
    Active = true,
    Damage = 40,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Stun = {
        Time = 0.35,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3,
        Velocity = Vector3.new(0, 5, 0)
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 30,
        Debug = false,
        Offset = CFrame.identity
    },

    Invoke = function(p13) -- Line: 616, Name: Invoke
        -- upvalues: Knit (copy), GetFacing (copy)
        local v14 = Knit.GetService("MoveInputService");
        local v15 = GetFacing(game.Players.LocalPlayer.Character, 50);

        if not v15 then
            return;
        end;

        v14:FireInput(p13.RawInput, v15);
    end
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
            ["Rib Crusher"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Summon out the stand arm\'s as they cover yours and then jab forward."
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Perform multiple strikes while the move is held down before unleashing a finishing strike."
            },
            Slam = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Summon out the stand as it grabs a target before embedding them to the ground."
            },
            ["Heavy Punch"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Perform a heavy strike."
            },
            Uppercut = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Summon out your stand as it quickly uppercuts.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Counter = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Enter a counterattack-state, on activation you will spawn a clone as it helps you combo on the victim.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Revolver Shot"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Bring out a revolver and fire it.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Clone Bomb"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Spawn a clone of the nearest target which runs after them and explodes upon nearing them.",
                LevelRequirement = 65,
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
            Gunshots = 6955684230,
            Gunshot = 7081331191,
            ReloadGun = 8513845878,
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 6955620587,
            ["StandOff-LMB-2"] = 6955621861,
            ["StandOff-LMB-3"] = 8513845878,
            ["StandOff-LMB-4"] = 6955621861,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            HeavyPunch = 7189349499,
            TwoArmPunch = 7041819690,
            Uppercut = 7080376767,
            D4CSlam = 7080880379,
            ["Clone Bomb"] = 7081047669,
            ["Dimension Hop"] = 7091385791,
            ["Counter Startup"] = 7071462816,
            ["Jumper-1"] = 7071483574,
            ["Jumper-2"] = 7071482261,
            Jumped = 7071485507,
            PoseTransition = 10405284330,
            PoseIdle = 10405289231
        },
        Movement = {
            Walk = 6877996750,
            Run = 7037969480,
            SummonedWalk = 6877996750,
            SummonedRun = 7037969480
        },
        Idle = {
            SummonedIdle = 6954981919,
            Idle = 6954960940
        }
    },
    Stats = v1,
    Sounds = {
        testsfx = {
            SoundId = 7082637917,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ihop = {
            SoundId = 7096933834,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Uppercut = {
            SoundId = 7082655026,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["SwingLMB-1"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB-2"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB-4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        SummonSound = {
            SoundId = 3378144990,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonEffects = {
            SoundId = 6955512196,
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Slammed = {
            SoundId = 7082654738,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SFX = {
            SoundId = 7076938274,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RibCrusherSFX = {
            SoundId = 7043345175,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RibCrusher = {
            SoundId = 7043345583,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMBB4 = {
            SoundId = 6943345719,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMBB3 = {
            SoundId = 7082349836,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMBB2 = {
            SoundId = 7080992891,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMBB1 = {
            SoundId = 7080992471,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB4 = {
            SoundId = 6943345719,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB3 = {
            SoundId = 6943346153,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB2 = {
            SoundId = 6943345864,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB1 = {
            SoundId = 6943345996,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyPunch = {
            SoundId = 7048655373,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunVoicelineOFF = {
            SoundId = 7082349836,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunVoiceline = {
            SoundId = 7081584683,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunFireOFF = {
            SoundId = 7080993660,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunFire = {
            SoundId = 7081532001,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunEquip = {
            SoundId = 3120031857,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Gun = {
            SoundId = 6779120451,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Guesswhoback = {
            SoundId = 7076940724,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FlagSFX = {
            SoundId = 7082619175,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Fallsfx = {
            SoundId = 7076939657,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ExplosionVoice = {
            SoundId = 7082638223,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Explosion = {
            SoundId = 7082637917,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Dimension = {
            SoundId = 7096933070,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = 6955608320,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CounterStartSFX = {
            SoundId = 7076935530,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CounterStart = {
            SoundId = 7076936591,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CloneAppearSFX = {
            SoundId = 7082772774,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CloneAppear = {
            SoundId = 7082620048,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BombSFX = {
            SoundId = 7082618885,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageSFX = {
            SoundId = 7048655757,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = 10835571201,
            Volume = 1.25
        },
        PoseMusic = {
            SoundId = 10395314815,
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
                    SoundId = "rbxassetid://6955336680",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Everything I do is for the sake of my country!"
                        } }
                }, {
                    SoundId = "rbxassetid://6955338267",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t get carried away. I\'m ready to execute you at a moment\'s notice."
                        } }
                }, {
                    SoundId = "rbxassetid://6955339553",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My heart and actions are utterly unclouded, they are those of \'justice\'"
                        } }
                } }
        }
    }
};