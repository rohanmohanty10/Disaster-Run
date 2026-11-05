  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p4) -- Line: 68, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v5 = TableUtil.Copy(p4.Stats, true);

            if p4.Character:GetAttribute("ICANTSTOP") then
                v5.StartAnim = "AwakenPoseTransition";
                v5.LoopAnim = "AwakenPose";
                v5.NoPoseAudio = true;
            end;

            return v5;
        end,

        PoseTransition = function(p6, p7) -- Line: 79, Name: PoseTransition
            -- upvalues: u2 (ref)
            u2.FireAllClients("A-Train Pose", p6.Character, true);
        end,

        PoseLoop = function(p8, p9) -- Line: 84, Name: PoseLoop
            if p8.Character:GetAttribute("ICANTSTOP") then
                local v10 = p8.Character:GetAttribute("GuitarRemix") and 0.765 or 1;
                local Animator = p8.Animator;
                local v11 = Animator:GetAnimation("AwakenPoseTransition");
                local v12 = Animator:GetAnimation("AwakenPose");
                v11:AdjustSpeed(v10);
                v12:AdjustSpeed(v10);
            end;
        end,

        PoseEnd = function(p13, p14) -- Line: 93, Name: PoseEnd
            -- upvalues: u2 (ref)
            u2.FireAllClients("A-Train Pose", p13.Character, false);
        end
    }
};
v1.Grab = {
    From = "Combat.Grab"
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 0, "PlaySound", "LMB1-Voiceline" }, { 15, 19, "Attack" }, { 37, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665760078,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 0, "PlaySound", "LMB2-Voiceline" }, { 9, 16, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759862,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 0, "PlaySound", "LMB3-Voiceline" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759570,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 0, "PlaySound", "LMB4-Voiceline" }, { 23, 27, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759370,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p15, p16) -- Line: 189, Name: PreAnim
            -- upvalues: u3 (ref)
            local _ = p15.Stats;
            local _ = p15.Player;
            local Character = p15.Character;
            local RootPart = p15.RootPart;

            if p16.MoveState.Count == 1 and Character:GetAttribute("Awakened") then
                local v17 = {};

                for _, v in u3.Hitbox({
                    Caster = Character,
                    Stats = {
                        Hitbox = {
                            Size = 25,
                            HitboxType = "ClientHitbox"
                        }
                    }
                }) do
                    local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");
                    local v18 = v.Character:FindFirstChildOfClass("Humanoid");

                    if HumanoidRootPart and (v18 and (not v18 or v18.Health > 0)) then
                        table.insert(v17, {
                            Character = v.Character,
                            Part = HumanoidRootPart,
                            Distance = (RootPart.Position - HumanoidRootPart.Position).Magnitude
                        });
                    end;
                end;

                table.sort(v17, function(p19, p20) -- Line: 221
                    return p19.Distance < p20.Distance;
                end);
                local v21 = v17[1];

                if v21 then
                    local HumanoidRootPart = v21.Character:FindFirstChild("HumanoidRootPart");
                    local v22 = Vector3.new(RootPart.CFrame.Position.X, HumanoidRootPart.Position.Y, RootPart.CFrame.Position.Z);
                    local v23 = CFrame.lookAt(v22, HumanoidRootPart.Position);
                    local v24 = RaycastParams.new();
                    v24.FilterType = Enum.RaycastFilterType.Include;
                    v24.FilterDescendantsInstances = { workspace.Map };
                    local v25 = 6;
                    local v26 = u3.RaycastMap(HumanoidRootPart.Position, -v23.LookVector * v25);

                    if v26 then
                        v25 = (HumanoidRootPart.Position - v26.Position).Magnitude;
                    end;

                    u3.GetMetadata(Character);
                    local _ = v21.Distance > 9;
                    RootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position + -v23.LookVector * (v25 - 2), HumanoidRootPart.Position);
                end;
            end;
        end
    }
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Zeus\' Blessing"] = {
    Active = true,
    Damage = 50,
    MusicAmount = 2,
    Speed = 50,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = 45
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.175,
        Velocity = Vector3.new(0, 80, 0)
    },
    Ragdoll = {
        Time = 2.4
    },
    Cooldown = {
        Time = 1,
        Manual = true
    }
};
v1["Lightspeed Barrage"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Callbacks = {
        BarrageEffect = function(p27, p28, p29, p30) -- Line: 330, Name: BarrageEffect
            -- upvalues: Knit (copy), u2 (ref)
            local Character = p28.Character;

            if p30 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                u2.FireAllClients("Character Arm Barrage", Character, {
                    DistanceScale = 1.55,
                    FadeOut = 0.075,
                    SkinName = p28.SkinName,
                    Offset = CFrame.new(0, 0, -1.6)
                });
                p29.SequenceTrove:Add(function() -- Line: 343
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 1.5,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/NS_Hit",
                        LookAt = "Attacker",
                        IgnoreUnusuals = true
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 15665760760,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        Damage = 40,
        Speed = 1.35,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Particle = "Particles/NS_Heavy",
                        AutoSerialize = true
                    } }
            } },
        HitData = {
            Offset = CFrame.Angles(-1.5707963267948966, 0, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 15665760615,
                Volume = 1.75
            }
        }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 0, function(p31, p32, p33, p34) -- Line: 391
                -- upvalues: AssetHandler (copy), ParticleHandler (copy)
                local v35 = p31:GetCache("Cache");
                local Character = p33.Character;
                local RootPart = p33.RootPart;
                Character:GetAttribute("Awakened");
                local u36 = AssetHandler.CloneAsset("Particles/Barrage/Flurry", p33);
                ParticleHandler.Unusualify(u36, p33);
                u36.Parent = Character;
                ParticleHandler.AttachTo(u36, {
                    Part = RootPart,
                    Offset = CFrame.new(0, 0, 2.35)
                });
                u36.Punches.Star.ParticleEmitter:Emit(1);
                p33.Trove:Add(function() -- Line: 409
                    -- upvalues: ParticleHandler (ref), u36 (copy)
                    ParticleHandler.DestroyEmit(u36);
                    ParticleHandler.EnableAllParticles(u36, false);
                end);
                v35.FX = u36;
            end },
        { 23, "Cancelable", true },
        { 24, "Clashable", true },
        { 24, "Barrage", true },
        { 24, "PlaySound", "Barrage-Voiceline", {
                Cancelable = true
            } },
        { 24, function(p37, p38, p39, p40) -- Line: 421
                -- upvalues: ParticleHandler (copy)
                local v41 = p37:GetCache("Cache");

                if v41.FX then
                    ParticleHandler.EnableAllParticles(v41.FX, true);
                end;
            end },
        { 24, 144, "BarrageAttack", "Hit" },
        { 144, function(p42, p43, p44, p45) -- Line: 447
                -- upvalues: ParticleHandler (copy)
                local v46 = p42:GetCache("Cache");

                if v46.FX then
                    ParticleHandler.EnableAllParticles(v46.FX, false);
                end;
            end },
        { 144, "Cancelable", false },
        { 144, "Clashable", false },
        { 144, "BarrageFinisher" },
        { 163, "BarrageAttack", "Finisher" },
        { 163, function(p47, p48, p49, p50) -- Line: 457
                -- upvalues: u2 (ref)
                local Player = p49.Player;
                u2.FireAllClients("Emit Particle V3", {
                    Path = "Particles/Barrage/Burst",
                    AutoSeralize = true,
                    Origin = p49.RootPart,
                    Offset = CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(3, 0, 0),
                    Player = Player,
                    AbilityName = p49.AbilityName,
                    SkinName = p49.SkinName
                });
            end },
        { 193, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v1.Voltplex = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 14),
        Offset = CFrame.new(0, 0, -6)
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 37,
        Time = 0.12,
        Velocity = Vector3.new(0, 22, 0)
    },
    Ragdoll = {
        Time = 0.75
    },
    Stun = {
        Time = 0.5
    }
};
v1["Sunder Drag"] = {
    Active = true,
    Speed = 166,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Startup = {
        MinHealth = 1,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Slam = {
        MinHealth = 1,
        Damage = 17.5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Drag = {
        Frequency = 5,
        Damage = 1.8,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Throw = {
        Damage = 0,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.35
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v1["Incalculable Speed"] = {
    Active = true,
    Damage = 1,
    Frequency = 7,
    Actionable = {
        Active = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Override = true,
        Speed = 15,
        Time = 0.13
    },
    Stun = {
        Time = 0.7,
        Priority = EnumsModule.Stun.Heavy
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Hitbox = {
        Size = 16
    },
    Lunge = {
        Damage = 20,
        Hitbox = {
            Size = Vector3.new(15, 10, 30),
            Offset = CFrame.new(0, 0, -15)
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 75,
            Velocity = Vector3.new(0, 25, 0),
            Time = 0.1
        },
        Stun = {
            Time = 1
        }
    },
    Uppercut = {
        Damage = 26,
        Block = {
            PerfectBlockable = false,
            Blockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 14),
            Offset = CFrame.new(0, 0, -6)
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 37,
            Time = 0.12,
            Velocity = Vector3.new(0, 22, 0)
        },
        Ragdoll = {
            Time = 0.75
        },
        Stun = {
            Time = 0.5
        }
    }
};
v1["Zeus\' Creation"] = {
    Active = false,
    DetectRange = 50,
    Range = 80,
    FlightHeight = 20,
    Damage = 3,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = 11
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    }
};
v1.Flashtime = {
    Active = false,
    Range = 40,
    TimescaleSlowdown = 0.25,
    WalkSpeedSlowdown = 0.2,
    Frequency = 0.5,
    Duration = 8,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
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
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            ["Zeus\' Blessing"] = {
                DefaultKeybind = "Q",
                Equipped = true
            },
            ["Lightspeed Barrage"] = {
                DefaultKeybind = "E",
                Equipped = true
            },
            Voltplex = {
                DefaultKeybind = "R",
                Equipped = true
            },
            ["Sunder Drag"] = {
                DefaultKeybind = "B",
                Equipped = true
            },
            ["Incalculable Speed"] = {
                DefaultKeybind = "G",
                Equipped = true
            },
            ["Zeus\' Creation"] = {
                DefaultKeybind = "Y",
                Equipped = true
            },
            Flashtime = {
                DefaultKeybind = "H",
                Equipped = true
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 18481535015,
            ["LMB-2"] = 18481539738,
            ["LMB-3"] = 18481542035,
            ["LMB-4"] = 18481544321,
            Lunge = 14324703321,
            Barrage = 11495782122,
            BarrageStartup = 11532429157,
            BarrageFinisher = 11532430783,
            ["Grab User Attempt"] = 14806973384,
            ["Grab User"] = 18420958221,
            ["Grab Target"] = 18420965253,
            ["Grab User Throw"] = 15437061475,
            ["Grab Target Throw"] = 15437059251,
            PoseTransition = 17820963180,
            PoseIdle = 13396067240,
            AwakenPoseTransition = 18986985855,
            AwakenPose = 18986993638,
            ["Incalculable Speed"] = 135407025551983,
            ["Incalculable Speed Followup"] = 110955822717976,
            ["Zeus\' Blessing"] = 18478618278,
            Voltplex = 138914004563525,
            ["Zeus\' Creation"] = 122604079355123,
            ForwardAccel1 = 13110057999,
            ForwardAccel2 = 13110058550,
            LeftAccel = 13110059106,
            RightAccel = 13110059920,
            BackwardAccel = 13110061695,
            Grab = 11110729280,
            ["Shake Shack"] = 18959036288,
            Yummers = 18193518230,
            ["Speed Blitz Startup"] = 18973380721,
            ["Speed Blitz Camera"] = 18986636204,
            ["Speed Blitz Victim"] = 18986640519,
            ["Speed Blitz User"] = 18986642836,
            ["Kimiko Attempt"] = 10912968659,
            ["Kimiko Start User"] = 74388937688761,
            ["Kimiko Loop User"] = 80496961030715,
            ["Kimiko End User"] = 82550162300773,
            ["Kimiko Start Target"] = 84172690717547,
            ["Kimiko Loop Target"] = 135372332692161,
            ["Kimiko End Target"] = 95927532022430,
            ["The Deep"] = 101677568626110
        },
        Movement = {
            Walk = 17820902887,
            Run = 13811919323,
            ["Awaken-Walk"] = 17820902887,
            ["Awaken-Run"] = 11765603339,
            ["Yummers Flight"] = 7493825611
        },
        Idle = {
            Idle = 18481522723,
            ["Awaken-Idle"] = 18426830469
        }
    },
    Stats = v1,
    Sounds = {
        ["Awakening Music 1"] = {
            SoundId = 12245753561,
            Volume = 1.75,
            Looped = true,
            Attributes = {
                GoalPitch = 1.69,
                TimePosition = 20
            }
        },
        ["Awakening Music 2"] = {
            SoundId = 140285169823196,
            Volume = 3,
            Looped = true,
            PlaybackRegionsEnabled = true,
            Attributes = {
                GoalPitch = 0.53
            },
            PlaybackRegion = NumberRange.new(0, 54.911),
            LoopRegion = NumberRange.new(0, 54.911)
        }
    }
};