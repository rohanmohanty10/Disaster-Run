  

 

local ServerScriptService = game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref), RunService (copy), ServerScriptService (copy), u4 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");

    if RunService:IsServer() then
        local v5 = ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Name, true);
        u4 = require(v5.Common);
    end;
end);
local v6 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Base = {
                Visible = true,
                Priority = 2
            },
            Rage = {
                Visible = false,
                Priority = 3
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v6.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    MaxCombo = 4,
    ComboTick = 2.3,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, function(p7, p8, p9) -- Line: 93
                    -- upvalues: u4 (ref)
                    u4.SetEnderflow({
                        Name = "LMB-1",
                        Duration = 3,
                        Attacker = p9.Character
                    });
                end },
            { 23, 26, "Attack" },
            { 30, "End" }
        },
        HitSounds = {
            Hit = v6.Resources.LMBHits[1]
        },
        HitRemotes = { v6.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Endlag = 0.6,
        Sequence = {
            { 0, "Start" },
            { 0, function(p10, p11, p12) -- Line: 116
                    -- upvalues: u4 (ref)
                    u4.SetEnderflow({
                        Name = "LMB-2",
                        Duration = 3,
                        Attacker = p12.Character
                    });
                end },
            { 23, 26, "Attack" },
            { 30, "End" }
        },
        HitSounds = {
            Hit = v6.Resources.LMBHits[2]
        },
        HitRemotes = { v6.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, function(p13, p14, p15) -- Line: 137
                    -- upvalues: u4 (ref)
                    u4.SetEnderflow({
                        Name = "LMB-3",
                        Duration = 3,
                        Attacker = p15.Character
                    });
                end },
            { 23, 26, "Attack" },
            { 30, "End" }
        },
        HitSounds = {
            Hit = v6.Resources.LMBHits[3]
        },
        HitRemotes = { v6.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, function(p16, p17, p18) -- Line: 158
                    -- upvalues: u4 (ref)
                    u4.SetEnderflow({
                        Name = "LMB-4",
                        Duration = 3,
                        Attacker = p18.Character
                    });
                end },
            { 23, 26, "Attack" },
            { 30, "End" }
        },
        HitSounds = {
            Hit = v6.Resources.LMBHits[4]
        },
        HitRemotes = { v6.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v6.Stats.Block = {
    From = "Combat.Block"
};
v6.Stats.Quickstep = {
    From = "Sorcerer Killer.Breakneck Dash",
    Cooldown = {
        Name = "Quickstep"
    }
};
v6.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p19, p20) -- Line: 195, Name: PoseTransition
            -- upvalues: AssetHandler (copy), ParticleHandler (copy)
            local v21 = AssetHandler.GetAbilityData(p19.Character);
            v21.AbilityName = "Garou";

            for _, v in { "Left", "Right" } do
                local v22 = p20.Trove:Add(AssetHandler.CloneAsset("Particles/ElbowMove/Trail", v21));
                v22.Parent = p19.Character:FindFirstChild((`{v} Arm`));
                local v23 = ParticleHandler.GetUnusualHSVData({
                    Character = p19.Character
                });

                if v23 ~= nil then
                    ParticleHandler.Unusualify(v22, {
                        HSVData = v23
                    });
                end;
            end;

            local v24 = p20.Trove:Add(AssetHandler.CloneAsset("Models/PoseRock", v21));
            v24.Name = "rock";
            local v25 = p20.Trove:Add(v24.rock);
            v25.Part0 = p19.RootPart;
            v25.Parent = p19.RootPart;
            v24.Parent = p19.Character;
        end
    }
};
v6.Stats.Enderflow = {
    Active = true,
    Damage = 45,
    Stun = 1.35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17,
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
        RelativeTowards = "Target",
        Speed = 40,
        Time = 0.25,
        Velocity = Vector3.new(0, 15, 0)
    },
    HitRemotes = { v6.Resources.LightHit },
    HitSounds = {
        Hit = v6.Resources.PressueWaveKickHitSound
    }
};
v6.Stats["Water Stream Rock Smashing Fist"] = {
    Active = true,
    Damage = 3,
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
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    },
    Stun = {
        Time = 0.95
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitRemotes = { v6.Resources.BarrageHit },
    HitSounds = {
        Hit = v6.Resources.LMBHits[1]
    }
};
v6.Stats["Pressure Wave Kick"] = {
    MaxHoldDuration = 2,
    Active = true,
    Damage = 25,
    Stun = 1.35,
    HitAnimations = "Default",
    HeldAdjust = { "Damage", "Stun" },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
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
        RelativeTowards = "Target",
        Speed = 30,
        Time = 0.25
    },
    HitRemotes = { v6.Resources.LightHit },
    HitSounds = {
        Hit = v6.Resources.PressueWaveKickHitSound
    }
};
v6.Stats["Rock Slam"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Slam = {
        Damage = 45,
        Stun = 1.5,
        HitAnimations = "Default",
        Hitbox = {
            Size = 15
        },
        Block = {
            BlockBreak = true
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 30,
            Time = 0.25,
            Velocity = Vector3.new(0, 10, 0)
        },
        Ragdoll = {
            Time = 1.5,
            Intangible = Enums.Intangible.SoftRagdoll
        },
        Priority = Enums.Intangible.SoftRagdoll
    }
};
v6.Stats["Rock Throw"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Rock = {
        Damage = 12,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        HitRemotes = { v6.Resources.LightHit },
        Priority = Enums.Intangible.SoftRagdoll,
        HitSounds = v6.Resources.RockHitSound
    }
};
v6.Stats["Springburst Counter"] = {
    Active = true,
    HitAnimations = "Default",
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
    Hit = {
        Damage = 35,
        Stun = 1.5,
        Ragdoll = 1.5,
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 30,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } }
    }
};
v6.Stats["Tidal Impact"] = {
    Active = true,
    Damage = 45,
    Stun = 1.35,
    HitAnimations = "Default",
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
    Hitbox = {
        Size = 15
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false,
        Blockable = false
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 45,
        Time = 0.25,
        Velocity = Vector3.new(0, 15, 0)
    },
    Ragdoll = {
        Time = 1.5,
        Intangible = Enums.Intangible.SoftRagdoll
    },
    Priority = Enums.Intangible.Ragdoll
};
v6.Stats["Rageful Slam"] = {
    Active = true,
    Damage = 75,
    Stun = 1.35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(15, 12, 40),
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.new(0, 3, -19.5)
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false,
        Blockable = false
    },
    Knockback = {
        Speed = 30,
        Time = 0.15,
        Velocity = Vector3.new(0, 75, 0)
    },
    Ragdoll = {
        Time = 1.5,
        Intangible = Enums.Intangible.SoftRagdoll
    },
    Priority = Enums.Intangible.SoftRagdoll
};
v6.Stats["Rage Mode"] = {
    Active = true,
    Duration = 40,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 100,
        Manual = true
    },
    Meter = {
        RequiredAmount = 100
    },
    ModeStats = {
        Attack = 30,
        Defense = 30,
        Special = 15
    },
    Scream = {
        Damage = 3,
        HitAnimations = "Default",
        Hitbox = {
            Size = 15
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 1,
            Time = 0.1
        },
        Stun = {
            Time = 0.95
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitRemotes = { v6.Resources.BarrageHit }
    },
    Slam = {
        Damage = 45,
        Stun = 1.35,
        HitAnimations = "Default",
        Hitbox = {
            Size = 20
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false,
            Blockable = false
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 30,
            Time = 0.25
        },
        Ragdoll = {
            Time = 1.5,
            Intangible = Enums.Intangible.SoftRagdoll
        },
        Priority = Enums.Intangible.SoftRagdoll
    }
};
v6.Stats.Grab = {
    From = "Standless.Grab"
};
v6.Stats["Reverse Current"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Attempt = {
        Damage = 15,
        Stun = 1,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            BlockBreak = true
        },
        HitRemotes = { v6.Resources.LightHit },
        HitSounds = {
            Hit = v6.Resources.ReverseCurrentHitSounds[1]
        }
    },
    Success = {
        Damage = 25,
        Stun = 1.35,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false,
            Blockable = false
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 30,
            Time = 0.25
        },
        HitRemotes = { v6.Resources.LightHit },
        HitSounds = {
            Hit = v6.Resources.ReverseCurrentHitSounds[2]
        }
    }
};
v6.Stats["Watchdog Style"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 45
    },
    Start = {
        Hitbox = {
            Size = Vector3.new(6, 6, 6),
            Offset = CFrame.new(0, 0, -3)
        }
    },
    LoveTaps = {
        Damage = 2.5,
        Priority = Enums.Intangible.Move
    },
    Kick = {
        Damage = 7.5,
        Priority = Enums.Intangible.Move
    },
    DropKick = {
        Damage = 12.5,
        Priority = Enums.Intangible.Move
    },
    Claw = {
        Damage = 7.5,
        Priority = Enums.Intangible.Move
    },
    Slap = {
        Priority = Enums.Intangible.Move
    },
    BarrageHit = {
        Damage = 3,
        Priority = Enums.Intangible.Move
    },
    PreFinalHit = {
        Damage = 10,
        Priority = Enums.Intangible.Move
    },
    FinalHit = {
        Damage = 35,
        Stun = 1.35,
        Ragdoll = 1.3,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "TargetRootPart",
            Time = 0.2,
            Speed = 70,
            Velocity = Vector3.new(0, 20, 0)
        }
    }
};

return v6;