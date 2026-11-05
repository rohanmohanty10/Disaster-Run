  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local CollectionService = PathShortcuts.CollectionService;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local u1 = ReplicatedStorage["Client Assets"];
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 22
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), PathShortcuts (copy), u4 (ref)
    u2 = Knit.GetService("MoveInputService");
    u3 = Knit.GetService("EffectService");
    u4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local u5 = {
    Moveset = {
        Groups = {
            Universal = {
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
    Resources = require(script.Resources)
};
u5.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 27, function(p6, p7, p8) -- Line: 59
                    -- upvalues: u3 (ref), AssetHandler (copy)
                    local Character = p8.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    AutoSerialize = true,
                                    Character = Character,
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6) * CFrame.Angles(1.5707963267948966, 0, 0),
                                    Particle = AssetHandler.GetAsset("Particles/Misc/LMBPierce", p8),
                                    Scale = Character:GetScale()
                                }
                            }
                        }
                    });
                end },
            { 27, 29, "Attack" },
            { 33, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 92632953046727,
                Volume = 1
            }
        },
        HitRemotes = { u5.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Stun = {
            Time = 0.69
        },
        Sequence = {
            { 0, "Start" },
            { 22, function(p9, p10, p11) -- Line: 103
                    -- upvalues: u3 (ref)
                    local Character = p11.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Slash",
                                    AutoSerialize = true,
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 1.5707963267948966, 0),
                                    Player = Character
                                }
                            }
                        }
                    });
                end },
            { 22, 25, "Attack" },
            { 30, "End" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Damage = 2.67,
        Stun = {
            Time = 0.69
        },
        Sequence = {
            { 0, "Start" },
            { 24, function(p12, p13, p14) -- Line: 137
                    -- upvalues: u3 (ref)
                    local Character = p14.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Slash",
                                    AutoSerialize = true,
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 1.5707963267948966, 0),
                                    Player = Character
                                }
                            }
                        }
                    });
                end },
            { 39, function(p15, p16, p17) -- Line: 156
                    -- upvalues: u3 (ref)
                    local Character = p17.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Slash",
                                    AutoSerialize = true,
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 1.5707963267948966, 0),
                                    Player = Character
                                }
                            }
                        }
                    });
                end },
            { 57, function(p18, p19, p20) -- Line: 175
                    -- upvalues: u3 (ref)
                    local Character = p20.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Slash",
                                    AutoSerialize = true,
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 1.5707963267948966, 0),
                                    Player = Character
                                }
                            }
                        }
                    });
                end },
            { 24, "Attack", {
                    Multiple = true
                } },
            { 39, "Attack", {
                    Multiple = true
                } },
            { 57, "Attack", {
                    Multiple = true
                } },
            { 68, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 73134919300049,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 18, function(p21, p22, p23) -- Line: 218
                    -- upvalues: u3 (ref)
                    local Character = p23.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Slash",
                                    AutoSerialize = true,
                                    Origin = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 1.5707963267948966, 0),
                                    Player = Character
                                }
                            }
                        }
                    });
                end },
            { 18, 20, "Attack" },
            { 54, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 79309178414471,
                Volume = 1
            }
        },
        HitRemotes = { u5.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {}
};
u5.Stats.Block = {
    From = "Combat.Block"
};
u5.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
u5.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p24, p25) -- Line: 268, Name: PoseTransition
            -- upvalues: u1 (copy), u5 (copy)
            local _ = p24.Stats;
            local _ = p24.Player;
            local Character = p24.Character;
            local v26 = u1.Assets.Abilities["Candy Cutlass"].Models.Mug:Clone();
            u5.Resources.WeldTo(Character["Left Arm"].CFrame * CFrame.new(-0.0118312836, -1.55054796, 0.0458068848, 1, 0, 0, 0, 0, 1, 0, -1, 0), Character["Left Arm"], v26.Mug);
            v26.Name = "PoseMug";
            v26.Parent = Character;
        end,

        PoseEnd = function(p27, p28) -- Line: 279, Name: PoseEnd
            local _ = p27.Stats;
            local _ = p27.Player;
            local Character = p27.Character;

            if Character:FindFirstChild("PoseMug") then
                Character.PoseMug:Destroy();
            end;
        end
    }
};
u5.Stats["Naughty List"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 10),
        Offset = CFrame.new(0, 0, -5.25)
    },
    Damage = 5,
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitRemotes = { u5.Resources.LightHit },
    HitAnimations = "Default",
    Impale = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u5.Resources.HeavyHit }
    },
    ["Kick Attack"] = {
        Damage = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u5.Resources.LightHit }
    },
    ["Kick Attack Finish"] = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = { u5.Resources.HeavyHit }
    }
};
u5.Stats["Flurry Slashes"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 10),
        Offset = CFrame.new(0, 0, -5.25)
    },
    Damage = 1,
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 120849882641776,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    HitRemotes = { u5.Resources.LightHit },
    Lunge = {
        Damage = 2.5,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 114875076686647,
                Volume = 1
            }
        },
        HitRemotes = { u5.Resources.HeavyHit }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.3,
            Velocity = Vector3.new(0, 15, 0)
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 100183080709469,
                Volume = 1
            }
        },
        HitRemotes = { u5.Resources.LightHit }
    }
};
u5.Stats["Sugar Skewer"] = {
    Active = true,
    Damage = 50,
    Armor = true,
    HitAnimations = "Default",
    Priority = Enums.Intangible.Quickstep,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 25,
        Offset = CFrame.new(0, 0, -15)
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.3,
        Velocity = Vector3.new(0, 25, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 99313914340539,
            Volume = 1
        }
    },
    HitRemotes = { u5.Resources.HeavyHit }
};
u5.Stats["Ice Stampede"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 30
    },
    Damage = 15,
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 25,
        Time = 0.15,
        Velocity = Vector3.new(0, 5, 0)
    },
    HitSounds = {},
    HitAnimations = "Default",
    HitRemotes = { u5.Resources.HeavyHit },
    Rain = {
        Amount = 15,
        Damage = 2,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false,
            BypassCounter = true
        },
        Stun = {
            Time = 0.25,
            Priority = Enums.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 136007402227916,
                Volume = 1
            }
        },
        HitRemotes = { u5.Resources.LightHit }
    }
};
u5.Stats["Second Degree Burn"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 16),
        Offset = CFrame.new(0, 0, -8)
    },
    Stun = {
        Time = 1.75,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = {
        {
            Name = "Output",
            Clients = { "__Data.Target" },
            Arguments = { "FX", "Hot Chocolate Screen", "__Legacy" }
        },
        {
            Name = "Output",
            Arguments = {
                "FX",
                "HitEffect V3",
                {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    AutoSerialize = true,
                    LookAt = "Attacker",
                    Particle = u1.Assets.Abilities["Candy Cutlass"].Particles.SecondDegreeBurn.Hit
                }
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 75170696959287,
            Volume = 1
        }
    },
    Block = {
        PerfectBlockable = false,
        Unblockable = true
    }
};
u5.Stats["Insulin Spike"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 10),
        Offset = CFrame.new(0, 0, -5.25)
    },
    Damage = 12,
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false,
        Unlockable = true
    },
    HitSounds = {},
    HitAnimations = "Default",
    HitRemotes = { u5.Resources.HeavyHit },
    Freeze = {
        Damage = 17.5,
        Priority = Enums.Intangible.Move
    },
    Launch = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.3,
            Velocity = Vector3.new(0, 30, 0)
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = { u5.Resources.HeavyHit }
    }
};
u5.Stats["Sugar Rush"] = {
    Active = true,
    Heal = 50,
    Actionable = {
        Active = true,

        Check = function(p29) -- Line: 744, Name: Check
            -- upvalues: CollectionService (copy)
            return not CollectionService:HasTag(p29, "Christmas Spirit");
        end
    },
    Cooldown = {
        Time = 75,
        Manual = true
    },
    Meter = {
        RequiredAmount = 75
    }
};
u5.Stats["Candy Spikes"] = {
    Active = true,
    Damage = 9,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 110735697825386,
            Volume = 1
        }
    },
    HitRemotes = { u5.Resources.LightHit }
};
u5.Stats["Frosted Dash"] = {
    Active = true,
    Damage = 25,
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
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 10),
        Offset = CFrame.new(0, 0, -5.25)
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = true,
        Blockable = false,
        BlockBreak = false
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Freeze"
        } },
    HitSounds = {
        Hit = {
            SoundId = 113076569922925,
            Volume = 1
        }
    },
    HitRemotes = { u5.Resources.HeavyHit }
};
u5.Stats["Frosted Fortress"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 35,
        AfterMove = true
    },
    Armor = true,
    Meter = {
        RequiredAmount = 50
    },
    Hitbox = {
        Size = 15
    },
    Damage = 25,
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    Stun = {
        Time = 0.75
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Freeze"
        } },
    HitSounds = {},
    HitAnimations = "Default",
    HitRemotes = { u5.Resources.HeavyHit },
    Spike = {
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(10, 10, 10)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1,
            Velocity = Vector3.new(0, 5, 0)
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 1.5
        },
        HitSounds = {},
        HitRemotes = { u5.Resources.LightHit }
    }
};

return u5;