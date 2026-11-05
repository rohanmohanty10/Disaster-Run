  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local u1;

if game:GetService("RunService"):IsServer() then
    local v2 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    u1 = require(v2.Common);
else
    u1 = nil;
end;

local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 30
    -- upvalues: u4 (ref), Middleware (copy), u3 (ref), Knit (copy)
    u4 = Middleware.GetMiddleware("CombatService");
    u3 = Knit.GetService("EffectService");
end);
local v6 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 10,

        PointCap = function(p5) -- Line: 54, Name: PointCap
            return 1;
        end
    }
};
v6.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitRemotes = { v6.Resources.LightHit },
        HitSounds = v6.Resources.LMB1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p7, p8, p9, p10) -- Line: 80
                    -- upvalues: u1 (ref), TableUtil (copy)
                    u1:CreateServant(TableUtil.Reconcile({
                        Animation = "Servant-LMB-1",
                        Speed = p7:GetSpeed()
                    }, p9));
                end },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 21, 24, "Attack" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 0, function(p11, p12, p13, p14) -- Line: 94
                    -- upvalues: u1 (ref), TableUtil (copy)
                    u1:CreateServant(TableUtil.Reconcile({
                        Animation = "Servant-LMB-2",
                        Speed = p11:GetSpeed()
                    }, p13));
                end },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 22, 27, "Attack" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 0, function(p15, p16, p17, p18) -- Line: 108
                    -- upvalues: u1 (ref), TableUtil (copy)
                    u1:CreateServant(TableUtil.Reconcile({
                        Animation = "Servant-LMB-3",
                        Speed = p15:GetSpeed()
                    }, p17));
                end },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 23, 30, "Attack" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitRemotes = { v6.Resources.HeavyHit },
        HitSounds = v6.Resources.LMB2,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 4" },
            { 0, function(p19, p20, p21, p22) -- Line: 127
                    -- upvalues: u1 (ref), TableUtil (copy)
                    u1:CreateServant(TableUtil.Reconcile({
                        Animation = "Servant-LMB-4",
                        Speed = p19:GetSpeed()
                    }, p21));
                end },
            { 22, function(p23, p24, p25, p26) -- Line: 133
                    -- upvalues: u4 (ref), u3 (ref)
                    local AttackStats = p26.AttackStats;
                    local _ = p25.Player;
                    local Character = p25.Character;
                    local v27 = p25.RootPart.CFrame * AttackStats.Hitbox.Offset;
                    u4.PlaySound(Character, "LMB-4-Slam");
                    u3.FireAllClients("Slam Effect", {
                        Character = Character,
                        Origin = v27,
                        Radius = AttackStats.Hitbox.Size
                    });
                end },
            { 22, 24, "Attack" },
            { 30, "End" }
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -10)
        },
        Ragdoll = {
            Time = 0.6
        },
        Stun = {
            Time = 0.35,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 20,
            Time = 0.1,
            Velocity = Vector3.new(0, 25, 0)
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v6.Stats.Block = {
    From = "Combat.Block"
};
v6.Stats.Grab = {
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
v6.Stats.Shift = {
    Distance = 20,
    Active = true,
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8
    },

    Invoke = function(p28) -- Line: 236, Name: Invoke
        -- upvalues: Knit (copy)
        local Character = game.Players.LocalPlayer.Character;
        local Stats = p28.Stats;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v29 = Knit.GetService("MoveInputService");

        if Knit.CollectionService:HasTag(Character, "Timestopped") then
            return;
        end;

        local v30 = RaycastParams.new();
        v30.FilterType = Enum.RaycastFilterType.Exclude;
        v30.FilterDescendantsInstances = { Character, workspace.Effects, workspace.ItemSpawns };
        local v31 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Distance = Stats.Distance;
        local v32 = workspace:Raycast(HumanoidRootPart.Position, v31 * Distance, v30);

        if v32 then
            Distance = (HumanoidRootPart.Position - v32.Position).Magnitude;
        end;

        local Position = HumanoidRootPart.Position;
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v31).LookVector.Unit * Distance;
        v29:FireInput(p28.RawInput, Position, HumanoidRootPart.Position);
        task.wait(0.25);
    end
};
v6.Stats["God of Death"] = {
    Active = true,
    InitialMeterDrainRate = 2,
    MeterDrainRateIncrease = 0.5,
    MaxMeterDrainRate = 50,
    MeterDrainFromDamageMultiplier = 0.25,
    MeterDrainPerAttack = 1,
    Increment = 6,
    MinSpeed = 18,
    MaxSpeed = 32,
    Timescale = 1.25,
    Actionable = {
        Active = true,

        Check = function(p33) -- Line: 281, Name: Check
            return not p33:GetAttribute("GodOfDeath");
        end
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 52,
        Manual = true
    },
    Self = {
        Priority = 5000000,
        Damage = 3,
        TrueDamage = true,
        Meter = {
            MeterGain = 0
        },
        Block = {
            BypassCounter = true,
            Unblockable = true
        }
    }
};
v6.Stats["Death Whisper"] = {
    Active = true,
    Damage = 18,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 22),
        Offset = CFrame.new(0, 0, -11)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitSounds = v6.Resources.Whisper,
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Deathly Whisper",
            Overrides = {
                Strength = 0.25
            }
        } },
    Stun = {
        Time = 1.5
    }
};
v6.Stats["Death Claws"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Second = {
        Damage = 15,
        Stun = {
            Time = 1
        },
        HitSounds = v6.Resources.DeathClaws1,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitRemotes = { v6.Resources.LightHit },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = true,
            Offset = CFrame.new(0, 0, -4)
        }
    },
    First = {
        Damage = 10,
        Stun = {
            Time = 1
        },
        HitSounds = v6.Resources.DeathClaws1,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitRemotes = { v6.Resources.LightHit },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = true,
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Third = {
        Damage = 20,
        Stun = {
            Time = 1
        },
        HitSounds = v6.Resources.DeathClaws2,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1
        },
        HitRemotes = { v6.Resources.HeavyHit },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = true,
            Offset = CFrame.new(0, 0, -4)
        }
    }
};
v6.Stats.Ghast = {
    Active = true,
    Damage = 3.6363636363636367,
    Frequency = 2,
    HitAnimations = "Default",
    Stun = {
        Time = 1
    },
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitRemotes = { v6.Resources.LightHit },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    HitSounds = v6.Resources.Ghast
};
v6.Stats["Death\'s Grasp"] = {
    Active = true,
    Damage = 20,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 21,
        AfterMove = true
    },
    HitSounds = v6.Resources.Grasp,
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Stun = {
        Time = 2.5
    },
    Hitbox = {
        Size = 20,
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.identity
    }
};
v6.Stats.Remedy = {
    Active = true,
    Heal = 3,
    Frequency = 4,
    Actionable = {
        Active = true,

        Check = function(p34) -- Line: 532, Name: Check
            return not p34:GetAttribute("GodOfDeath");
        end
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20,
        CanQueryCaster = true,
        FriendlyFire = true,
        Offset = CFrame.identity
    },
    PartyHeal = {
        Heal = 24
    }
};
v6.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(u35, p36) -- Line: 555, Name: PoseTransition
            -- upvalues: AssetHandler (copy), ParticleHandler (copy), u3 (ref)
            for i = 1, 2 do
                local _ = u35.Character;
                local Animator = u35.Animator;
                local RootPart = u35.RootPart;
                local u37 = AssetHandler.CloneAsset("Models/Servant", u35);
                u37.Parent = workspace.Effects;
                local u38 = ParticleHandler.AttachTo(u37.HumanoidRootPart, {
                    Part = RootPart
                });
                u35.Trove:Add(function() -- Line: 570
                    -- upvalues: u38 (copy), u37 (copy), u3 (ref), u35 (copy), ParticleHandler (ref)
                    u38:Destroy();
                    u37.HumanoidRootPart.Anchored = true;
                    local Torso = u37:FindFirstChild("Torso");
                    u3.FireAllClients("Emit Particle V3", {
                        Path = "Particles/ServantDesummon",
                        AbilityName = "Shinigami",
                        AutoSerialize = true,
                        AttachTo = {
                            Part = Torso
                        },
                        SkinName = u35.SkinName
                    });
                    local v39 = next;
                    local v40, v41 = u37:GetDescendants();

                    for _, v in v39, v40, v41 do
                        if v:IsA("BasePart") or (v:IsA("Decal") or v:IsA("Texture")) then
                            game.TweenService:Create(v, TweenInfo.new(0.1), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;

                    ParticleHandler.EnableAllParticles(u37, false);
                    task.delay(5, u37.Destroy, u37);
                end);
                local v42 = Animator:GetAnimation("Servant-PoseTransition-" .. i);

                if v42 then
                    local v43 = u37.AnimationController:LoadAnimation(v42.Animation);
                    v43:Play(nil, nil, 1);
                    v43.Stopped:Connect(function() -- Line: 601
                        -- upvalues: Animator (copy), i (copy), u37 (copy)
                        local v44 = Animator:GetAnimation("Servant-PoseIdle-" .. i);

                        if v44 then
                            u37.AnimationController:LoadAnimation(v44.Animation):Play(nil, nil, 1);
                        end;
                    end);
                end;
            end;
        end
    }
};
v6.Stats.Nightmare = {
    Active = true,
    CheckPVPSafe = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.identity
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Nightmare",
            Overrides = {
                Lifetime = 3
            }
        } },
    HitSounds = v6.Resources.Nightmare
};
v6.Stats["Phantom Legion"] = {
    CheckPVPSafe = true,
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 100
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 40,
        Manual = true
    },
    Block = {
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 50,
        Offset = CFrame.identity
    }
};
v6.Stats.Banishment = {
    Active = true,
    FinisherPercent = 10,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -3)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true
        }
    },
    Impale = {
        Damage = 25,
        Priority = Enums.Intangible.Move
    },
    Finisher = {
        Damage = 300,
        Priority = Enums.Intangible.Move
    },
    Throw = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 60,
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
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v6.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v6.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v6;