  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u2 = ReplicatedStorage:WaitForChild("Client Assets");

if game:GetService("RunService"):IsServer() then
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
end;

local function FindNearest(p3) -- Line: 23
    -- upvalues: Knit (copy)
    local Distance = p3.Distance;
    local Origin = p3.Origin;
    local v4 = p3.Ignore or {};
    local v5 = {};

    for _, v in ipairs(p3.Objects or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if not (Knit.CollectionService:HasTag(v, "Intangible") or table.find(v4, v)) then
            local v6 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v6 and (v6.Position - Origin.Position).Magnitude <= Distance then
                table.insert(v5, v);
            end;
        end;
    end;

    table.sort(v5, function(p7, p8) -- Line: 41
        -- upvalues: Origin (copy)
        local v9 = p7:IsA("Model") and p7.PrimaryPart or p7:FindFirstChild("HumanoidRootPart");
        local v10 = p8:IsA("Model") and p8.PrimaryPart or p8:FindFirstChild("HumanoidRootPart");

        return (v9.Position - Origin.Position).Magnitude < (v10.Position - Origin.Position).Magnitude;
    end);

    for _, v in ipairs(v5) do
        local _ = ((v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")).Position - Origin.Position).Magnitude;
    end;

    return p3.Multiple and v5 and v5 or v5[1];
end;

local v11 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true
            } }
    },
    ["Blood Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Blood",
                AutoSerialize = true
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true
            } }
    }
};

function SummonThing(p12)
    -- upvalues: TweenService (copy)
    local Character = p12.Character;
    local _ = Character.Humanoid;

    if p12.Player then
        if Character.Stand["Stand Torso"].Transparency == 1 then
            for _, descendant in pairs(Character.Stand:GetDescendants()) do
                if descendant:IsA("BasePart") and descendant.Name ~= "StandHumanoidRootPart" or descendant:IsA("Decal") then
                    descendant.Transparency = 0;
                elseif descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "SummonParticle" then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            return;
        end;

        if Character.Stand["Stand Torso"].Transparency == 0 then
            for _, descendant in pairs(Character.Stand:GetDescendants()) do
                if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                    TweenService:Create(descendant, TweenInfo.new(0.15), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
    end;
end;

local v18 = {
    ["Rush Attack"] = {
        From = "Combat.Rush Attack",
        Actionable = {
            Summoned = false
        },
        AnimationTimed = true,
        MaxCombo = 4,
        CustomPrefix = "LMB",
        ComboTick = 1.5,
        ["StandOff-LMB-1"] = TableUtil.Reconcile({
            Speed = 1.8,
            Stun = 0.65,
            HitAnimations = "Default",
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 26, 30, "Attack" }, { 33, "End" } },
            HitRemotes = { v11["Blood Hit"] },
            HitSounds = {
                Hit = {
                    SoundId = 10626698543,
                    Volume = 3
                }
            }
        }, BaseStatsModule.Rush_Attack),
        ["StandOff-LMB-2"] = {
            Speed = 1.5,
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 27, 31, "Attack" }, { 42, "End" } }
        },
        ["StandOff-LMB-3"] = {
            Speed = 1.5,
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 25, 28, "Attack" }, { 38, "End" } }
        },
        ["StandOff-LMB-4"] = TableUtil.Reconcile({
            Speed = 1.75,
            HitAnimations = "Default",
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 36, 44, "Attack" }, { 50, "End" } },
            Hitbox = BaseStatsModule.Stand_Rush_Attack.Hitbox,
            HitRemotes = { v11["Heavy Hit"] },
            HitSounds = {
                Hit = {
                    SoundId = 10626763879,
                    Volume = 3
                }
            }
        }, BaseStatsModule.Rush_Attack_Finisher),
        ["LMB-1"] = TableUtil.Reconcile({
            Speed = 1.5,
            HitAnimations = "Default",
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 23, 27, "Attack" }, { 28, "End" } },
            HitRemotes = { v11["Light Hit"] },
            HitSounds = {
                Hit = {
                    SoundId = 10626698543,
                    Volume = 3
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack),
        ["LMB-2"] = {
            Speed = 1.5,
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 18, 22, "Attack" }, { 28, "End" } }
        },
        ["LMB-3"] = {
            Speed = 1.5,
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 19, 23, "Attack" }, { 27, "End" } }
        },
        ["LMB-4"] = TableUtil.Reconcile({
            Speed = 1.5,
            HitAnimations = "Default",
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 22, 25, "Attack" }, { 42, "End" } },
            HitRemotes = { v11["Heavy Hit"] },
            HitSounds = {
                Hit = {
                    SoundId = 10626763879,
                    Volume = 3
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher),
        Callbacks = {
            StateChecker = function(p13, p14) -- Line: 264, Name: StateChecker
                -- upvalues: Knit (copy), TableUtil (copy)
                local Stats = p13.Stats;

                if not Knit.CollectionService:HasTag(p13.Character, "Summoned") then
                    Stats = TableUtil.Copy(Stats, true);
                    Stats.CustomPrefix = "StandOff-LMB";
                end;

                return Stats;
            end,

            PreAnim = function(u15, p16) -- Line: 274, Name: PreAnim
                -- upvalues: u2 (copy), TweenService (copy)
                local Count = p16.MoveState.Count;

                if p16.FullName == "StandOff-LMB-4" then
                    SummonThing(u15);
                    task.delay(0.45, function() -- Line: 280
                        -- upvalues: u15 (copy)
                        SummonThing(u15);
                    end);
                end;

                if not game:GetService("CollectionService"):HasTag(u15.Character, "Summoned") then
                    local u17 = u2.TWHV_R.m1knife:Clone();
                    u17.Parent = u15.Character;
                    u17.Handle.Connector.Part1 = u15.Character["Right Arm"];
                    task.delay(1, function() -- Line: 290
                        -- upvalues: u17 (copy), TweenService (ref)
                        game.Debris:AddItem(u17, 0.75);

                        for _, child in pairs(u17:GetChildren()) do
                            TweenService:Create(child, TweenInfo.new(0.45), {
                                Transparency = 1
                            }):Play();
                        end;
                    end);
                    u15.Character.Stand.PrimaryPart:FindFirstChild("LMB-" .. Count):Play();
                end;
            end
        }
    },
    Summon = {
        From = "Combat.Summon",
        LeaveParts = { "StandHumanoidRootPart" },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 179, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 240, 153)) })
    },
    ["Lethal Grasp"] = {
        Active = true,
        CheckPVPSafe = true,
        Actionable = {
            Active = true
        },
        Meter = {
            RequiredAmount = 25
        },
        Cooldown = {
            Time = 10,
            AfterMove = true
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11["Light Hit"] },
        Constant = {
            Damage = 0.5,
            Priority = Enums.Intangible.Move,
            Stun = {
                Time = 0.2,
                Priority = Enums.Stun.Medium
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                Unblockable = true
            }
        },
        Hit = {
            Damage = 5,
            Priority = Enums.Intangible.Move,
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                Unblockable = true
            }
        },
        Throw = {
            Damage = 5,
            Priority = Enums.Intangible.Move,
            Stun = {
                Time = 0.5,
                Priority = Enums.Stun.Medium
            },
            Ragdoll = {
                Time = 1
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                Unblockable = true
            },
            KnockbackData = { {
                    Type = "Velocity",
                    RelativePart = "Attacker",
                    Velocity = Vector3.new(0, 12, 0),
                    Speed = 60,
                    Time = 0.1
                }, {
                    Type = "AngularVelocity",
                    RelativePart = "Attacker",
                    RelativeVelocity = Vector3.new(12, 0, 0),
                    Time = 0.2
                } },
            HitRemotes = { v11["Heavy Hit"] }
        }
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
    Barrage = TableUtil.Reconcile({
        StandName = "The World: High Voltage",
        Cooldown = {
            Time = 8,
            AfterMove = true
        },
        Hit = {
            HitAnimations = "Default",
            HitRemotes = { v11["Light Hit"] },
            HitSounds = {
                Hit = {
                    SoundId = 13147132473,
                    Volume = 1.5
                }
            }
        },
        Finisher = {
            HitAnimations = "Default",
            HitRemotes = { v11["Heavy Hit"] },
            HitSounds = {
                Hit = {
                    SoundId = 13147133583,
                    Volume = 1.5
                }
            }
        },
        ClashHit = {},
        ClashFinisher = {}
    }, BaseStatsModule.Stand_Barrage),
    Chop = {
        Active = true,
        Damage = 20,
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
            Time = 12,
            AfterMove = true
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.5, 7.5, 7.5),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11["Blood Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17258928596,
                Volume = 1
            }
        }
    },
    Checkmate = {
        Active = true,
        Cooldown = 15,
        Damage = 5,
        HitAnimations = "Default",
        Actionable = {
            Active = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 15),
            Offset = CFrame.new(0, 0, -7)
        },
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Blood",
                        AutoSerialize = true,
                        LookAt = "Attacker"
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 11370985410,
                Volume = 1.5
            }
        },
        Hit = {
            Damage = 20,
            Priority = Enums.Intangible.Move
        },
        Throw = {
            Damage = 30,
            Priority = Enums.Intangible.Move,
            Stun = {
                Time = 0.3
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
                } }
        }
    },
    Alt = {
        Active = true,
        Damage = 20,
        HitAnimations = "Default",
        Actionable = {
            Active = true
        },
        CollisionSounds = {
            Default = {
                ID = 7172258964,
                Props = {
                    Volume = 3,
                    RollOffMaxDistance = 60
                }
            }
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 0,
            Time = 0.1,
            Velocity = Vector3.new(-25, -80, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 17269811539,
                Volume = 1
            }
        },
        Ragdoll = {
            Time = 1.75
        },
        Stun = {
            Time = 1.5
        },
        Priority = Enums.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v11["Heavy Hit"] }
    }
};
v18["Revolver Flank"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Active = true,
    Cooldown = {
        Time = 15
    },
    Damage = 15,
    Stun = {
        Time = 2
    },
    Ragdoll = {
        Time = 0.75
    },
    Block = {
        BlockBreak = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    CollisionSounds = {
        Default = {
            ID = 7172258964,
            Props = {
                Volume = 3,
                RollOffMaxDistance = 60
            }
        }
    },
    HitRemotes = { v11["Blood Hit"] },
    HitSounds = {
        Hit = {
            SoundId = 11165556117,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    Alt = v18.Alt
};
v18.Block = {
    From = "Combat.Block"
};
v18.Flashbang = {
    Active = true,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BypassCounter = true
    },
    Stun = {
        Time = 2.5
    },
    HitRemotes = { {
            Name = "Output",
            Clients = { "__Data.TargetPlayer" },
            Arguments = { "FX", "Flashbang_Blind", "__Target" }
        } },
    HitAnimations = { 17268173582 }
};
v18.Timestop = {
    Speed = 1.2,
    Active = true,
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
    Sequence = {
        { 0, "PlayAnim", "Timestop" },
        { 0, function(p19, p20, p21) -- Line: 814
                -- upvalues: u1 (copy)
                local v22 = p21.TimestopData.Character.Humanoid.Health <= p21.TimestopData.Character.Humanoid.MaxHealth / 3;
                u1.PlaySound(p21.TimestopData.Character, "Timestop Startup SFX");
                u1.PlaySound(p21.TimestopData.Character, "Timestop Startup Voiceline" .. (v22 and " Panic" or ""));
            end },
        { 0, "CreateTag", "MaxWalkSpeed", 0 },
        { 0, "CreateTag", "MaxJumpPower", 0 },
        { 70, "Timestop" },
        { 70, function(p23, p24, p25) -- Line: 822
                -- upvalues: u1 (copy)
                u1.PlaySound(p25.TimestopData.Character, "Timestop Second Voiceline" .. (p25.TimestopData.Character.Humanoid.Health <= p25.TimestopData.Character.Humanoid.MaxHealth / 3 and " Panic" or ""));
            end },
        { 127, "End" }
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 6,
        Size = 150,
        StopSounds = { "Timestop SFX" },
        ResumeSounds = { "Timeresume SFX", "Timeresume Voice" }
    }
};
v18.Pose = {
    From = "Combat.Pose",
    MusicAmount = 2
};
v18.Quickstep = {
    From = "Combat.Quickstep"
};
v18.Teleport = {
    From = "Combat.Teleport"
};
v18["Blink Execution"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Shoot = {
        Damage = 35,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2.5
        },
        Knockback = {
            RelativePart = "HumanoidRootPart",
            Speed = 36,
            Time = 0.4
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v11["Blood Hit"] }
    },
    Blow = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.5, 7.5, 7.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        Stun = {
            Time = 1
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        HitRemotes = { v11["Heavy Hit"] },
        HitAnimations = { 10046328617 }
    }
};
v18["Fierce Rushdown"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Detect = {
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    },
    Barrage = {
        HitAnimations = "Default",
        Damage = 3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 1
        },
        Block = {
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 4,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 17258872772,
                Volume = 3
            }
        },
        HitRemotes = { v11["Light Hit"] }
    },
    Kick = {
        HitAnimations = "Default",
        Damage = 10,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1
        },
        Block = {
            BlockBreak = true
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v11["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17258872993,
                Volume = 3
            }
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 40,
            Time = 0.2
        }
    }
};
v18["Vicious Cleaving"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Punch = {
        HitAnimations = "Default",
        Damage = 5,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(6, 6, 6),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v11["Light Hit"] },
        Knockback = {
            RelativePart = "HumanoidRootPart",
            Speed = 4,
            Time = 0.1
        }
    },
    Cleave = {
        HitAnimations = "Default",
        Damage = 10,
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 10,
            Time = 0.1
        },
        HitRemotes = { v11["Light Hit"] }
    },
    Chop = {
        HitAnimations = "Default",
        Damage = 10,
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Ragdoll = {
            Time = 1.6
        },
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 30,
            Time = 0.1
        },
        HitRemotes = { v11["Heavy Hit"] }
    }
};
v18["Shining Impale"] = {
    Active = true,
    CheckPVPSafe = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Cooldown = {
        Time = 17,
        Manual = true,
        Name = "Shining Impale"
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Hitbox = {
        Size = Vector3.new(10, 8, 23),
        Offset = CFrame.new(0, 0, 0)
    },
    Impale = {
        Damage = 45,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 2
        }
    },
    Stun = {
        Time = 2
    }
};
v18["High Voltage"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Meter = {
        RequiredLevel = 3,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.6,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 9),
            Offset = CFrame.new(0, 0, -4.5)
        }
    },
    Knife = {
        HitAnimations = "Default",
        Block = {
            Unblockable = true,
            Blockable = false,
            PerfectBlockable = false
        },
        CollisionSounds = {
            Default = {
                ID = 7172258964,
                Props = {
                    Volume = 3,
                    RollOffMaxDistance = 60
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 11206836835,
                Volume = 1
            }
        },
        HitRemotes = { v11["Blood Hit"] }
    },
    Release = {
        Damage = 80,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 0, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v11["Blood Hit"], v11["Blood Hit"], v11["Blood Hit"] }
    }
};
v18["Timestop Movement"] = {
    Time = 5,
    Actionable = {
        Timestopped = false
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    }
};

return {
    Stats = v18,
    Animations = {
        Action = {
            Timestop = 17251516277,
            ["Flashing Impale Dash"] = 17268791691,
            ["Flashing Impale"] = 17269013347,
            ["Flashing Impale Target"] = 17269047050,
            ["Lethal Grasp User"] = 11115698996,
            ["Lethal Grasp Startup"] = 11158572027,
            ["Lethal Grasp Target"] = 11158578424,
            ["Lethal Grasp"] = 11158575954,
            ["Vicious Cleaving User"] = 17256859356,
            ["Vicious Cleaving Stand"] = 17256919586,
            ["Revolver Flank Fire"] = 11102588253,
            ["Revolver Flank Surprise 1"] = 11102592463,
            ["Revolver Flank Surprise 2"] = 11102594037,
            ["Checkmate Startup"] = 11191115479,
            ["Checkmate Loop"] = 11191121324,
            ["Checkmate Throw"] = 11191129573,
            ["Blink Execution Blow"] = 10905193306,
            ["Blink Execuction Fire"] = 10900013938,
            ["Blink Execution Target"] = 11102596215,
            TWHVBackshot = 11102592463,
            TWHVBackshot2 = 11102594037,
            VictimPowderFire = 11102596215,
            ["Grenade Throw"] = 10672569011,
            VictimBlinded = 0,
            Chop = 11116663362,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            ["LMB-1"] = 10899679325,
            ["LMB-2"] = 10899681628,
            ["LMB-3"] = 10899683751,
            ["LMB-4"] = 10899685767,
            ["StandOff-LMB-1"] = 10856902374,
            ["StandOff-LMB-2"] = 10856903521,
            ["StandOff-LMB-3"] = 10856904632,
            ["StandOff-LMB-4"] = 10856905614,
            KnivesOutStartup = 10446639889,
            KnivesOut = 7037887987,
            ["Fierce Rushdown"] = 17247219801,
            PoseTransition = 8062693425,
            PoseIdle = 8062689014
        },
        Idle = {
            Idle = 10657388898,
            SummonedIdle = 10657384866
        },
        Movement = {
            Walk = 10663962417,
            Run = 10657396383,
            SummonedRun = 10657396383,
            SummonedWalk = 10663962417,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        }
    },
    Sounds = {
        ["Shining Impale Startup"] = {
            SoundId = 17283844458,
            Volume = 1
        },
        ["Shining Impale Voiceline"] = {
            SoundId = 17283844308,
            Volume = 1
        },
        ["Shining Impale SFX"] = {
            SoundId = 17283844081,
            Volume = 1
        },
        ["Chop Voiceline"] = {
            SoundId = 17258928434,
            Volume = 1
        },
        ["Chop SFX"] = {
            SoundId = 17258926647,
            Volume = 1
        },
        ["Lethal Grasp SFX"] = {
            SoundId = 17259070083,
            Volume = 1
        },
        ["Lethal Grasp Startup Voiceline"] = {
            SoundId = 17260189978,
            Volume = 1
        },
        ["Lethal Grasp Startup"] = {
            SoundId = 17259073973,
            Volume = 1
        },
        ["Blink Execution SFX"] = {
            SoundId = 17267758370,
            Volume = 1
        },
        ["Blink Execution Shoot"] = {
            SoundId = 17267758950,
            Volume = 1
        },
        ["Blink Execution Startup Voiceline"] = {
            SoundId = 17267758767,
            Volume = 1
        },
        ["Blink Execution Startup"] = {
            SoundId = 17267758502,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 17260237434,
            Volume = 1
        },
        ["Desummon-Voiceline"] = {
            SoundId = 17260237192,
            Volume = 1
        },
        ["Fierce Rushdown User"] = {
            SoundId = 17258872561,
            Volume = 1
        },
        ["Fierce Rushdown Stand"] = {
            SoundId = 17258905127,
            Volume = 1
        },
        ["Fierce Rushdown Voiceline"] = {
            SoundId = 17258905237,
            Volume = 1
        },
        ["Flashbang SFX"] = {
            SoundId = 17268460487,
            Volume = 1
        },
        ["Flashbang Voiceline"] = {
            SoundId = 17268460619,
            Volume = 1
        },
        ["Vicious Cleaving Startup"] = {
            SoundId = 17267661477,
            Volume = 1
        },
        ["Vicious Cleaving Stand"] = {
            SoundId = 17267661705,
            Volume = 1
        },
        ["Vicious Cleaving Voiceline"] = {
            SoundId = 17267661958,
            Volume = 1
        },
        SummonSound = {
            SoundId = 5602282309,
            Volume = 1
        },
        Teleport = {
            SoundId = 6773724319,
            Volume = 1
        },
        ["Revolver Flank"] = {
            SoundId = 17269811727,
            Volume = 1
        },
        ["Revolver Flank Voiceline"] = {
            SoundId = 17269811628,
            Volume = 1
        },
        ["Revolver Flank Stand"] = {
            SoundId = 17269811859,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 11206832063,
            Volume = 1
        },
        Barrage = {
            SoundId = 11206831402,
            Volume = 1
        },
        ["Checkmate Activation SFX"] = {
            SoundId = 11206834039,
            Volume = 1
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = 11206834662,
            Volume = 1
        },
        ["Checkmate Windup"] = {
            SoundId = 11206836144,
            Volume = 1
        },
        Knives_Hit = {
            SoundId = 11206836835,
            Volume = 1
        },
        Knives_Ding = {
            SoundId = 11206837650,
            Volume = 1
        },
        Knives_Ting = {
            SoundId = 11206839775,
            Volume = 1
        },
        ["Timestop Second Voiceline"] = {
            SoundId = 17269822232,
            Volume = 1
        },
        ["Timestop Startup Voiceline"] = {
            SoundId = 17269822418,
            Volume = 1
        },
        ["Timestop Startup SFX"] = {
            SoundId = 17269822305,
            Volume = 1
        },
        ["Timestop SFX"] = {
            SoundId = 17269822500,
            Volume = 1
        },
        ["Timestop Startup Voiceline Panic"] = {
            SoundId = 17269822587,
            Volume = 1
        },
        ["Timestop Second Voiceline Panic"] = {
            SoundId = 136868927163873,
            Volume = 1
        },
        ["Timeresume Voice"] = {
            SoundId = 13147263792,
            Volume = 1
        },
        ["Timeresume SFX"] = {
            SoundId = 13147267393,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 13159240419,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 13159242396,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 17269719953,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 17269720059,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 10858770933,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 10858772044,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 17269708490,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 17269708609,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 17269708422,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 17269708705,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 17269725414,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 17269725503,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 17269725627,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10858776537,
            Volume = 1
        },
        KnivesOutStartup = {
            SoundId = 13169011988,
            Volume = 1
        },
        KnivesOutStartupVoice = {
            SoundId = 13169012459,
            Volume = 1
        },
        KnivesOut = {
            SoundId = 13169012233,
            Volume = 1
        },
        KnivesOutVoice = {
            SoundId = 13169012083,
            Volume = 1
        },
        ["PoseMusic-1"] = {
            SoundId = 17288139149,
            Volume = 1
        },
        ["PoseMusic-2"] = {
            SoundId = 120762996839323,
            Volume = 2
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
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Lethal Grasp"] = {
                DefaultKeybind = "G",
                State = "Universal",
                Unlocked = true,
                Description = "Snap the neck of a target before kicking them away."
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Unleash constant blows as the key is held before finishing with a heavy punch."
            },
            ["Fierce Rushdown"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Swiftly summon your stand upon the nearest target and unleash a quick barrage."
            },
            ["Vicious Cleaving"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Strike in front of you  and summon your stand that  follows up with a combo of pummels if landed."
            },
            Chop = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Perform a quick chop."
            },
            Checkmate = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Throw multiple knives in front of you.",
                LevelRequirement = 25
            },
            ["Revolver Flank"] = {
                DefaultKeybind = "Y+",
                State = "StandOff",
                Description = "Fire a revolver bullet, summoning your stand behind the target which then pummels them into the ground.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Blink Execution"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Throw out a jab and stop time briefly and shooting the victim in the head from behind upon contact.",
                LevelRequirement = 30
            },
            ["Shining Impale"] = {
                DefaultKeybind = "Y+",
                State = "StandOn",
                Description = "Dash forward and quickly impale your fist through a foe\'s chest.",
                LevelRequirement = 30
            },
            Flashbang = {
                DefaultKeybind = "Y",
                Description = "Throw a flashbang at where your cursor is aimed.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Stop time within a radius.",
                LevelRequirement = 100
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "H+",
                Description = "You can now move for 1-2 seconds in an existing timestop.",
                LevelRequirement = 80
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleports you a short distance.",
                LevelRequirement = 10
            },
            ["High Voltage"] = {
                DefaultKeybind = "Z",
                State = "StandOn",
                Description = "Unleash a strong punch before following up with a timestop and knife barrage.",
                LevelRequirement = 110
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
                    SoundId = "rbxassetid://12938587905",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The winds of victory are at this Dio\'s back..."
                        } }
                }, {
                    SoundId = "rbxassetid://12938590515",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The end will come before you even stop!"
                        } }
                }, {
                    SoundId = "rbxassetid://12938591675",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What point is there in doing that? It\'s useless! MUDAAA!!"
                        } }
                }, {
                    SoundId = "rbxassetid://12938592660",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Let\'s get this over with."
                        } }
                }, {
                    SoundId = "rbxassetid://12938593802",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll say it again. Come near me, and I\'ll kill you."
                        } }
                } }
        }
    }
};