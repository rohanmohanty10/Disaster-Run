  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v2 = {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            User = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 20,

        PointCap = function(p1) -- Line: 39, Name: PointCap
            return 1;
        end
    }
};

local function Invoke(p3) -- Line: 45
    -- upvalues: Knit (copy)
    local Input2 = p3.Input;
    local v4 = Knit.GetController("MoveInputController");
    local v5 = Knit.GetService("MoveInputService");
    local v6 = os.clock();
    local v7 = false;

    while v4.Inputs[Input2] do
        if os.clock() - v6 >= 0.2 then
            v7 = true;
            break;
        end;

        task.wait();
    end;

    v5:FireInput(p3.RawInput, v7):expect();
end;

local function AirInvoke(p8) -- Line: 64
    -- upvalues: Knit (copy)
    local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
    Knit.GetController("MoveInputController");
    Knit.GetService("MoveInputService"):FireInput(p8.RawInput, Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall):expect();
end;

v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        ActiveEndlag = 0.15,
        Sequence = { { 0, "Start" }, { 26, 30, "Attack" }, { 37, "End" } },
        Stun = {
            Time = 0.6
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.RushAttack1SFX }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 25, function(p9, p10, p11) -- Line: 128
                    -- upvalues: Knit (copy)
                    if p11.SkinName == "The Strongest In History" then
                        Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                            Path = "Particles/Dismantle/Sweep",
                            Origin = p11.RootPart,
                            Offset = CFrame.new(-1, 0, -3.25) * CFrame.Angles(-1.5707963267948966, 0, -1.5707963267948966),
                            Player = p11.Player
                        });
                    end;
                end },
            { 25, 29, "Attack" },
            { 38, "End" }
        },
        HitSounds = { v2.Resources.RushAttack2SFX }
    },
    ["LMB-3"] = {
        Speed = 1.75,
        Sequence = {
            { 0, "Start" },
            { 30, function(p12, p13, p14) -- Line: 153
                    -- upvalues: Knit (copy)
                    if p14.SkinName ~= "The Strongest In History" then
                        Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                            Path = "Particles/Dismantle/Sweep",
                            Origin = p14.RootPart,
                            Offset = CFrame.new(-1, 0, -3.25) * CFrame.Angles(-1.5707963267948966, 0, -1.5707963267948966),
                            Player = p14.Player
                        });
                    end;
                end },
            { 30, 34, "Attack" },
            { 55, "End" }
        },
        HitSounds = { v2.Resources.RushAttack3SFX }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 2,
        ActiveEndlag = 0.15,
        Sequence = { { 0, "Start" }, { 40, 48, "Attack" }, { 68, "End" } },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.RushAttack4SFX }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Stats.Block = {
    From = "Combat.Block"
};
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};
v2.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p15, p16) -- Line: 211, Name: PoseTransition
            -- upvalues: AssetHandler (copy)
            local Character = p15.Character;
            local _ = p15.Stats;
            local _ = p15.AbilityModel;
            local v17 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("King of Curses", true);
            local Common = require(v17.Common);
            local v18 = AssetHandler.CloneAsset("Models/Throne", p15);
            p16.Trove:Add(v18);
            Common:HSVShiftParticles(v18, p15);
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Part0 = p15.RootPart;
            Motor6D.Part1 = v18.ThronePart;
            Motor6D.C0 = CFrame.new(-0.081, -2.588, 0.161);
            Motor6D.Parent = v18.ThronePart;
            v18.Parent = Character;
        end
    }
};
v2.Stats["You Can Die Here (Ground)"] = {
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
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
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Kick = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Grab = {
        Damage = 3,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slam = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    ExternalSlam = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.25,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            Type = "Velocity",
            RelativePart = "Attacker",
            Speed = 24,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        },
        HitRemotes = { v2.Resources.HeavyHit }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 0,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v2.Stats["You Can Die Here (Air)"] = {
    Startup = {
        Grab = true,
        MinHealth = 1,
        Damage = 10,
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockCancel = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 14, 10),
            Predict = false,
            Offset = CFrame.new(0, -2, -5)
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Slam = {
        Damage = 12.5,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    ExternalSlam = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.25,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -8)
        },
        Knockback = {
            Type = "Velocity",
            RelativePart = "Attacker",
            Speed = 24,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        },
        HitRemotes = { v2.Resources.HeavyHit }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.45,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 0,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v2.Stats["You Can Die Here"] = {
    Active = true,
    AttackPriority = "Heavy",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Invoke = AirInvoke
};
v2.Stats["Fiendish Rush"] = {
    Active = true,
    AttackPriority = "Medium",
    CheckPVPSafe = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Name = "Fiendish Rush",
        Manual = true,
        AfterMove = true,
        Client = false
    },
    Search = {
        RelativePart = "HumanoidRootPart",
        Size = 48,
        Offset = CFrame.new(0, 0, 0)
    },
    Strike = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 1.25
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 12, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.FiendishRushSFX }
    },
    BlackFlash = {
        Damage = 35,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Ragdoll = {
            Time = 2.5,
            Intangible = false
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 12, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1
        },
        HitSounds = { v2.Resources.BlackFlash }
    },
    Extend = {
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.SoftRagdoll
        },
        KnockbackData = { {
                RelativePart = "Attacker",
                Speed = 24,
                Velocity = Vector3.new(0, 12, 0),
                MaxForce = Vector3.new(100000, 100000, 100000),
                Time = 0.5
            }, {
                Type = "Force",
                Force = Vector3.new(0, 300, 0),
                Time = 1.75
            } }
    },
    Kick = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        HitRemotes = { v2.Resources.LightHit },
        HitSounds = { v2.Resources.FiendishRushSFX }
    },
    Grab = {
        Grab = true,
        Meter = false,
        Stun = {
            Time = 1.25
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v2.Resources.LightHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Offset = CFrame.new(0, 0, -5)
        }
    },
    Slam = {
        MinHealth = 1,
        Damage = 15,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    ExternalSlam = {
        Damage = 20,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.25,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -4.5)
        },
        Knockback = {
            Type = "Velocity",
            RelativePart = "Attacker",
            Speed = 24,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        },
        HitRemotes = { v2.Resources.HeavyHit }
    },
    Grind = {
        MinHealth = 1,
        Damage = 0.1388888888888889,
        ProcCoefficient = 0.027777777777777776,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 25,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 0.75,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 36, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v2.Resources.FiendishFinisher }
    },
    Invoke = AirInvoke
};
v2.Stats["Axe Kick (Ground)"] = {
    Kick = {
        Damage = 30,
        HitAnimations = "Default",
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false,
            Parryable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Speed = 12,
                Velocity = Vector3.new(0, -24, 0),
                Time = 0.25
            } },
        HitRemotes = { v2.Resources.HeavyHit }
    },
    Slam = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.new(0, 0, -4)
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Speed = 12,
                Velocity = Vector3.new(0, -24, 0),
                Time = 0.25
            } },
        HitRemotes = { v2.Resources.HeavyHit }
    }
};
v2.Stats["Axe Kick (Air)"] = {
    Kick = {
        Damage = 25,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.25,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 12, 8),
            Offset = CFrame.new(0, -2, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Velocity = Vector3.new(0, -64, 0),
            Time = 0.1
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.AxeKickAerialSFX }
    }
};
v2.Stats["Axe Kick"] = {
    Active = true,
    AttackPriority = "Heavy",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true,
        Client = false
    },
    Invoke = AirInvoke
};
v2.Stats.Spiderweb = {
    Active = true,
    AttackPriority = "Heavy",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Slash = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2.05,
            Intangible = EnumsModule.Intangible.SoftRagdoll
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 22,
            Offset = CFrame.new(0, 0, 0)
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativeTowards = "Target",
                Speed = 36,
                Velocity = Vector3.new(0, 72, 0),
                Time = 0.1
            }, {
                Type = "Force",
                Force = Vector3.new(0, 350, 0),
                Time = 1.5
            } },
        HitRemotes = { v2.Resources.HeavyHit }
    }
};
v2.Stats["Wicked Breaker"] = {
    Active = true,
    AttackPriority = "Super",
    Actionable = {
        Active = true,
        Ragdolled = false,
        Stunned = false
    },
    Cooldown = {
        Time = 45,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = true
    },
    Break = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Quickstep,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.new(0, 0, 0)
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 85,
            Time = 0.3
        },
        HitRemotes = { v2.Resources.HeavyHit }
    }
};
v2.Stats["Dismantle (Ground 1)"] = {
    AttackPriority = "Light",
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false,
        Manual = true,
        Name = "Dismantle"
    },
    Dismantle = {
        Damage = 15,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 32),
            Offset = CFrame.new(0, 0, -16)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 2,
            Time = 0.1
        },
        HitAnimations = { 113872676946775 }
    },
    Extend = {
        ProcCoefficient = 0,
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.8
        }
    },
    DomainStats = {
        Dismantle = {
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(16, 16, 48),
                Offset = CFrame.new(0, 0, -24)
            }
        }
    }
};
v2.Stats["Dismantle (Ground 2)"] = {
    AttackPriority = "Light",
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false,
        Manual = true,
        Name = "Dismantle"
    },
    Dismantle = {
        Damage = 0.2857142857142857,
        ProcCoefficient = 0.02857142857142857,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 32),
            Offset = CFrame.new(0, 0, -16)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        HitAnimations = { 119874861462396, 139297337411083, 99235109851914, 81463179334730 }
    },
    Finisher = {
        Damage = 5,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 32),
            Offset = CFrame.new(0, 0, -16)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        HitAnimations = { 119874861462396, 139297337411083, 99235109851914, 81463179334730 }
    },
    Extend = {
        ProcCoefficient = 0,
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.5833333333333334
        }
    },
    DomainStats = {
        Dismantle = {
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(16, 16, 48),
                Offset = CFrame.new(0, 0, -24)
            }
        }
    }
};
v2.Stats["Dismantle (Air)"] = {
    AttackPriority = "Medium",
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false,
        Manual = true,
        Name = "Dismantle"
    },
    Meter = {
        RequiredLevel = 1
    },
    Projectile = {
        Damage = 30,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.25,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitSounds = { v2.Resources.DismantleAerialHit }
    },
    Extend = {
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.SoftRagdoll
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        KnockbackData = { {
                RelativePart = "Attacker",
                Speed = 24,
                Velocity = Vector3.new(0, 12, 0),
                MaxForce = Vector3.new(100000, 100000, 100000),
                Time = 0.5
            }, {
                Type = "Force",
                Force = Vector3.new(0, 300, 0),
                Time = 1.75
            } }
    },
    DomainStats = {
        Dismantle = {
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(18, 18, 52),
                Offset = CFrame.new(0, 0, -26)
            }
        }
    }
};
v2.Stats.Dismantle = {
    Active = true,
    CustomPrefix = "RMB",
    Actionable = {
        Active = true
    },

    Invoke = function(p19) -- Line: 1170, Name: Invoke
        -- upvalues: Knit (copy)
        local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
        local v20 = Knit.GetController("MoveInputController");
        local v21 = Knit.GetService("MoveInputService");
        local v22 = os.clock();
        local v23;

        if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            v23 = "Air";
        else
            v23 = false;
        end;

        while v20.Inputs[Input] do
            if os.clock() - v22 >= 0.2 then
                if v23 ~= "Air" then
                    v23 = true;
                    break;
                end;

                if Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    break;
                end;
            end;

            task.wait();
        end;

        local v24 = (Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall) and "Air" or v23;
        v21:FireInput(p19.RawInput, v24):expect();
    end
};
v2.Stats["Shrine Technique (Ground)"] = {
    Active = true,
    AttackPriority = "Medium",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "Shrine Technique",
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
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
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        }
    },
    Slash = {
        Damage = 1,
        MinHealth = 1,
        ProcCoefficient = 0.06666666666666667,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    PercentSlash = {
        Damage = 0,
        MinHealth = 1,
        DamageMod = 15,
        TrueDamage = true,
        ProcCoefficient = 0.06666666666666667,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    ExternalSlash = {
        Damage = 1.3333333333333333,
        MinHealth = 1,
        ProcCoefficient = 0.06666666666666667,
        Meter = false,
        Stun = {
            Time = 0.5
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockCancel = false,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Finisher = {
        Damage = 10,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 96,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Projectile = {
        Damage = 20,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false,
            BypassCounter = false
        },
        HitSounds = { v2.Resources.ShrineTechniqueHit }
    },
    Extend = {
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false,
            BypassCounter = false
        },
        Stun = {
            Time = 1.25
        }
    }
};
v2.Stats["Shrine Technique (Air)"] = {
    Active = true,
    AttackPriority = "Medium",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Name = "Shrine Technique",
        Manual = true,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = false
    },
    Search = {
        RelativePart = "HumanoidRootPart",
        Size = 48,
        Offset = CFrame.new(0, 0, 0)
    },
    Slash = {
        Damage = 5,
        ProcCoefficient = 0.16666666666666666,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, 0)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            MaxForce = Vector3.new(100000, 100000, 100000),
            Time = 0.1
        }
    },
    StunExtend = {
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Stun = {
            Time = 0.35
        }
    },
    RagdollExtend = {
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 0.75,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Velocity = Vector3.new(0, -32, 0),
            MaxForce = Vector3.new(100000, 100000, 100000),
            Time = 0.1
        }
    },
    DomainStats = {
        Dismantle = {
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(16, 16, 16)
            }
        }
    }
};
v2.Stats["Shrine Technique"] = {
    Invoke = AirInvoke
};
v2.Stats["Devil Throw"] = {
    Active = true,
    AttackPriority = "Heavy",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Startup = {
        Grab = true,
        Damage = 5,
        MinHealth = 1,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2.Resources.HeavyHit }
    },
    Release = {
        Damage = 7,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.25,
            Intangible = EnumsModule.Intangible.SoftRagdoll
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Speed = 48,
                Velocity = Vector3.new(0, 48, 0),
                Time = 0.5
            }, {
                Type = "Force",
                Force = Vector3.new(0, 250, 0),
                Time = 0.85
            } },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v2.Stats["Skull Crasher"] = {
    Active = true,
    AttackPriority = "Heavy",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        Name = "Skull Crasher",
        Manual = true,
        AfterMove = true,
        Client = false
    },
    Search = {
        RelativePart = "HumanoidRootPart",
        Size = 48,
        Offset = CFrame.new(0, 0, 0)
    },
    Slam = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.25
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 12, 8),
            Offset = CFrame.new(0, -2, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, -64, 0),
            Time = 0.1
        },
        HitRemotes = { v2.Resources.HeavyHit },
        HitSounds = { v2.Resources.SkullCrasherHit }
    }
};
v2.Stats["Supreme Martial Solution"] = {
    Active = true,
    AttackPriority = "Super",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 24,
        Name = "Supreme Martial Solution",
        Manual = true,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = false
    },
    Search = {
        RelativePart = "HumanoidRootPart",
        Size = 64,
        Offset = CFrame.new(0, 0, 0)
    },
    Strike = {
        Damage = 30,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15,
            Offset = CFrame.new(0, 0, 0)
        },
        KnockbackData = { {
                RelativeTowards = "Target",
                Speed = 32,
                Velocity = Vector3.new(0, 64, 0),
                MaxForce = Vector3.new(100000, 100000, 100000),
                Time = 0.1
            } },
        HitRemotes = {}
    }
};
v2.Stats.Open = {
    Active = true,
    AttackPriority = "Heavy",
    Actionable = {
        Active = true,
        MasteryRank = 8
    },
    Cooldown = {
        Time = 24,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Projectile = {
        Damage = 10,
        EndDamage = 5,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = false
        }
    },
    UltimateProjectile = {
        Damage = 10,
        EndDamage = 20,
        IgnoreDamageScaling = true,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    },
    Explosion = {
        Damage = 20,
        EndDamage = 20,
        IgnoreDamageScaling = true,
        MaxMultiplier = 3,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Size = 14,
            EndSize = 20
        },
        Stun = {
            Time = 1.5
        },
        Ragdoll = {
            Time = 2.3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        }
    },
    UltimateExplosion = {
        Damage = 2,
        ProcCoefficient = 0.02,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Size = 200,
            EndSize = 200,
            Offset = CFrame.new(0, 0, 0)
        },
        Stun = {
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        }
    }
};
v2.Stats["Malevolent Shrine (Cast)"] = {
    AttackPriority = "Ultimate",
    Meter = {
        RequiredAmount = 100,
        RemoveMeter = false
    },
    Cooldown = {
        Name = "Malevolent Shrine",
        Time = 120,
        Manual = true,
        AfterMove = true,
        Client = false
    },
    Burnout = {
        Dismantle = true,
        ["Shrine Technique"] = true,
        ["World Cutting Slash"] = true,
        Spiderweb = true,
        ["Smooth Cruelty"] = true,
        ["Wicked Breaker"] = true,
        Open = true
    },
    Slash = {
        Shrine = true,
        Scaling = 125,
        DamageIndicator = "ShrineDamage",
        IgnoreDamageScaling = true,
        Damage = 0.3,
        EndDamage = 0.8,
        ProcCoefficient = 0,
        Meter = false,
        Recovery = false,
        Priority = EnumsModule.Intangible.Grab,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Stun = {
        Rate = 0.2,
        Distance = 175,
        Shrine = true,
        Meter = false,
        Recovery = false,
        Priority = EnumsModule.Intangible.Grab,
        Stun = {
            Time = 0.1
        },
        Knockback = {
            RelativeTowards = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BypassCounter = true
        }
    },
    AmplifiedSlash = {
        Shrine = true,
        Scaling = 125,
        DamageIndicator = "ShrineDamage",
        IgnoreDamageScaling = true,
        Damage = 0.6,
        EndDamage = 1.2,
        ProcCoefficient = 0.025,
        Meter = false,
        Recovery = false,
        Priority = EnumsModule.Intangible.Grab,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        HitRemotes = { v2.Resources.ShrineHit },
        HitSounds = { v2.Resources.ShrineHitSFX }
    }
};
v2.Stats["Malevolent Shrine (Amplify)"] = {
    Cooldown = {
        Name = "Malevolent Shrine",
        Time = 7.5,
        Manual = true
    }
};
v2.Stats["Malevolent Shrine"] = {
    Active = true,
    Actionable = {
        MasteryRank = 15,
        Active = true,

        Check = function(p25) -- Line: 1868, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v26;

            if p25 then
                v26 = p25:GetAttribute("CantDomain");
            else
                v26 = p25;
            end;

            local v27 = game.Players:GetPlayerFromCharacter(p25);

            if p25 then
                p25 = p25:GetAttribute("ShrineCasted");
            end;

            if v26 and (v27 and not p25) then
                UIOutput:FireClient(v27, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "King of Curses",
                    Verb = "",
                    Subject = "You can\'t use Domain Expansion while inside a Domain."
                });
                UIOutput:FireClient(v27, "PlaySound", "ope_invalid_move");
            end;

            return not v26 or p25;
        end
    }
};
v2.Stats["World Cutting Slash"] = {
    AttackPriority = "Super",
    Active = true,
    Actionable = {
        Active = true,
        MasteryRank = 20
    },
    Meter = {
        RequiredLevel = 3,
        RemoveMeter = true
    },
    Cooldown = {
        Name = "Malevolent Shrine",
        Time = 60,
        AfterMove = true
    },
    Mark = {
        CheckPVPSafe = true,
        InfinityBypass = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Quickstep,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(16, 24, 64),
            Offset = CFrame.new(0, 0, -32)
        },
        Stun = {
            Time = 0.1
        }
    },
    Slash = {
        InfinityBypass = true,
        Damage = 50,
        IgnoreTimestop = true,
        HitAnimations = "Default",
        Meter = false,
        KillEffectId = "KILLEFFECT_28",
        Priority = EnumsModule.Intangible.Quickstep,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        }
    },
    PercentSlash = {
        InfinityBypass = true,
        Damage = 0,
        TrueDamage = true,
        IgnoreTimestop = true,
        HitAnimations = "Default",
        Meter = false,
        KillEffectId = "KILLEFFECT_28",
        Priority = EnumsModule.Intangible.Quickstep,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 2
        }
    }
};
v2.Stats["Smooth Cruelty"] = {
    AttackPriority = "Medium",
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Countered = {
        HitAnimations = "Default",
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        }
    },
    Attack = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            Relative = "Attacker",
            Speed = 48,
            Time = 0.25
        },
        Ragdoll = {
            Time = 2
        },
        Stun = {
            Time = 0.3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        },
        HitRemotes = { v2.Resources.CleaveFinisher }
    }
};

return v2;