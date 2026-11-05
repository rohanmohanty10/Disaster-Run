  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;
local u2;

if game:GetService("RunService"):IsServer() then
    local v3 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Name, true);
    u2 = require(v3.Common);
else
    u2 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 28
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v5 = {
    Stats = {},
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
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 4,

        PointCap = function(p4) -- Line: 60, Name: PointCap
            return 1;
        end
    }
};
v5.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v5.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 1-3" }, { 24, 29, "Attack" }, { 30, "End" } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-2"] = TableUtil.Reconcile({
        Speed = 1.45,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 1-3" }, { 19, 27, "Attack" }, { 32, "End" } },
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-3"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 1-3" }, { 24, 32, "Attack" }, { 35, "End" } },
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.3,
        Cooldown = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 4" }, { 34, 45, "Attack" }, { 50, "End" } },
        HitRemotes = { v5.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["Coin-LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        Speed = 1.3,
        ActiveEndlag = 0.1,
        Damage = 30,
        Stun = 0.75,
        Distance = 2.5,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "Withdraw Change LMB" },
            { 35, function(p6, p7, p8) -- Line: 231
                    -- upvalues: u2 (ref)
                    u2:ThrowCoin(p8);
                end },
            { 60, "End" }
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            Unblockable = true
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["Coin-LMB-2"] = TableUtil.Reconcile({
        Speed = 1.3,
        Damage = 30,
        Stun = 0.75,
        Distance = 2.5,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "Withdraw Change LMB" },
            { 35, function(p9, p10, p11) -- Line: 263
                    -- upvalues: u2 (ref)
                    u2:ThrowCoin(p11);
                end },
            { 60, "End" }
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            Unblockable = true
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["Coin-LMB-3"] = TableUtil.Reconcile({
        Speed = 1.3,
        Damage = 30,
        Stun = 0.75,
        Distance = 2.5,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "Withdraw Change LMB" },
            { 24, function(p12, p13, p14) -- Line: 297
                    -- upvalues: u2 (ref)
                    u2:ThrowCoin(p14);
                end },
            { 37, function(p15, p16, p17) -- Line: 300
                    -- upvalues: u2 (ref)
                    u2:ThrowCoin(p17);
                end },
            { 66, "End" }
        },
        HitRemotes = { v5.Resources.LightHit },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            Unblockable = true
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    Callbacks = {
        StateChecker = function(p18, p19) -- Line: 331, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p18.Stats;

            if not Knit.CollectionService:HasTag(p18.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";

                if p18.Character:GetAttribute("CoinsEquipped") then
                    Stats.CustomPrefix = "Coin-LMB";
                end;
            end;

            return Stats;
        end
    }
};
v5.Stats["Global Detonation"] = {
    Actionable = {
        Active = true,

        Check = function(p20) -- Line: 351, Name: Check
            return p20:GetAttribute("CanDetonate");
        end
    },
    Cooldown = {
        Time = 15,
        Forced = true
    }
};
v5.Stats["Withdraw Change"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p21) -- Line: 364, Name: Check
            return not p21:GetAttribute("CoinsEquipped");
        end
    },
    Cooldown = {
        Time = 505,
        Manual = true
    },
    Meter = {
        RequiredAmount = 20
    }
};
v5.Stats.Pose = {
    From = "Combat.Pose"
};
v5.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    VoicelineRange = 2,
    LeaveParts = v5.Resources.LeaveParts,
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(197, 239, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(202, 243, 255)) }),

    OnSummon = function(p22, p23) -- Line: 394, Name: OnSummon
        local Character = p22.Character;
        local _ = Character.Humanoid;
        local _ = p22.Animator;
        local Stand = Character:FindFirstChild("Stand");

        if Character:GetAttribute("MasteryRank") >= 4 then
            local v24 = next;
            local v25, v26 = Stand:GetDescendants();

            for _, v in v24, v25, v26 do
                if v:IsA("MeshPart") and v:GetAttribute("BTD") then
                    v.TextureID = "rbxassetid://" .. tostring(v:GetAttribute("BTD"));
                end;
            end;
        end;
    end
};
v5.Stats.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 100042212748908,
                Volume = 3
            }
        }
    },
    Finisher = {
        HitRemotes = { v5.Resources.HeavyHit },
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
v5.Stats["Surface Detonation"] = {
    Active = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Explosion = {
        Damage = 25,
        Hitbox = {
            Size = 12,
            Predict = false
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        }
    },
    Kick = {
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = false,
            Offset = CFrame.identity
        },
        Block = {
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        }
    }
};
v5.Stats["Arm Slice"] = {
    Active = true,
    Damage = 22.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = true,
        Blockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 10897845803,
            Volume = 3
        }
    },
    HitRemotes = { v5.Resources.HeavyHit }
};
v5.Stats["Limb Burst"] = {
    Active = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0
    },
    Stun = {
        Time = 2
    },
    Block = {
        BypassCounter = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    HitSounds = {
        Hit = {
            SoundId = 127275525556098,
            Volume = 3
        }
    },
    HitRemotes = { v5.Resources.LightHit },
    Burst = {
        Meter = false,
        Damage = 15,
        HitAnimations = "Default",
        Knockback = {
            Speed = 20,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 105904799029685,
                Volume = 3
            }
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    }
};
v5.Stats["Quadruple Bomb Counter"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Throw = {
        Damage = 15,
        Priority = Enums.Intangible.Move + 1,
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
            } },
        Ragdoll = {
            Time = 1
        },
        HitRemotes = { v5.Resources.LightHit }
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Explode = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5.Resources.HeavyHit }
    }
};
v5.Stats["Face Slam"] = {
    Active = true,
    CheckPVPSafe = true,
    Damage = 5.5,
    MinHealth = 1,
    HitAnimations = "Default",
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        MeterGain = 0
    },
    Actionable = {
        Active = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    HitSounds = {
        Hit = {
            SoundId = 10897845803,
            Volume = 3
        }
    },
    HitRemotes = { v5.Resources.HeavyHit },
    Block = {
        Unblockable = true
    },
    Grab = {
        CheckPVPSafe = true,
        Meter = false,
        Stun = {
            Time = 0.7,
            Priority = Enums.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5.Resources.HeavyHit }
    },
    Hit = {
        MinHealth = 1,
        Damage = 10,
        Meter = false,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    },
    Throw = {
        Damage = 30,
        Meter = false,
        Priority = Enums.Intangible.Move + 1,
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
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v5.Stats["Sheer Heart Attack"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Detect = {
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 50,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    },
    Cooldown = {
        Time = 20,
        Manual = true
    }
};
v5.Stats["Plant Bomb"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Startup = {
        Damage = 15,
        Stun = 0.5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            Speed = 25,
            Time = 0.1,
            RelativePart = "HumanoidRootPart"
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        }
    },
    Throw = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
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
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Bomb = {
        Damage = 30,
        Hitbox = {
            Size = 16
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 40,
            Time = 0.2
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        }
    }
};
v5.Stats["Stray Cat"] = {
    Active = true,
    Actionable = {
        Active = true,
        MasteryRank = 2
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Projectile = {
        Damage = 2,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {}
    },
    Explosion = {
        Damage = 25,
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            Size = 18,
            Predict = false
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        }
    }
};
v5.Stats["Bites The Dust"] = {
    Active = true,
    Actionable = {
        Active = true,
        MasteryRank = 2
    },
    Cooldown = {
        Time = 200,
        Manual = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = false
    },
    Lock = {
        Priority = Enums.Intangible.Move + 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 50
        },
        Block = {
            Unblockable = true,
            BypassCounter = true,
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 10.333333333333334
        }
    },
    Healing = {
        Heal = 100,
        Priority = Enums.Intangible.Move + 1
    }
};
v5.Stats.Block = {
    From = "Combat.Block"
};
v5.Stats["Power Display"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        Damage = 35,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        Block = {
            Unblockable = true
        }
    },
    Throw = {
        Priority = Enums.Intangible.Move + 1,
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
            } },
        Ragdoll = {
            Time = 2
        },
        Block = {
            Unblockable = true
        }
    }
};
v5.Stats["Quick Plant"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 5,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v5.Resources.LightHit },
        Block = {
            BlockBreak = true
        }
    },
    Throw = {
        Damage = 15,
        Priority = Enums.Intangible.Move + 1,
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
            } },
        Ragdoll = {
            Time = 1
        },
        HitRemotes = { v5.Resources.LightHit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    },
    Hit = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5.Resources.HeavyHit }
    }
};
v5.Stats.Grab = {
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
v5.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v5.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v5;