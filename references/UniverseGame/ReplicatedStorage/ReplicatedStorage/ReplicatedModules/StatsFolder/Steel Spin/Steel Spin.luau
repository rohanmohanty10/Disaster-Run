  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5;

if game:GetService("RunService"):IsServer() then
    local v6 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Steel Spin", true);
    u5 = require(v6.Common);
else
    u5 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 30
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
local v7 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
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
local v8 = {
    Stats = {},
    Sounds = require(script.Sounds),
    Moveset = require(script.Moveset),
    Metadata = require(script.Metadata),
    Animations = require(script.Animations),
    QuoteInfo = require(script.Quotes)
};
v8.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    MaxCombo = 4,
    ComboTick = 1,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.3,
        HitRemotes = { v7["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 126479905414076,
                Volume = 1.5
            }
        },
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 25, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.3,
        HitRemotes = { v7["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 126479905414076,
                Volume = 1.5
            }
        },
        Sequence = { { 0, "Start" }, { 19, 22, "Attack" }, { 25, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.3,
        HitSounds = {
            Hit = {
                SoundId = 110684825483418,
                Volume = 1.5
            }
        },
        Sequence = {
            { 0, "Start" },
            { 0, function(p9, p10, u11, p12) -- Line: 132
                    -- upvalues: u5 (ref)
                    u5.SetSteelBallTransparency(u11.Character, "Left", 0);
                    u11.Trove:Add(function() -- Line: 134
                        -- upvalues: u5 (ref), u11 (copy)
                        u5.SetSteelBallTransparency(u11.Character, "Left", 1);
                    end);
                end },
            { 16, "Attack", {
                    Multiple = true
                } },
            { 18, "Attack", {
                    Multiple = true
                } },
            { 20, "Attack", {
                    Multiple = true
                } },
            { 22, "Attack", {
                    Multiple = true
                } },
            { 24, "Attack", {
                    Multiple = true
                } },
            { 26, "Attack", {
                    Multiple = true
                } },
            { 28, "Attack", {
                    Multiple = true
                } },
            { 30, "Attack", {
                    Multiple = true
                } },
            { 35, "End" }
        },
        Damage = BaseStatsModule.Rush_Attack.Damage / 8,
        HitRemotes = { v7["Light Hit"] }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.3,
        HitSounds = {
            Hit = {
                SoundId = 98322681510184,
                Volume = 1.5
            }
        },
        Sequence = { { 0, "Start" }, { 17, 25, "Attack" }, { 32, "End" } },
        HitRemotes = { v7["Heavy Hit"] }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v8.Stats.Block = {
    From = "Combat.Block"
};
v8.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v8.Stats.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Active = true
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
};
v8.Stats["Spin Charge"] = {
    Active = true,
    MaxCharge = 4,
    ChargeRate = 0.125,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v8.Stats["Iron Frenzy"] = TableUtil.Reconcile({
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, function(p13, p14, u15) -- Line: 270
                -- upvalues: u5 (ref)
                u5.SetSteelBallTransparency(u15.Character, "Left", 0);
                u5.SetSteelBallTransparency(u15.Character, "Right", 0);
                u15.Trove:Add(function() -- Line: 274
                    -- upvalues: u5 (ref), u15 (copy)
                    u5.SetSteelBallTransparency(u15.Character, "Left", 1);
                    u5.SetSteelBallTransparency(u15.Character, "Right", 1);
                end);
            end },
        { 0, "PlaySound", "Iron Frenzy" },
        { 0, "PlaySound", "Iron Frenzy Voiceline" },
        { 0, "PlayAnim", "Iron Frenzy", {
                Cancelable = true
            } },
        { 15, function(p16, p17, p18) -- Line: 282
                -- upvalues: u5 (ref), u2 (ref), AssetHandler (copy)
                local Player = p18.Player;
                local Character = p18.Character;
                local Trove = p18.Trove;
                local v19 = u5.SetSteelBallTransparency(Character, "Left", 0);
                local v20 = u5.SetSteelBallTransparency(Character, "Right", 0);
                local u21 = os.clock();
                local u22 = os.clock() + 1;
                u2.FireAllClients("Enable Particles", {
                    Enabled = true,
                    Parent = v19,
                    Player = Player,
                    ReferencePart = AssetHandler.GetAsset("Particles/Trail", p18),
                    Id = u21
                });
                u2.FireAllClients("Enable Particles", {
                    Enabled = true,
                    Parent = v20,
                    Player = Player,
                    ReferencePart = AssetHandler.GetAsset("Particles/Trail", p18),
                    Id = u22
                });
                Trove:Add(function() -- Line: 309
                    -- upvalues: u2 (ref), u21 (copy), u22 (copy)
                    u2.FireAllClients("Enable Particles", {
                        Id = u21
                    });
                    u2.FireAllClients("Enable Particles", {
                        Id = u22
                    });
                end);
            end },
        { 24, "Cancelable", true },
        { 24, "Barrage", true },
        { 24, 226, "BarrageAttack", "Hit" },
        { 226, "Cancelable", false },
        { 226, "Barrage", false },
        { 226, "BarrageFinisher" },
        { 249, 254, "BarrageAttack", "Finisher" },
        { 280, "End" }
    },
    Callbacks = {
        BarrageEffect = function(p23, p24, p25, p26) -- Line: 327, Name: BarrageEffect
            return true;
        end
    },
    Hit = {
        Frequency = 10,
        HitSounds = {
            Hit = {
                SoundId = 91746516226883,
                Volume = 1.5
            }
        },
        HitRemotes = { v7["Light Hit"] },
        Stun = {
            Time = 0.65,
            Priority = Enums.Stun.Medium
        }
    },
    Finisher = {
        Damage = 25,
        HitSounds = {
            Hit = {
                SoundId = 128662452371784,
                Volume = 1.5
            }
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v7["Heavy Hit Hit"] },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 35,
            Time = 0.1
        }
    }
}, BaseStatsModule.Stand_Barrage);
v8.Stats["Rotary Havoc"] = {
    Active = true,
    Damage = 0.69,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8.75,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(15, 20, 15),
        Predict = false
    },
    Block = {
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Target",
        Time = 0.175,
        Speed = 0,
        Velocity = Vector3.new(0, 4, 0)
    },
    Stun = {
        Time = 1.3
    }
};
v8.Stats.Toss = {
    Active = true,
    Damage = 20,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = 3
    },
    HitRemotes = { v7["Light Hit"] },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 2
    }
};
v8.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p27, p28) -- Line: 451, Name: PoseTransition
            -- upvalues: u5 (ref)
            local Trove = p27.Trove;
            local Character = p27.Character;
            local _ = p27.RootPart;
            u5.SetSteelBallTransparency(Character, "Right", 0);
            Trove:Add(function() -- Line: 457
                -- upvalues: u5 (ref), Character (copy)
                u5.SetSteelBallTransparency(Character, "Right", 1);
            end);
        end
    }
};
v8.Stats.Scan = {
    Active = true,
    Duration = 20,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.identity
    }
};
v8.Stats["Iron Flux"] = {
    Active = true,
    Damage = 15,
    Stun = 1,
    Distance = 2.5,
    Actionable = {
        Active = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    HitRemotes = { v7["Light Hit"] },
    Block = {
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(3, 3, 3),
        Offset = CFrame.identity
    }
};
v8.Stats["Energy Burst"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = true
    },
    Tick = {
        Damage = 1,
        Stun = 0.2,
        HitRemotes = { v7["Light Hit"] },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 9.2,
            Offset = CFrame.new(0, 0, -1)
        },
        Knockback = {
            RelativePart = "HumanoidRootPart",
            Time = 0.1,
            Speed = 5
        }
    },
    Burst = {
        Damage = 30,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15,
            Offset = CFrame.new(0, 0, -1)
        },
        Knockback = {
            RelativePart = "Attacker",
            Time = 0.1,
            Speed = 40,
            Offset = CFrame.new(0, 0, -1)
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        }
    }
};
v8.Stats["Amnestic Club"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 35,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Startup = {
        Damage = 12.5,
        Stun = 1,
        MinHealth = 1,
        Hitbox = {
            HitboxType = "ClientHitbox",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v7["Light Hit"] },
        Block = {
            Unblockable = true
        }
    },
    Punch = {
        Damage = 5,
        MinHealth = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v7["Light Hit"] }
    },
    Finish = {
        Damage = 27.5,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v7["Heavy Hit"] },
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
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v8.Stats["Golden Pitch"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    IgnoreLoveTrain = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(4, 4, 4),
        Offset = CFrame.identity
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    HitRemotes = { v7["Heavy Hit"] },
    HitSounds = {
        Hit = {
            SoundId = 116196335025513,
            Volume = 1.5
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Ragdoll = {
        Time = 3
    }
};
v8.Stats["Deadly Whirl"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35,
        RemoveMeter = true
    },
    Startup = {
        Damage = 5,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v7["Light Hit"] },
        Block = {
            Unblockable = true
        }
    },
    FaceSpin = {
        Damage = 1,
        Priority = Enums.Intangible.Move
    },
    BodySpin = {
        Damage = 1.5,
        Priority = Enums.Intangible.Move
    },
    Finish = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v7["Heavy Hit"] },
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
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};

return v8;