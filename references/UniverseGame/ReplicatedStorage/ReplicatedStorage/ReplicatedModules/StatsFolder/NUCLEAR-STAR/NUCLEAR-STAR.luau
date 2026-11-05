  

 

local Players = game:GetService("Players");
local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets.Assets.Abilities["NUCLEAR-STAR"];
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Fusion = require(game.ReplicatedStorage.ClientLibrary.Fusion);
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local Name = script.Name;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u3 (ref), Knit (copy)
    u3 = Knit.GetService("EffectService");
end);
local v4 = {
    NS_Hit = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/NS_Hit",
            AutoSerialize = true
        } },
    NS_Heavy = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/NS_Heavy",
            AutoSerialize = true
        } }
};
v1.SPAWN = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1
    },
    Shockwave = TableUtil.Reconcile({}, {
        Damage = 35,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        OnStanding = {
            Priority = EnumsModule.Intangible.Ragdoll,
            Ragdoll = {
                Time = 1.25,
                Override = true
            },
            KnockbackData = { {
                    Type = "Velocity",
                    RelativeTowards = "Target",
                    Speed = 8,
                    Velocity = Vector3.new(0, 48, 0),
                    Time = 0.2
                }, {
                    Type = "Force",
                    Force = Vector3.new(0, 215, 0),
                    Time = 0.45
                } },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BlockBreak = false,
                PerfectBlockBreak = false,
                BypassCounter = true
            }
        },
        OnRagdoll = {
            Priority = EnumsModule.Intangible.Ragdoll,
            Ragdoll = {
                Time = 1.25,
                Override = true
            },
            KnockbackData = { {
                    Type = "Velocity",
                    RelativeTowards = "Target",
                    Speed = 8,
                    Velocity = Vector3.new(0, 48, 0),
                    Time = 0.2
                }, {
                    Type = "Force",
                    Force = Vector3.new(0, 215, 0),
                    Time = 0.45
                } },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BlockBreak = false,
                PerfectBlockBreak = false,
                BypassCounter = true
            }
        }
    })
};
v1["SUMMON-ME"] = {
    From = "Combat.Summon",
    Indicators = { {
            Group = "Universal",
            Name = "Summon",
            InputText = "%s",
            Visible = true
        } },
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 255, 166)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 17, 255)) })
};
v1["NUCLEAR-BURST"] = {
    Active = true,
    DamagePercentage = 0.35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 35,
        Manual = true
    },
    Meter = {
        RequiredAmount = 60,
        MeterGain = 0,
        RemoveMeter = false
    },
    ExplosionStats = {
        Damage = 1,
        IsOverwhelmDamage = true,
        TrueDamage = true,
        IGNORE_DOT = true,
        IgnoreProcessing = true,
        IgnoreDamageScaling = true,
        IS_DOT = false,
        Priority = EnumsModule.Intangible.Quickstep,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1.75
        },
        Meter = {
            MeterGain = 0
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 50,
            Time = 0.1,
            Override = true,
            Velocity = Vector3.new(0, 25, 0)
        },
        Hitbox = {
            Size = 15
        }
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};
v1["COLLAPSING-PUNCHES"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.7,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 20, 23, "Attack" }, { 29, "End" } },
        Stun = {
            Time = 0.625,
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
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 74323810701976,
                Volume = 3
            }
        }
    },
    ["LMB-2"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Damage = 8,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 24, 27, "Attack" }, { 29, "End" } }
    },
    ["LMB-3"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Damage = 8,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 26, 29, "Attack" }, { 45, "End" } }
    },
    ["LMB-4"] = {
        Cooldown = 0.75,
        Damage = 24,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 20, 23, "Attack" }, { 25, "End" } },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 73176687079776,
                Volume = 3
            }
        }
    },
    ["StandOff-LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.4,
        Damage = 6,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 17, 20, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.625,
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
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 74323810701976,
                Volume = 3
            }
        }
    },
    ["StandOff-LMB-2"] = {
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 20, 23, "Attack" }, { 30, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1,
        Sequence = { { 0, "Start" }, { 21, 24, "Attack" }, { 30, "ResetHits" }, { 35, 38, "Attack" }, { 50, "End" } }
    },
    ["StandOff-LMB-4"] = {
        Speed = 1.75,
        Cooldown = 0.75,
        Damage = 16,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 20, 23, "Attack" }, { 50, "End" } },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 73176687079776,
                Volume = 3
            }
        }
    },
    Callbacks = {
        StateChecker = function(p5, p6) -- Line: 470, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p5.Stats;

            if not Knit.CollectionService:HasTag(p5.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";

                if p6.MoveState and p6.MoveState.Count and p6.MoveState.Count == Stats.MaxCombo then
                    Stats.StatusEffects = { {
                            Name = "NSCollapse",
                            ApplyTo = "Target"
                        } };
                end;
            end;

            return Stats;
        end
    }
};
v1["USE-YOUR-IMAGINATION"] = TableUtil.Reconcile({
    Active = true,
    From = "Combat.Barrage",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hit = {
        Frequency = 6,
        Damage = 0.75,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4.5)
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
        Block = {},
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 132334821925902,
                Volume = 1
            }
        }
    },
    Finisher = {
        Frequency = 360,
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
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
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 73176687079776,
                Volume = 2
            }
        }
    },
    ClashHit = {
        Frequency = 2,
        Damage = 1,
        Priority = EnumsModule.Intangible.Clash,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Offset = CFrame.new(0, 0, -4)
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
            Offset = CFrame.new(0, 0, -4)
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
v1["GUARD-ME"] = {
    From = "Combat.Block"
};
v1["QUICK-STEP"] = {
    From = "Combat.Quickstep"
};
v1["QUICKER-STEP"] = {
    From = "Sorcerer Killer.Breakneck Dash"
};
local New = Fusion.New;
v1.POSE = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p7) -- Line: 649, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v8 = TableUtil.Copy(p7.Stats, true);

            if Knit.CollectionService:HasTag(p7.Character, "Summoned") then
                v8.StartAnim = "StandPoseTransition";
                v8.LoopAnim = "StandPoseIdle";
                v8.PoseMusic = "Pose";

                return v8;
            end;

            v8.StartAnim = "StandOffPoseTransition";
            v8.LoopAnim = "StandOffPoseIdle";
            v8.PoseMusic = "StandOffPose";

            return v8;
        end,

        PoseTransition = function(p9, p10) -- Line: 663, Name: PoseTransition
            -- upvalues: u2 (copy), New (copy), ParticleHandler (copy), u3 (ref)
            local Character = p9.Character;
            local Trove = p9.Trove;
            Trove:AttachToInstance(Character);
            local v11 = u2.FetchSound(Character, p10.NewStats.PoseMusic);
            local SoundId = v11.SoundId;
            local Model = Instance.new("Model");
            Model.Name = "Nuclear_Visualizer";
            local v12 = New("Part")({
                Transparency = 1,
                Size = Vector3.new(40, 40, 40),
                Anchored = true,
                CastShadow = false,
                CanCollide = false,
                CanQuery = false,
                CanTouch = false,
                Name = "Attach",
                Shape = Enum.PartType.Ball,
                Parent = Model
            });
            local v13 = New("AudioPlayer")({
                Looping = true,
                Volume = 5,
                TimePosition = v11.TimePosition,
                PlaybackSpeed = v11.PlaybackSpeed or 1,
                Asset = SoundId,
                Parent = v12
            });
            local v14 = New("AudioAnalyzer")({
                WindowSize = Enum.AudioWindowSize.Large,
                Parent = v12
            });
            local v15 = New("AudioEmitter")({
                Parent = v12
            });
            v15:SetDistanceAttenuation({
                [0] = 0.3,
                [100] = 0
            });
            New("Wire")({
                SourceInstance = v13,
                TargetInstance = v14,
                Parent = v14
            });
            New("Wire")({
                SourceInstance = v13,
                TargetInstance = v15,
                Parent = v15
            });
            ParticleHandler.AttachTo(v12, {
                UseMotor6D = true,
                Part = p9.RootPart
            });
            Model.Parent = workspace.Effects;
            Trove:Add(Model);
            v13:Play();
            task.wait(0.03333333333333333);
            u3.FireAllClients("NUCLEAR-POSE", {
                Reference = Model,
                Character = Character
            });
        end
    }
};
v1["GRAB-THEM"] = {
    Active = true,
    Distance = 35,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        HitboxType = "ClientHitbox",
        Tolerance = 15,
        Size = Vector3.new(7, 6, 15),
        Offset = CFrame.new(0, 0, -7)
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = v4.NS_Hit
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 11585326202,
            Volume = 1.5
        }
    },
    SlamDown = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Ragdoll = {
            Time = 2.3
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        }
    }
};
v1["ENTANGLE-YOU"] = {
    Active = true,
    EntangleDuration = 6,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        Manual = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 9, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    First = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.45,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 85473845903930,
                Volume = 2
            }
        }
    },
    Second = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.2
        },
        Block = {
            BlockBreak = true,
            PerfectBlockBreak = true
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 137027379956985,
                Volume = 2
            }
        }
    },
    Pull = {
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 1
        }
    }
};
v1["TAKE-IT"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 7,
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
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
    },
    HitSounds = {
        Hit = {
            SoundId = 85707559942197,
            Volume = 3
        }
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = v4.NS_Heavy
        }
    }
};
v1["NEUTRON-TOSS"] = {
    Active = true,
    ThrowDelay = 0.03,
    StarAmount = 6,
    Damage = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Block = {
        PerfectBlockable = false,
        BypassCounter = true
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = v4.NS_Hit
        }
    }
};
v1["HYPERNOVA-BLAST"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Quickstep,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Stun = {
        Time = 0.5
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    AOE = {
        Interval = 0.5,
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Size = 14,
            Predict = true
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Stun = {
            Time = 1.75
        }
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = v4.NS_Hit
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 122348718721807,
            Volume = 2.5
        }
    }
};
v1["COLLAPSING-SLAM"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Quickstep,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = Vector3.new(24, 3, 24),
        Offset = CFrame.new(0, -3, -12)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true,
        BypassCounter = false
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0
    },
    StatusEffects = { {
            Name = "NSCollapse",
            ApplyTo = "Target"
        } },
    Stun = {
        Time = 1.5
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    HitSounds = {
        Hit = {
            SoundId = 1,
            Volume = 3
        }
    }
};
v1["NUCLEAR-TEMPO"] = {
    Active = true,
    Damage = 5,
    Duration = 0.567,
    Reach = 50,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(6, 6, 6),
        Offset = CFrame.new(0, 0, -3.75)
    },
    HitSounds = {
        Hit = {
            SoundId = 10626698543,
            Volume = 3
        }
    },
    Stun = {
        Time = 0.367,
        Priority = EnumsModule.Stun.Heavy
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    FacePunch = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    },
    Uppercut = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    },
    BackHand = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    },
    SlamDown = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    },
    KickUp = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    },
    Barrage = {
        Damage = 0.234,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    },
    Finish = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Stand.StandHumanoidRootPart",
                Velocity = Vector3.new(0, 100, 0),
                Speed = 80,
                Time = 0.25
            } },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    }
};
v1["COLLAPSING-UPPERCUT"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -5)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true,
        BypassCounter = true
    },
    Stun = {
        Time = 0.7
    },
    StatusEffects = { {
            Name = "NSCollapse",
            ApplyTo = "Target",
            TickCount = 3,
            TickSpeed = 3
        } },
    KnockbackData = { {
            Type = "Velocity",
            RelativePart = "Attacker",
            Velocity = Vector3.new(0, 50, 0),
            Speed = 50,
            Time = 0.4,
            Override = true
        }, {
            Type = "AngularVelocity",
            RelativePart = "Attacker",
            RelativeVelocity = Vector3.new(-40, 0, 0),
            Time = 0.4,
            Override = true
        } },
    Ragdoll = {
        Time = 2.35
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = v4.NS_Heavy
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 85707559942197,
            Volume = 3
        }
    }
};
v1["NUCLEAR-STAR"] = {
    Active = true,
    Damage = 4,
    Distance = 50,
    Duration = 0.75,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 75,
        MeterGain = 0
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Tolerance = 15,
        Offset = CFrame.new(0, 0, -3.75)
    },
    Cooldown = {
        Time = 35,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true,
        BypassCounter = true
    },
    RightHook = {
        Damage = 3.5,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        }
    },
    Uppercut = {
        Damage = 5,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        }
    },
    ThrowAtPlayer = {
        Damage = 4,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        }
    },
    ThrowAtStand = {
        Damage = 4,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        }
    },
    PlayerHeadPunch = {
        Damage = 4,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        }
    },
    StandFacePunch = {
        Damage = 4,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        }
    },
    PlayerFaceKick = {
        Damage = 5,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Hit
            }
        }
    },
    StandSlam = {
        Damage = 4,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.567,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        }
    },
    StepOn = {
        Damage = 10,
        MinHealth = 1,
        Blockable = false,
        PerfectBlockable = false,
        IgnoreLoveTrain = true,
        Priority = EnumsModule.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.8,
            Priority = EnumsModule.Stun.Heavy
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        }
    },
    Explosion = {
        DamageToDeal = 1,
        Damage = 1,
        IgnoreLoveTrain = true,
        IgnoreProcessing = true,
        IGNORE_DOT = true,
        IS_DOT = false,
        PercentDamage = 0.1,
        Priority = EnumsModule.Intangible.Quickstep,
        Meter = {
            MeterGain = 0
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Hitbox = {
            Size = Vector3.new(35, 300, 35),
            Offset = CFrame.new(0, -2.5, 0)
        },
        Stun = {
            Time = 0.35,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 1.75
        }
    }
};
v1["ACCELERATION-DRIVE"] = {
    Active = true,
    SpeedFalloff = 0.4,
    MinimumSpeed = 8,
    MaximumSpeed = 100,
    MaximumJump = 32,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    }
};
v1["SELF-DESTRUCT"] = {
    Active = true,
    HitboxGain = 6,
    Damage = 10,
    ArenaDamage = false,
    Recovery = false,
    RequiredAmount = 100,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Quickstep,
    Actionable = {
        Active = true,

        Check = function(p16) -- Line: 1713, Name: Check
            -- upvalues: Players (copy), UIOutput (copy)
            local v17 = p16:FindFirstChildOfClass("Humanoid");

            if not v17 then
                return false;
            end;

            local v18 = v17.Health / v17.MaxHealth;
            local v19 = {
                "WE-SELLING-NOW?",
                `WE-CANT-QUIT-JUST-YET-{string.upper(p16.Name)}`,
                "YOU-CANNOT",
                "I-REFUSE-TO-BE-TERMINATED",
                "DO-NOT",
                "NOT-DESPERATE-ENOUGH",
                "INSUFFICIENT-DAMAGE-TAKEN"
            };

            if v18 <= 0.1 then
                return true;
            end;

            local v20 = Players:GetPlayerFromCharacter(p16);

            if v20 then
                UIOutput:FireClient(v20, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "NUCLEAR-STAR:",
                    Verb = "",
                    Subject = v19[math.random(1, #v19)] .. " (Health > 10%)",
                    SubjectColor = Color3.fromRGB(255, 0, 0),
                    NumericalContentColor = Color3.fromRGB(120, 187, 220)
                });
                UIOutput:FireClient(v20, "PlaySound", "ns_refuse");
            end;

            return false;
        end
    },
    Hitbox = {
        Size = 10,
        Offset = CFrame.identity
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 0.35
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Charge = {
        Damage = 3.75,
        ArenaDamage = false,
        Recovery = false,
        TrueDamage = true,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Size = 7.5,
            Offset = CFrame.identity
        },
        Ragdoll = {
            Time = 1
        },
        Stun = {
            Time = 0.35
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    }
};
v1["NUCLEAR-STORAGE"] = {
    Actionable = {
        Stunned = true,
        Active = true
    },
    Active = true,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 12, 12),
        FriendlyFire = true,
        Offset = CFrame.new(0, 0, -5)
    },
    Success = {
        Damage = 35,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.15,
            Override = true,
            Velocity = Vector3.new(0, 5, 0)
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 131514901046557,
                Volume = 3
            }
        }
    },
    Fail = {
        Damage = 45,
        MinHealth = 1,
        BypassSafeZone = true,
        CheckPVPSafe = false,
        FriendlyFire = true,
        BypassPartyBlacklist = true,
        IgnoreProcessing = true,
        IGNORE_DOT = true,
        IS_DOT = false,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Recovery = {
            Amount = 0,
            Heal = false
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 60,
            Time = 0.15,
            Override = true,
            InverseLookVector = true,
            Velocity = Vector3.new(0, 5, 0)
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4.NS_Heavy
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 95335163209413,
                Volume = 3
            }
        }
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    }
};

return {
    Stats = v1,
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            StandOff = {
                Visible = true,
                Priority = 2
            },
            StandOn = {
                Visible = false,
                Priority = 3
            },
            Passives = {
                Visible = false,
                Priority = 4
            }
        },
        MovesInfo = {
            ["SELF-AWARE"] = {
                State = "Passives",
                Description = "<font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> can comment on your gameplay performance."
            },
            ["SELF-DESTRUCTION"] = {
                State = "Passives",
                Description = "When <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> takes lethal damage, it self-destructs and creates a <b>NUCLEAR</b> explosion."
            },
            OVERWHELM = {
                State = "Passives",
                Description = "Successful attacks store <font color=\"#62219c\"><b>OVERWHELM</b></font> damage on the target. Use \"<b>NUCLEAR-BURST</b>\" to detonate all stored damage as an AoE explosion dealing damage based on the stored amount. The visual indicator shows when stored damage is lethal. Stored damage expires after <b>10</b> seconds without landing new attacks."
            },
            MOMENTUM = {
                State = "Passives",
                Description = "Successful attacks grant <font color=\"#6ea1fa\"><b>MOMENTUM</b></font>, increasing your timescale by a percentage of base damage dealt (capped per hit). Maximum speed is 1.5x normal. Duration refreshes with new damage. If <font color=\"#6ea1fa\"><b>MOMENTUM</b></font> expires at maximum speed, player receive a temporary speed debuff. Otherwise, player return to base speed."
            },
            COLLAPSE = {
                State = "Passives",
                Description = "Last hit of <b>\"COLLAPSING-PUNCHES\"</b> and <b>\"COLLAPSING-UPPERCUT\"</b> inflict <font color=\"#bf0000\"><b>COLLAPSE</b></font>, which detonates after a set duration and deals AoE damage to the target and nearby enemies."
            },
            ["COLLAPSING-PUNCHES"] = {
                DefaultKeybind = "MouseButton1",
                Description = "Perform a chain of strikes ending with a powerful blow, knocking targets away. Last hit of Stand Off variant inflicts <font color=\"#bf0000\"><b>COLLAPSE</b></font>",
                Equipped = true,
                MoveCapCount = false
            },
            ["GUARD-ME"] = {
                DefaultKeybind = "F",
                Description = "Enter a blocking state to reduce incoming damage, or, if timed correctly, negate the damage fully and stun the attacker. This state may be broken or bypassed by some attacks.",
                Equipped = true,
                MoveCapCount = false
            },
            ["QUICK-STEP"] = {
                DefaultKeybind = "C",
                Description = "Player initiates a swift directional dash, briefly making player intangible to attacks.",
                Equipped = true,
                MoveCapCount = false
            },
            ["GRAB-THEM"] = {
                DefaultKeybind = "X",
                Description = "After a brief windup, dash forward to grab and slam down the enemy, causing ragdoll. Stand closes if <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> is summoned.",
                Equipped = true,
                MoveCapCount = false
            },
            ["SUMMON-ME"] = {
                DefaultKeybind = "Q",
                Description = "Summon/activate your ability and, if given, alternate between available moves.",
                Equipped = true,
                MoveCapCount = false
            },
            ["NUCLEAR-BURST"] = {
                DefaultKeybind = "Q+",
                State = "StandOn",
                LevelRequirement = 35,
                Description = "After a brief windup, explode all <font color=\"#62219c\"><b>OVERWHELM</b></font> damage on affected targets. If interrupted, all <font color=\"#62219c\"><b>OVERWHELM</b></font> damage is exploded on Player instead."
            },
            POSE = {
                DefaultKeybind = "P",
                Description = "Strike a pose unique to your ability.",
                Equipped = true,
                MoveCapCount = false
            },
            ["USE-YOUR-IMAGINATION"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Equipped = true,
                Description = "<font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> unleashes multiple blows, knocking the target away on the final hit."
            },
            ["ENTANGLE-YOU"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Equipped = true,
                Description = "<font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> performs two chops that <font color=\"#20b2aa\"><b>ENTANGLE</b></font> caught enemies. Recast during other moves to pull <font color=\"#20b2aa\"><b>ENTANGLED</b></font> enemies to player. <font color=\"#20b2aa\"><b>ENTANGLE</b></font> lasts 6 seconds."
            },
            ["NEUTRON-TOSS"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                LevelRequirement = 25,
                Description = "Summon stars around player. Recast to throw all stars forward simultaneously. Can be used during other moves."
            },
            ["TAKE-IT"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Equipped = true,
                Description = "<font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> performs a strong punch, knocking the target away."
            },
            ["HYPERNOVA-BLAST"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                LevelRequirement = 20,
                Description = "After a brief windup, <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> launches a slow star that grows larger and faster over time. The star releases a pull wave that draws non-blocking targets toward it. Both the star and pull can be blocked but cannot be I-framed through quickstepping."
            },
            ["NUCLEAR-TEMPO"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                LevelRequirement = 50,
                Description = "Launch <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> forward to grab a target. Upon successful grab, <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> relentlessly attacks while player remain free to use moves that don\'t require <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font>."
            },
            ["ACCELERATION-DRIVE"] = {
                DefaultKeybind = "V",
                Equipped = true,
                Description = "After a brief windup, gain extreme movement speed for a short duration. Movement speed is reduced below normal afterward as endlag. Player can use any move during this move."
            },
            ["NUCLEAR-STAR"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                LevelRequirement = 100,
                Description = "<font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> launches player forward. If player catches a target, player and <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> beat down the enemy."
            },
            ["COLLAPSING-UPPERCUT"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                Equipped = true,
                Unlocked = true,
                Description = "After a brief windup, perform a powerful uppercut that inflicts <font color=\"#bf0000\"><b>COLLAPSE</b></font> on the enemy."
            },
            ["COLLAPSING-SLAM"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                LevelRequirement = 30,
                Description = "<font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> slams its fists on the ground, creating a pulse that pulls enemies. Pulse can be blocked."
            },
            ["NUCLEAR-STORAGE"] = {
                DefaultKeybind = "B",
                State = "StandOn",
                LevelRequirement = 45,
                Description = "Enter a stance. If attacked during this move, player and <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> counter with a punch that knocks the enemy backward. Some moves may bypass this stance. If player fail the counter, <font color=\"#1858b8\"><b>NUCLEAR-STAR</b></font> becomes angry and uppercuts player in frustration."
            },
            ["SELF-DESTRUCT"] = {
                DefaultKeybind = "B+",
                State = "StandOn",
                LevelRequirement = 200,
                Description = "When below 10% health with maximum meter, manually trigger the <b>SELF-DESTRUCTION</b> passive."
            }
        }
    },
    Sounds = {
        SPAWN = {
            SoundId = 81100795183744,
            Volume = 2,
            Looped = true
        },
        ["SPAWN SFX"] = {
            SoundId = 121746643731470,
            Volume = 2
        },
        ["ARMOR-DESTROYED"] = {
            SoundId = 109386032959088,
            Volume = 5
        },
        SummonEffects = {
            SoundId = 79181572406148,
            Volume = 2
        },
        Desummon = {
            SoundId = 121531913687463,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 90528236097065,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 97387951789851,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 129029034526796,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 135743712021209,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 90528236097065,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 97387951789851,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 129029034526796,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 135743712021209,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        Barrage = {
            SoundId = 90162378965081,
            Volume = 2
        },
        ["TAKE-IT"] = {
            SoundId = 98930937498196,
            Volume = 2
        },
        ["NUCLEAR-BURST User"] = {
            SoundId = 104506543449740,
            Volume = 2
        },
        ["NUCLEAR-BURST Warning"] = {
            SoundId = 105220229894101,
            Volume = 2
        },
        ["NUCLEAR-BURST Explosion"] = {
            SoundId = 104234762378517,
            Volume = 2
        },
        ["OVERWHELM-APPLIED"] = {
            SoundId = 123505068806561,
            Volume = 3
        },
        ["OVERWHELM-CRITICAL"] = {
            SoundId = 137939951890822,
            Volume = 3
        },
        ["OVERWHELM-REVERT"] = {
            SoundId = 72476562090576,
            Volume = 3
        },
        ["COLLAPSE-AMB"] = {
            SoundId = 121665623984308,
            Volume = 0.75,
            Looped = true
        },
        ["ENTANGLE-YOU"] = {
            SoundId = 139582604885349,
            Volume = 2.5
        },
        ["ENTANGLE-YOU Status"] = {
            SoundId = 130105098092091,
            Volume = 2.5
        },
        ["GRAB-THEM-START"] = {
            SoundId = 100407654741257,
            Volume = 2.5
        },
        ["GRAB-THEM"] = {
            SoundId = 80725257276763,
            Volume = 2.5
        },
        ["NEUTRON-TOSS"] = {
            SoundId = 85473845903930,
            Volume = 3
        },
        ["NEUTRON-TOSS Ambience"] = {
            SoundId = 110017218706295,
            Volume = 1.5,
            Looped = true
        },
        ["NEUTRON-TOSS Shoot"] = {
            SoundId = 137027379956985,
            Volume = 3
        },
        ["HYPERNOVA-BLAST-START"] = {
            SoundId = 78314342028074,
            Volume = 2.5
        },
        ["HYPERNOVA-BLAST-SHOOT"] = {
            SoundId = 112979233942569,
            Volume = 2.5
        },
        ["HYPERNOVA-BLAST-LOOP"] = {
            SoundId = 105991508038089,
            Volume = 2.5,
            Looped = true
        },
        ["NUCLEAR-TEMPO-START"] = {
            SoundId = 117216914838358,
            Volume = 2.5
        },
        ["NUCLEAR-TEMPO"] = {
            SoundId = 99556445939301,
            Volume = 2.5
        },
        ["NUCLEAR-STAR Start"] = {
            SoundId = 104084752024517,
            Volume = 2
        },
        ["NUCLEAR-STAR Success"] = {
            SoundId = 102680055896498,
            Volume = 2
        },
        ["NUCLEAR-STAR SpecialSuccess"] = {
            SoundId = 130788707511812,
            Volume = 2
        },
        ["COLLAPSING-SLAM"] = {
            SoundId = 79083466911547,
            Volume = 2
        },
        ["COLLAPSING-UPPERCUT"] = {
            SoundId = 116980350378378,
            Volume = 2
        },
        ["NUCLEAR-STORAGE Start"] = {
            SoundId = 103528878615787,
            Volume = 2
        },
        ["NUCLEAR-STORAGE Success"] = {
            SoundId = 117879943533243,
            Volume = 2
        },
        ["NUCLEAR-STORAGE Fail"] = {
            SoundId = 71150242022121,
            Volume = 2
        },
        ["SELF-DESTRUCT"] = {
            SoundId = 91227156215131,
            Volume = 3
        },
        ["ACCELERATION-DRIVE"] = {
            SoundId = 73102915486413,
            Volume = 2
        },
        Pose = {
            SoundId = "rbxassetid://98927735449658",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = true
        },
        StandOffPose = {
            SoundId = "rbxassetid://86859374299922",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = true
        }
    },
    Animations = {
        Action = {
            SPAWN = 84710544624396,
            ["LMB-1"] = 75550482007724,
            ["LMB-2"] = 131513761524593,
            ["LMB-3"] = 94417575047175,
            ["LMB-4"] = 107752358968847,
            ForwardDash1 = 16731260577,
            ForwardDash2 = 16731262071,
            BackwardDash = 16731258517,
            LeftDash = 16731263558,
            RightDash = 16731264589,
            ["StandOff-LMB-1"] = 103208714268781,
            ["StandOff-LMB-2"] = 86764858083517,
            ["StandOff-LMB-3"] = 86817362880870,
            ["StandOff-LMB-4"] = 72720462164368,
            Summon = 11253115200,
            Desummon = 11253119442,
            Overwhelm = 126038524030671,
            EntangleChop = 100105007852976,
            EntanglePull = 72891940480659,
            NeutronSummon = 120452443975674,
            HyperNova = 81692609974424,
            ["Tandem Startup"] = 118578944887122,
            ["Tandem Loop"] = 80287237875775,
            ["Tandem Stand"] = 104114572854177,
            ["Tandem Enemy"] = 71687623152079,
            TakeIt = 10603603515,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            ["Nuclear Startup"] = 88724481510498,
            ["Nuclear Player"] = 139225241605655,
            ["Nuclear Enemy"] = 94872055017680,
            ["Nuclear Camera"] = 109745600318037,
            AccelerationDrive = 72700634712080,
            NeutronStarCollapse = 100339448994591,
            CollapsingUppercut = 125472503890153,
            GrabThemStartup = 83887159834046,
            GrabThemSuccess = 89002364248059,
            GrabThemEnemy = 119584215071524,
            EndItAll = 115257262750724,
            CounterWindup = 112689367949970,
            CounterSuccess = 105113637051818,
            CounterFail = 80458392088251,
            StandPoseIdle = 11589085863,
            StandPoseTransition = 11589775854,
            StandOffPoseIdle = 130817230293751,
            StandOffPoseTransition = 124187505145521
        },
        Movement = {
            Walk = 135525315416991,
            Run = 135125969464766,
            Fall = 77107027342537,
            NuclearRun = 11765603339
        },
        Idle = {
            Idle = 125038083725886
        }
    },
    Metadata = {
        PostRig = function(p21) -- Line: 2491, Name: PostRig
            -- upvalues: AssetHandler (copy), Name (copy), ParticleHandler (copy)
            local Player = p21.Player;
            local Character = p21.Character;
            local SkinName = p21.SkinName;
            local v22 = Player:IsA("Player") and Player.Data.Skin.Value;
            local v23 = {
                ["1"] = Color3.fromRGB(255, 105, 180),
                ["3"] = Color3.fromRGB(170, 255, 255)
            };

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local v24 = Character:FindFirstChild("Left Arm");
            local v25 = Character:FindFirstChild("Right Arm");

            local function CreateGauntlet(p26, p27) -- Line: 2509
                -- upvalues: AssetHandler (ref), Name (ref), SkinName (copy), Character (copy), ParticleHandler (ref), Player (copy)
                local v28 = AssetHandler.CloneAsset("Models/Gauntlet", {
                    AbilityName = Name,
                    SkinName = SkinName
                });
                local Handle = v28.Handle;

                if Handle then
                    v28.Parent = Character;
                    local Motor6D = Instance.new("Motor6D");
                    Motor6D.Name = "GauntletWeld";
                    Motor6D.Part0 = p26;
                    Motor6D.Part1 = Handle;
                    Motor6D.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(p27), 0);
                    Motor6D.Parent = p26;
                    ParticleHandler.Unusualify(v28, {
                        IncludeParts = true,
                        IncludeSurfaces = true,
                        IncludeTextures = true,
                        Player = Player,
                        Character = Character,
                        SkinName = SkinName
                    });
                end;

                return v28;
            end;

            CreateGauntlet(v24, 180);
            CreateGauntlet(v25, 0);
            local v29 = v23[v22] or Color3.fromRGB(73, 98, 220);
            Character:SetAttribute("MeterColor", (ParticleHandler.TryHSVShift(v29, ParticleHandler.GetUnusualHSVData({
                Character = Character
            }))));
        end
    }
};