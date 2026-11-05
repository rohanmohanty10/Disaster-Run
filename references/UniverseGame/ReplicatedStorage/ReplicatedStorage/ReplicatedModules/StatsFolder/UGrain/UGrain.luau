  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 13
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref), u4 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u4 = Knit.GetService("TagService");
end);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Particles/NS_Hit",
        LookAt = "Attacker",
        IgnoreUnusuals = true
    } };
({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Particle = "Particles/NS_Heavy",
        AutoSerialize = true
    } };
local v5 = {
    Hit = {
        SoundId = 95761023259981,
        Volume = 1
    }
};
local v6 = {
    Hit = {
        SoundId = 126060125681919,
        Volume = 1
    }
};

local function CreateLightningTrail(p7, p8) -- Line: 94
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u2 (ref)
    if not (p7 and p7.Character) then
        return;
    end;

    local Trove2 = p7.Trove;
    local v9 = p7.Character:FindFirstChild(p8);

    if not v9 then
        return;
    end;

    local v10 = Trove2:Construct(Instance, "Attachment");
    v10:SetAttribute("Enabled", true);
    v10.Parent = v9;
    v10.Position = Vector3.new(0, -v9.Size.Y / 0.8, 0);
    local u11 = AssetHandler.CloneAsset("Particles/General/LimbAura", p7);
    ParticleHandler.Unusualify(u11, p7);
    u11.Parent = p7.Character;
    task.delay(1, u11.Destroy, u11);
    ParticleHandler.EnableAllParticles(u11, true);
    ParticleHandler.AttachTo(u11, {
        Part = v9
    });
    local v12 = {
        Default = Color3.fromRGB(105, 141, 192),
        ["Reverse Flash"] = Color3.fromRGB(172, 12, 12),
        ["CW Flash"] = Color3.fromRGB(221, 147, 81),
        ["Injustice Flash"] = Color3.fromRGB(234, 201, 15)
    };
    u2.FireAllClients("LightningTrail", {
        Size = 0.2,
        Color = ColorSequence.new(v12[p7.SkinName] or v12.Default),
        DurationMultiplier = p7.Character:GetAttribute("Flashtime") and 2 or 1,
        Reference = v10,
        Player = p7.Player,
        Character = p7.Character
    });
    Trove2:Add(function() -- Line: 135
        -- upvalues: ParticleHandler (ref), u11 (copy)
        ParticleHandler.DestroyEmit(u11);
        ParticleHandler.EnableAllParticles(u11, false);
    end);
end;

v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p13) -- Line: 153, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v14 = TableUtil.Copy(p13.Stats, true);

            if p13.Character:GetAttribute("Awakened") then
                v14.StartAnim = "AwakenPoseTransition";
                v14.LoopAnim = "AwakenPose";
                v14.NoPoseAudio = true;
            end;

            return v14;
        end,

        PoseTransition = function(p15, p16) -- Line: 166, Name: PoseTransition
            -- upvalues: u2 (ref)
            local Character = p15.Character;
            u2.FireAllClients("A-Train Pose", Character, true);

            if p15.SkinName == "Wally West" then
                u2.FireAllClients("Emit Particle V3", {
                    Path = "Particles/Pose/Start",
                    Origin = Character.HumanoidRootPart,
                    Player = p15.Player
                });
            end;
        end,

        PoseLoop = function(p17, p18) -- Line: 179, Name: PoseLoop
            -- upvalues: AssetHandler (copy), ParticleHandler (copy)
            if p17.Character:GetAttribute("Awakened") then
                local v19 = p17.Character:GetAttribute("GuitarRemix") and 0.765 or 1;
                local Animator = p17.Animator;
                local v20 = Animator:GetAnimation("AwakenPoseTransition");
                local v21 = Animator:GetAnimation("AwakenPose");
                v20:AdjustSpeed(v19);
                v21:AdjustSpeed(v19);
            end;

            if p17.SkinName == "Wally West" then
                local v22 = p18.Trove:Add(AssetHandler.CloneAsset("Particles/Pose/RootAura", p17));
                ParticleHandler.Unusualify(v22, p17);
                v22.Parent = p17.Character;
                ParticleHandler.AttachTo(v22, {
                    Part = p17.Character.HumanoidRootPart
                });
                local v23 = p18.Trove:Add(AssetHandler.CloneAsset("Particles/Pose/TorsoAura", p17));
                ParticleHandler.Unusualify(v23, p17);
                v23.Parent = p17.Character;
                ParticleHandler.AttachTo(v23, {
                    Part = p17.Character.Torso
                });
            end;
        end,

        PoseEnd = function(p24, p25) -- Line: 206, Name: PoseEnd
            -- upvalues: u2 (ref)
            u2.FireAllClients("A-Train Pose", p24.Character, false);
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
        HitSounds = v5
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 0, "PlaySound", "LMB2-Voiceline" }, { 9, 16, "Attack" }, { 25, "End" } },
        HitSounds = v5
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 0, "PlaySound", "LMB3-Voiceline" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = v5
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 0, "PlaySound", "LMB4-Voiceline" }, { 23, 27, "Attack" }, { 36, "End" } },
        HitSounds = v6
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p26, p27) -- Line: 282, Name: PreAnim
            -- upvalues: u3 (ref), CreateLightningTrail (copy)
            local _ = p26.Stats;
            local Count = p27.MoveState.Count;
            local _ = p26.Player;
            local Character = p26.Character;
            local RootPart = p26.RootPart;

            if Count == 1 and Character:GetAttribute("Awakened") then
                local v28 = {};

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
                    local v29 = v.Character:FindFirstChildOfClass("Humanoid");

                    if HumanoidRootPart and (v29 and (not v29 or v29.Health > 0)) then
                        table.insert(v28, {
                            Character = v.Character,
                            Part = HumanoidRootPart,
                            Distance = (RootPart.Position - HumanoidRootPart.Position).Magnitude
                        });
                    end;
                end;

                table.sort(v28, function(p30, p31) -- Line: 314
                    return p30.Distance < p31.Distance;
                end);
                local v32 = v28[1];

                if v32 then
                    local HumanoidRootPart = v32.Character:FindFirstChild("HumanoidRootPart");
                    local v33 = Vector3.new(RootPart.CFrame.Position.X, HumanoidRootPart.Position.Y, RootPart.CFrame.Position.Z);
                    local v34 = CFrame.lookAt(v33, HumanoidRootPart.Position);
                    local v35 = 6;
                    local v36 = u3.RaycastMap(HumanoidRootPart.Position, -v34.LookVector * v35);

                    if v36 then
                        v35 = (HumanoidRootPart.Position - v36.Position).Magnitude;
                    end;

                    u3.GetMetadata(Character);
                    RootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position + -v34.LookVector * (v35 - 2), HumanoidRootPart.Position);
                end;
            end;

            CreateLightningTrail(p26, ({ "Right Arm", "Left Arm", "Right Arm", "Left Leg" })[Count]);
        end
    }
};
v1["Messages From The Stars"] = {
    Active = true,
    Damage = 28,
    MusicAmount = 2,
    Speed = 2.25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        Manual = true
    },
    Meter = {
        RequiredAmount = 40,
        RemoveMeter = true
    },
    Hitbox = {
        Size = 22
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 50,
        Time = 0.15,
        Velocity = Vector3.new(0, 50, 0)
    },
    Ragdoll = {
        Time = 1.5
    },
    HitSounds = {
        Hit = {
            SoundId = 14187497104,
            Volume = 1.4
        }
    }
};
v1["In a Jiff"] = {
    Active = true,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 1.8,
        UGrainBar = 0.5,
        HitSounds = {
            Hit = {
                SoundId = 113418576002403,
                Volume = 0.5
            }
        },
        Stun = {
            Time = 0.5,
            Barrage = true,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -6)
        }
    },
    Finisher = {
        Damage = 22,
        UGrainBar = 8,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.15
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Size = Vector3.new(13.5, 13.5, 13.5),
            Offset = CFrame.new(0, 0, -6.75)
        },
        HitSounds = v6
    }
};
v1.Homerun = {
    Active = true,
    Damage = 28,
    Armor = true,
    UGrainBar = 12,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Block = {
        Blockable = true,
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
        Speed = 45,
        Time = 0.15,
        Velocity = Vector3.new(0, 25, 0)
    },
    Ragdoll = {
        Time = 1.2
    },
    Stun = {
        Time = 0.5
    },
    HitSounds = {
        Hit = {
            SoundId = 125196099101827,
            Volume = 1
        }
    }
};
v1["\"I Can\'t Stop\""] = {
    Active = true,
    Damage = 30,
    UGrainBar = 10,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = true
    },
    Hitbox = {
        Size = Vector3.new(13, 13, 36)
    },
    Block = {
        Blockable = false,
        BlockBreak = false,
        PerfectBlockable = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 55,
        Time = 0.12,
        Velocity = Vector3.new(0, 30, 0)
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 0.5
    },
    HitSounds = v6
};
v1["Here Comes The UGrain"] = {
    Active = true,
    Speed = 120,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = true
    },
    Startup = {
        MinHealth = 1,
        UGrainBar = 5,
        Stun = {
            Time = 0.6
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
        Damage = 12,
        UGrainBar = 8,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Drag = {
        Frequency = 5,
        Damage = 1.5,
        UGrainBar = 0,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Throw = {
        Damage = 8,
        UGrainBar = 5,
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
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Character Rock Trail", {
                        State = true,
                        Duration = 1,
                        Attribute = "GomuRifleTargetRocks",
                        Character = "__Target"
                    } }
            } }
    }
};
v1["Incalculable Speed"] = {
    Active = true,
    Damage = 1.5,
    Frequency = 7,
    UGrainBar = 0.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Override = true,
        Speed = 12,
        Time = 0.1
    },
    Stun = {
        Time = 1.3,
        Barrage = true,
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
    HitSounds = {
        Hit = {
            SoundId = 14291752793,
            Volume = 0.5
        }
    }
};
v1["Scorched Earth"] = {
    Active = false,
    Damage = 4,
    TrueDamage = true,
    DetectRange = 55,
    Range = 60,
    FlightHeight = 20,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p37) -- Line: 721, Name: Check
            return not p37:GetAttribute("AssistCharacter");
        end
    },
    Cooldown = {
        Time = 40,
        Manual = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = true
    },
    Hitbox = {
        Size = 11
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true,
        BypassCounter = true
    }
};
v1["Compound High"] = {
    Armor = true,
    Active = true,
    Range = 40,
    TimescaleSlowdown = 0.15,
    WalkSpeedSlowdown = 0.15,
    Frequency = 0.5,
    Duration = 6,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = true
    }
};
v1.Yummers = {
    Active = true,
    Heal = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30,
        RemoveMeter = true
    }
};
v1["Fastest Man Alive"] = {
    Active = true,
    Damage = 5,
    MinHealth = 1,
    UGrainBar = 5,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 100,
        RemoveMeter = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Tolerance = 2,
        Offset = CFrame.new(0, 0, -3)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Stun = {
        Time = 0.45
    },
    First = {
        MinHealth = 1,
        Damage = 20,
        UGrainBar = 5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Second = {
        MinHealth = 1,
        Damage = 20,
        UGrainBar = 8,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Third = {
        MinHealth = 1,
        Damage = 25,
        UGrainBar = 8,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        }
    },
    Last = {
        Damage = 35,
        UGrainBar = 0,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 55,
            Velocity = Vector3.new(0, 35, 0),
            Time = 0.15
        },
        Ragdoll = {
            Time = 3
        }
    }
};
v1["America\'s Finest"] = {
    Active = false,
    Damage = 1.5,
    HipHeight = 3,
    MaxSlope = 0.5,
    Speed = 38,
    Frequency = 5,
    RunDuration = 2.5,
    TurnRate = 0.2,
    MaxHitsPerTarget = 50,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p38) -- Line: 910, Name: Check
            return not p38:GetAttribute("AssistCharacter");
        end
    },
    Cooldown = {
        Time = 50,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40,
        RemoveMeter = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Tolerance = 6,
        Offset = CFrame.new(0, 0, -3)
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 0.4
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 6,
        Time = 0.1
    },
    HitSounds = {
        Hit = {
            SoundId = 131168463175627,
            Volume = 0.5
        }
    },
    Finisher = {
        Damage = 12,
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 50,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.15
        },
        Ragdoll = {
            Time = 1.2
        }
    }
};
v1["Deep Dive"] = {
    Active = false,
    VoicelineVariants = 9,
    Damage = 2,
    Frequency = 12,
    Duration = 3,
    AimSpeed = 45,
    MinAimTime = 0.75,
    MaxAimTime = 2.5,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p39) -- Line: 989, Name: Check
            return not p39:GetAttribute("AssistCharacter");
        end
    },
    Cooldown = {
        Time = 40,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 60,
        RemoveMeter = true
    },
    Hitbox = {
        Size = 20
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.5
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 8,
        Time = 0.15
    },
    Burst = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            Size = 32
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 55,
            Velocity = Vector3.new(0, 50, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passives = {
                Visible = true,
                Priority = 5
            }
        },
        MovesInfo = {
            ["Compound Rush"] = {
                State = "Passives",
                Description = "Upon reaching 70 UGrain Heat, enter an awakening with speed buffs. When attacked during the awakening, you are able to dodge moves, with chances of the dodge varying based on the amount of Heat you have. You must have the amount of Heat in your bar the same as the damage being dealt to you in order to have a chance to dodge the move. ",
                MoveCapCount = false
            },
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
            ["In a Jiff"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "Perform a swift barrage before punching enemies away."
            },
            Homerun = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = "Swing a baseball bat, knocking enemies away."
            },
            ["\"I Can\'t Stop\""] = {
                DefaultKeybind = "T",
                LevelRequirement = 25,
                Description = "Dash forward at supersonic speeds, knocking anyone hit away."
            },
            ["Incalculable Speed"] = {
                DefaultKeybind = "Y",
                LevelRequirement = 30,
                Description = "Spin around in circles at supersonic speeds, stunning enemies."
            },
            ["Here Comes The UGrain"] = {
                DefaultKeybind = "G",
                LevelRequirement = 55,
                Description = "Reach out in attempt to grab someone. Upon connection, drag them across the floor at high speeds by the leg before tossing them away."
            },
            ["Scorched Earth"] = {
                DefaultKeybind = "Z",
                LevelRequirement = 80,
                Description = "Call Homelander as he tracks an enemy with his laser eyes, dealing deadly true damage. The first strike is perfectblockable if not in mode."
            },
            ["Deep Dive"] = {
                DefaultKeybind = "Z+",
                LevelRequirement = 70,
                Description = "Form an AOE circle with water as The Deep swirls enemies with the waves. Can be held down to control where the circle is spawned."
            },
            ["America\'s Finest"] = {
                DefaultKeybind = "V",
                LevelRequirement = 60,
                Description = "Send Soldier Boy forth, charging with his shield and pushing enemies back. If held, you can control Soldier Boy\'s direction."
            },
            ["Compound High"] = {
                DefaultKeybind = "H",
                LevelRequirement = 90,
                Description = "Activate a temporary mode in which people nearby are slowed down."
            },
            ["Fastest Man Alive"] = {
                DefaultKeybind = "J",
                LevelRequirement = 125,
                Description = "Dash and run forward in attempt to hit someone. Upon connection, travel across the world and perform a deadly beatdown as you speed blitz the victim."
            },
            Yummers = {
                DefaultKeybind = "B",
                LevelRequirement = 45,
                Description = "Grab a drink, healing yourself."
            }
        }
    },
    Animations = {
        Action = {
            ["UGrain_Beatdown Camera Start"] = 78555755546849,
            ["UGrain_Beatdown Camera End"] = 118136654680876,
            ["UGrain_Beatdown Camera Wormhole 1"] = 82851697957924,
            ["UGrain_Beatdown Camera Wormhole 2"] = 76624201017951,
            ["UGrain_Beatdown Windup"] = 128794950907966,
            ["UGrain_Beatdown Attacker Start"] = 131754617279685,
            ["UGrain_Beatdown Attacker End"] = 127111485874789,
            ["UGrain_Beatdown Attacker Wormhole 1"] = 95320483490718,
            ["UGrain_Beatdown Attacker Wormhole 2"] = 134862369756196,
            ["UGrain_Beatdown Target Start"] = 121100183780848,
            ["UGrain_Beatdown Target End"] = 78433359326131,
            ["UGrain_Beatdown Target Wormhole 1"] = 97976933735517,
            ["UGrain_Beatdown Target Wormhole 2"] = 101326381270857,
            ["UGrain_Beatdown Atoms Start"] = 89695340795946,
            ["Outside UGrain_Beatdown Attacker Start"] = 133335914153149,
            ["Outside UGrain_Beatdown Attacker Loop"] = 81261688608052,
            ["Outside UGrain_Beatdown Attacker End"] = 105556803691202,
            ["Outside UGrain_Beatdown Target Start"] = 91974892140220,
            ["Outside UGrain_Beatdown Target Loop"] = 81079063010929,
            ["Outside UGrain_Beatdown Target End"] = 120024784260728,
            ["LMB-1"] = 90857379658091,
            ["LMB-2"] = 116516100989747,
            ["LMB-3"] = 81760696896064,
            ["LMB-4"] = 117409372719134,
            ["Grab User Attempt"] = 106380793398240,
            ["Grab User"] = 140210944398916,
            ["Grab Target"] = 136148183887406,
            ["Grab User Throw"] = 94903807938053,
            ["Grab Target Throw"] = 102006695577091,
            ["Incalculable Speed"] = 78937223801563,
            ["Messages From The Stars"] = 18478618278,
            Lunge = 100908506928051,
            Homerun = 13932427936,
            Yummers = 117981258862480,
            ["In a Jiff"] = 128714407506984,
            Flashtime = 115410065476562,
            ["Scorched Earth"] = 18945995400,
            ["The Deep"] = 101677568626110,
            ["America\'s Finest Start"] = 121483201378831,
            ["America\'s Finest Loop"] = 122868577478299,
            ["America\'s Finest End"] = 87159400920047,
            ForwardAccel1 = 13110057999,
            ForwardAccel2 = 13110058550,
            LeftAccel = 13110059106,
            RightAccel = 13110059920,
            BackwardAccel = 13110061695,
            PoseTransition = 17820963180,
            PoseIdle = 13396067240,
            AwakenPoseTransition = 18986985855,
            AwakenPose = 18986993638
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
        PoseMusic = {
            SoundId = 18371093880,
            Volume = 4,
            PlaybackSpeed = 0.59,
            Looped = true
        },
        LMB1 = {
            SoundId = 139057920614766,
            Volume = 1
        },
        ["LMB1-Voiceline"] = {
            SoundId = 18441089374,
            Volume = 2.5
        },
        LMB2 = {
            SoundId = 119364829152750,
            Volume = 2
        },
        ["LMB2-Voiceline"] = {
            SoundId = 18441091424,
            Volume = 2.5
        },
        LMB3 = {
            SoundId = 132408288169332,
            Volume = 2
        },
        ["LMB3-Voiceline"] = {
            SoundId = 18441090315,
            Volume = 2.5
        },
        LMB4 = {
            SoundId = 137410165168171,
            Volume = 2
        },
        ["LMB4-Voiceline"] = {
            SoundId = 18441092498,
            Volume = 2.5
        },
        ["In a Jiff SFX"] = {
            SoundId = 131792117749255,
            Volume = 1
        },
        ["In a Jiff Voiceline"] = {
            SoundId = 80234588816042,
            Volume = 1
        },
        ["Incalculable Speed Voiceline"] = {
            SoundId = 129922262726386,
            Volume = 1
        },
        ["Incalculable Speed SFX"] = {
            SoundId = 102011472145878,
            Volume = 1
        },
        ["Homerun Voiceline"] = {
            SoundId = 96945597018116,
            Volume = 1
        },
        ["Homerun SFX"] = {
            SoundId = 127158596440981,
            Volume = 1
        },
        ["Deep Dive User Voiceline"] = {
            SoundId = 89678975860960,
            Volume = 1
        },
        ["Deep Dive User Indicator Loop"] = {
            SoundId = 114348317294054,
            Volume = 1
        },
        ["Deep Dive User Indicator Startup"] = {
            SoundId = 132130100863009,
            Volume = 1
        },
        ["Deep Dive SFX"] = {
            SoundId = 124206575832990,
            Volume = 1
        },
        ["Deep Dive Voiceline 1"] = {
            SoundId = 124368302437546,
            Volume = 1
        },
        ["Deep Dive Voiceline 2"] = {
            SoundId = 100416156256855,
            Volume = 1
        },
        ["Deep Dive Voiceline 3"] = {
            SoundId = 128010485257696,
            Volume = 1
        },
        ["Deep Dive Voiceline 4"] = {
            SoundId = 81134216551522,
            Volume = 1
        },
        ["Deep Dive Voiceline 5"] = {
            SoundId = 120303016336086,
            Volume = 1
        },
        ["Deep Dive Voiceline 6"] = {
            SoundId = 117487871890870,
            Volume = 1
        },
        ["Deep Dive Voiceline 7"] = {
            SoundId = 105221885136352,
            Volume = 1
        },
        ["Deep Dive Voiceline 8"] = {
            SoundId = 93618334575156,
            Volume = 1
        },
        ["Deep Dive Voiceline 9"] = {
            SoundId = 89198975224472,
            Volume = 1
        },
        ["Scorched Earth Voiceline"] = {
            SoundId = 71076904271304,
            Volume = 1
        },
        ["Scorched Earth SFX"] = {
            SoundId = 108156384391113,
            Volume = 1
        },
        ["Laser SFX"] = {
            SoundId = 137661760452248,
            Volume = 1,
            Looped = true
        },
        ["America\'s Finest Voiceline"] = {
            SoundId = 124900455309656,
            Volume = 1
        },
        ["America\'s Finest SFX"] = {
            SoundId = 91288433708238,
            Volume = 1
        },
        ["Fastest Man Alive Start Voiceline"] = {
            SoundId = 121063200996565,
            Volume = 1
        },
        ["Fastest Man Alive Start SFX"] = {
            SoundId = 118519230418991,
            Volume = 1
        },
        ["Fastest Man Alive Voiceline"] = {
            SoundId = 124900455309656,
            Volume = 0
        },
        ["Fastest Man Alive SFX"] = {
            SoundId = 73020518719532,
            Volume = 1
        },
        ["Fastest Man Alive Outside SFX"] = {
            SoundId = 101259343978222,
            Volume = 1
        },
        ["Yummers Voiceline"] = {
            SoundId = 119956259349634,
            Volume = 1
        },
        ["Yummers SFX"] = {
            SoundId = 100085456371656,
            Volume = 1
        },
        ["Awakening Trigger SFX"] = {
            SoundId = 88086650887299,
            Volume = 1
        },
        ["Awakening Aura SFX"] = {
            SoundId = 125073410849913,
            Volume = 1,
            Looped = true
        },
        ["Awakening Music 1"] = {
            SoundId = 74422985455917,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 3.7878787878787876
            }
        },
        ["Awakening Music 2"] = {
            SoundId = 78607619525131,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 2.403846153846154
            }
        },
        Phase = {
            SoundId = 8185672261,
            Volume = 1
        },
        ["Compound High Startup SFX"] = {
            SoundId = 71698684476483,
            Volume = 1
        },
        ["Compound High Loop SFX"] = {
            SoundId = 125859590420183,
            Volume = 1,
            Looped = true
        },
        ["Compound High End SFX"] = {
            SoundId = 118408357511067,
            Volume = 1
        },
        ["Compound High End Voiceline"] = {
            SoundId = 76651625716290,
            Volume = 1
        },
        ["I Cant Stop SFX"] = {
            SoundId = 76692709273130,
            Volume = 1
        },
        ["I Cant Stop SFX Awakened Variant"] = {
            SoundId = 76692709273130,
            Volume = 1
        },
        ["I Cant Stop Voiceline"] = {
            SoundId = 92194882018975,
            Volume = 1
        },
        ["Grab Attempt SFX"] = {
            SoundId = 93146800247178,
            Volume = 1
        },
        ["Grab Attempt Voiceline"] = {
            SoundId = 95382648465370,
            Volume = 1
        },
        ["Grab SFX"] = {
            SoundId = 87429396047367,
            Volume = 1
        },
        ["Grab Voiceline"] = {
            SoundId = 112078766111865,
            Volume = 1
        },
        BurstBlood1 = {
            SoundId = 6148096445,
            Volume = 3.75
        },
        BurstBlood2 = {
            SoundId = 7441118570,
            Volume = 3.75
        },
        BurstBlood3 = {
            SoundId = 7441118030,
            Volume = 3.75
        },
        BurstBlood4 = {
            SoundId = 7441119990,
            Volume = 3.75
        }
    },
    Metadata = {
        Hooks = {
            UGrainBar = {
                CombatHook = "Attack",
                HookType = "Event",
                HookName = "UGrainBarHook",
                Priority = 99,

                HookFunction = function(p40) -- Line: 1611, Name: HookFunction
                    -- upvalues: Trove (copy), u4 (ref), u3 (ref), TweenService (copy), u2 (ref)
                    if p40.State.Success ~= true then
                        return true;
                    end;

                    local Attacker = p40.Attacker;
                    local v41 = p40.Stats or {};

                    if typeof(Attacker) ~= "Instance" then
                        return true;
                    end;

                    if not p40.Damage or p40.Damage <= 0 then
                        return true;
                    end;

                    if not v41.UGrainBar then
                        return true;
                    end;

                    local v42 = Attacker:GetAttribute("UGrainBar") or 0;
                    local v43 = Attacker:GetAttribute("UGrainBarMax") or 100;
                    local v44 = math.min(v42 + v41.UGrainBar, v43);
                    Attacker:SetAttribute("UGrainBar", v44);

                    if v44 >= 70 and not Attacker:GetAttribute("Awakened") then
                        Attacker:SetAttribute("Awakened", true);
                        local v45 = game:GetService("Players"):GetPlayerFromCharacter(Attacker);
                        local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");
                        local u46 = Trove.new();
                        u46:AttachToInstance(Attacker);
                        local u47 = u46:Add(u4:Add(u4:GetContainer(Attacker), "WalkSpeedMultiplier", 2.25));

                        local function UpdateSpeed() -- Line: 1637
                            -- upvalues: Attacker (copy), u47 (copy)
                            u47.Value = (Attacker:GetAttribute("PVPTag") or 0) > os.time() and 1.75 or 2.25 * (Attacker:GetAttribute("Flashtime") == true and 0.65 or 1);
                        end;

                        u47.Value = (Attacker:GetAttribute("PVPTag") or 0) > os.time() and 1.75 or 2.25 * (Attacker:GetAttribute("Flashtime") == true and 0.65 or 1);
                        u46:Connect(Attacker:GetAttributeChangedSignal("PVPTag"), UpdateSpeed);
                        u46:Connect(Attacker:GetAttributeChangedSignal("Flashtime"), UpdateSpeed);
                        task.spawn(function() -- Line: 1656
                            -- upvalues: Attacker (copy), u47 (copy)
                            while Attacker:GetAttribute("Awakened") do
                                task.wait(1);

                                if not (Attacker and Attacker:GetAttribute("Awakened")) then
                                    break;
                                end;

                                u47.Value = (Attacker:GetAttribute("PVPTag") or 0) > os.time() and 1.75 or 2.25 * (Attacker:GetAttribute("Flashtime") == true and 0.65 or 1);
                            end;
                        end);
                        u3.PlaySound(Attacker, "Awakening Trigger SFX");
                        u3.PlaySound(Attacker, "Awakening Aura SFX");
                        u46:Add(function() -- Line: 1667
                            -- upvalues: u3 (ref), Attacker (copy)
                            u3.StopSound(Attacker, "Awakening Aura SFX");
                        end);
                        local u48 = u3.GetSound(Attacker, "Awakening Music " .. math.random(1, 2));

                        if u48 then
                            if not u48:GetAttribute("GoalPitch") then
                                u48:SetAttribute("GoalPitch", 1);
                            end;

                            u48.TimePosition = u48:GetAttribute("TimePosition") or 0;
                            u48.PlaybackSpeed = 0.2;
                            u48:Play();
                            TweenService:Create(u48, TweenInfo.new(2.375, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                PlaybackSpeed = u48:GetAttribute("GoalPitch")
                            }):Play();
                        end;

                        if HumanoidRootPart then
                            u2.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Awaken/LightningStrike",
                                Origin = HumanoidRootPart,
                                Player = v45
                            });
                        end;

                        local v49 = v45 and v45:FindFirstChild("Data");

                        if not v49 then
                            if Attacker then
                                v49 = Attacker:FindFirstChild("Data");
                            else
                                v49 = Attacker;
                            end;
                        end;

                        local v50 = p40.SkinName or v49.Skin:GetAttribute("SkinName");
                        u2.FireAllClients("UGrain Speedster Aura", {
                            Attribute = "Awakened",
                            Character = Attacker,
                            SkinName = v50
                        });
                        task.spawn(function() -- Line: 1703
                            -- upvalues: Attacker (copy), u46 (copy)
                            while Attacker:GetAttribute("Awakened") do
                                task.wait(0.5);

                                if not (Attacker and Attacker:IsDescendantOf(game)) then
                                    break;
                                end;

                                if not Attacker:GetAttribute("DontDrainUGrainBar") then
                                    local v51 = (Attacker:GetAttribute("UGrainBar") or 0) - 1;
                                    local v52 = math.max(v51, 0);
                                    Attacker:SetAttribute("UGrainBar", v52);

                                    if v52 <= 0 then
                                        u46:Destroy();

                                        return;
                                    end;
                                end;
                            end;
                        end);
                        u46:Add(function() -- Line: 1726
                            -- upvalues: Attacker (copy), u48 (copy), TweenService (ref)
                            Attacker:SetAttribute("Awakened", nil);
                            Attacker:SetAttribute("UGrainBar", 0);

                            if u48 then
                                local v53 = TweenService:Create(u48, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                    PlaybackSpeed = 0
                                });
                                v53:Play();
                                v53.Completed:Connect(function() -- Line: 1736
                                    -- upvalues: u48 (ref)
                                    u48:Stop();
                                end);
                            end;
                        end);
                    end;

                    return true;
                end
            },
            UGrainPhase = {
                CombatHook = "Attack",
                HookType = "Inbound",
                HookName = "UGrainPhaseHook",
                Priority = 105,

                HookFunction = function(p54) -- Line: 1753, Name: HookFunction
                    -- upvalues: u4 (ref), u2 (ref), u3 (ref)
                    local Stats = p54.Stats;

                    if p54.State.Halt then
                        return true;
                    end;

                    local Target = p54.Target;

                    if p54.State.Success and (typeof(Target) == "Instance" and Target:GetAttribute("Awakened")) then
                        if Stats and Stats.UGrainBypass then
                            return true;
                        end;

                        if u4:Get(u4:GetContainer(Target), "Intangible") then
                            return true;
                        end;

                        local v55 = p54.Damage or (Stats and (Stats.Damage or 0) or 0);

                        if v55 <= 0 then
                            return true;
                        end;

                        local v56 = Target:GetAttribute("UGrainBar") or 0;

                        if v56 <= v55 then
                            return true;
                        end;

                        if v56 / (Target:GetAttribute("UGrainBarMax") or 100) >= math.random() then
                            p54.State.Halt = true;
                            p54.State.Success = false;
                            Stats.HitAnimations = nil;

                            if Stats.Damage then
                                Stats.Damage = 0;
                            end;

                            if Stats.Stun then
                                Stats.Stun = nil;
                            end;

                            if Stats.Knockback then
                                Stats.Knockback = nil;
                            end;

                            if Stats.Ragdoll then
                                Stats.Ragdoll = nil;
                            end;

                            if Stats.HitSounds then
                                Stats.HitSounds = nil;
                            end;

                            if Stats.HitRemotes then
                                Stats.HitRemotes = nil;
                            end;

                            if Stats.StatusEffects then
                                Stats.StatusEffects = nil;
                            end;

                            p54.State.Continue = false;
                            p54.Damage = 0;
                            p54.State.Dodged = true;
                            Target:SetAttribute("UGrainBar", (math.max(v56 - v55, 0)));
                            u2.FireAllClients("Q_PLAY_SOUND", u3.FetchSound(Target, "Phase"), Target.PrimaryPart, true);
                            task.spawn(function() -- Line: 1816
                                -- upvalues: u2 (ref), Target (copy)
                                u2.FireAllClients("HighlightObject", Target, {
                                    OutlineTransparency = 0,
                                    Lifetime = 0.5,
                                    Tween = true,
                                    DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                                    FillColor = Color3.fromRGB(255, 255, 255),
                                    OutlineColor = Color3.fromRGB(255, 255, 255)
                                });
                                u2.FireAllClients("NS_Distort", {
                                    StartPercentage = 4,
                                    Rate = 8,
                                    Character = Target
                                });
                            end);
                        end;
                    end;

                    return true;
                end
            }
        },

        CustomAddon = function(p57) -- Line: 1838, Name: CustomAddon
            local Character = p57.Character;
            Character:SetAttribute("UGrainBar", 0);
            Character:SetAttribute("UGrainBarMax", 100);
        end
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
                    SoundId = "rbxassetid://18441085138",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hey!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441083687",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Bring it on!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441084409",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Wooh.. close one."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441082730",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ay, don\'t make me run through you."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441087531",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Come on!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441083056",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ay, don\'t worry I gotchu."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441082210",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hahahaha.. fastest man alive!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441084757",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Man, gimme that!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441083989",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "A-Train is back in the game baby!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441085555",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can\'t stop! I won\'t stop!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441085908",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Man, Ima hit you so fast you\'ll smear on the pavement."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441087042",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Man, I\'ll outrun anybody.. let\'s do this."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441089858",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*laughter*"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441088902",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Nobody outruns the A-Train."
                        } }
                },
                {
                    SoundId = "rbxassetid://18441089138",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Haha, not bad!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441092712",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ah, scratch that!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441091020",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What was that?"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441091796",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Whutchu want, an ugograph or sumn?"
                        } }
                },
                {
                    SoundId = "rbxassetid://18441092189",
                    SoundVolume = 3.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You need me, I\'m the A-Train!"
                        } }
                }
            }
        }
    }
};