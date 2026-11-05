  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local u1;

if game:GetService("RunService"):IsServer() then
    AbilityModule = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Gomu", true);
    u1 = require(AbilityModule.Common);
else
    u1 = nil;
end;

local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), PathShortcuts (copy), u4 (ref)
    u2 = Knit.GetService("MoveInputService");
    u3 = Knit.GetService("EffectService");
    u4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v5 = {
    Hit = {
        SoundId = 18724624260,
        Volume = 1
    }
};
local v6 = {
    Hit = {
        SoundId = 18743627269,
        Volume = 1
    }
};
local v7 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 6
            },
            ["Gear 1 & 2"] = {
                Visible = true,
                Priority = 5
            },
            ["Gear 2 & 5"] = {
                Visible = false,
                Priority = 4
            },
            ["Gear 1"] = {
                Visible = true,
                Priority = 1
            },
            ["Gear 2 & 3"] = {
                Visible = false,
                Priority = 2
            },
            ["Gear 5"] = {
                Visible = false,
                Priority = 3
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
v7.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 10, function(p8, p9, p10) -- Line: 96
                    -- upvalues: u1 (ref)
                    u1.CreateGomuLimb({
                        Limb = "Right Arm",
                        SetTransparent = true,
                        Character = p10.Character,
                        MoveData = p10
                    });
                end },
            { 12, 15, "Attack" },
            { 16, "End" },
            { 28, function(p11, p12, p13) -- Line: 108
                    -- upvalues: u3 (ref), u1 (ref)
                    local Character = p13.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Return",
                                    AutoSerialize = true,
                                    Origin = Character["Right Arm"].CFrame,
                                    Player = p13.Player,
                                    Character = Character,
                                    AttachTo = {
                                        Part = Character["Right Arm"]
                                    }
                                }
                            }
                        }
                    });
                    u1.CleanupGomuLimbs(Character);
                end }
        },
        Stun = {
            Time = 0.75
        },
        HitSounds = v5,
        HitRemotes = { v7.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 23, 25, "Attack" }, { 27, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 24, 26, "Attack" }, { 27, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 28, 30, "Attack" },
            { 28, function(p14, p15, p16, p17) -- Line: 175
                    -- upvalues: u4 (ref), u3 (ref)
                    local _ = p17.AttackStats;
                    local Player = p16.Player;
                    local Character = p16.Character;
                    local RootPart = p16.RootPart;
                    u4.PlaySound(Character, "LMB-4 Slam");
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/LMBSlam",
                                    AutoSerialize = true,
                                    Origin = RootPart.CFrame * CFrame.new(0, -3, -1),
                                    Player = Player,
                                    Character = Character
                                }
                            }
                        },
                        {
                            Name = "Rock Debris",
                            Data = {
                                {
                                    Lifetime = 3,
                                    Radius = 10,
                                    Amount = 15,
                                    Size = Vector3.new(2, 1, 1.5),
                                    Origin = RootPart.CFrame * CFrame.new(0, 0, -0.5)
                                }
                            }
                        }
                    });
                    u3.FireClient(Player, "Camera Shake Preset", "Explosion");
                end },
            { 32, "End" }
        },
        HitRemotes = { v7.Resources.HeavyHit },
        HitSounds = v6
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v7.Stats.Block = {
    From = "Combat.Block"
};
v7.Stats.Breaker = {
    From = "Combat.Breaker"
};
v7.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v7.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p18, p19) -- Line: 241, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v20 = TableUtil.Copy(p18.Stats, true);

            if Knit.CollectionService:HasTag(p18.Character, "Gear 2") then
                v20.StartAnim = "G2PoseTransition";
                v20.LoopAnim = "G2PoseIdle";
            end;

            return v20;
        end
    }
};
v7.Stats.Breaker = {
    From = "Combat.Breaker"
};
v7.Stats.Grab = {
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
v7.Stats.Gatling = {
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
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 1,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
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
    HitSounds = v5,
    HitAnimations = "Default",
    HitRemotes = { v7.Resources.LightHit },
    Finisher = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 11),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = v6,
        HitRemotes = { v7.Resources.HeavyHit }
    }
};
v7.Stats.Pistol = {
    Active = true,
    Damage = 20,
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
        Size = Vector3.new(6.5, 6.5, 15),
        Offset = CFrame.new(0, 0, -6.75)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Stun = {
        Time = 1.5
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = v5,
    HitRemotes = { v7.Resources.LightHit }
};
v7.Stats.Rifle = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -3)
    },
    Damage = 20,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.3
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v6,
    HitAnimations = "Default",
    HitRemotes = {},
    ["Rifle Launch"] = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 3
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Character Rock Trail", {
                        State = true,
                        Duration = 3,
                        Attribute = "GomuRifleTargetRocks",
                        Character = "__Target"
                    } }
            } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 80,
            Time = 0.7
        }
    }
};
v7.Stats.Windmill = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.5, 7.5, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    Damage = 10,
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = v5,
    HitAnimations = "Default",
    HitRemotes = { v7.Resources.LightHit },
    Spin = {
        Damage = 2,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.05
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 137409812729677,
                Volume = 1.5
            }
        },
        HitRemotes = { v7.Resources.LightHit }
    },
    Headbutt = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.3,
            Velocity = Vector3.new(0, 30, 0)
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = v6,
        HitRemotes = { v7.Resources.HeavyHit }
    }
};
v7.Stats.Bazooka = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 19),
        Offset = CFrame.new(0, 0, -9)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v6,
    HitRemotes = { v7.Resources.HeavyHit }
};
v7.Stats.Buzzsaw = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 15),
        Offset = CFrame.new(0, 0, -9)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 98961633229980,
            Volume = 1.5
        }
    },
    HitRemotes = { v7.Resources.HeavyHit }
};
v7.Stats["War Axe"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.new(0, -2, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.2,
        Velocity = Vector3.new(0, 20, 0)
    },
    Stun = {
        Time = 0.8
    },
    Ragdoll = {
        Time = 1.5
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v6,
    HitRemotes = { v7.Resources.HeavyHit }
};
v7.Stats.Mallet = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -5)
    },
    Damage = 10,
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitRemotes = { v7.Resources.HeavyHit },
    Headslam = {
        Damage = 35,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitRemotes = {}
    },
    Headslam_AOE = {
        Damage = 35,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = { v7.Resources.HeavyHit }
    }
};
v7.Stats["Jet Gatling"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 8.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 14.5),
        Offset = CFrame.new(0, 0, -8)
    },
    Damage = 1.15,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
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
    HitSounds = v5,
    HitAnimations = "Default",
    HitRemotes = { v7.Resources.LightHit },
    Finisher = {
        Damage = 20.5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 11),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = v6,
        HitRemotes = { v7.Resources.HeavyHit }
    }
};
v7.Stats["Jet Pistol"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 18),
        Offset = CFrame.new(0, 0, -8.75)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = v5,
    HitRemotes = { v7.Resources.LightHit }
};
v7.Stats["Jet Rifle"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30,
        RemoveMeter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9.5, 9.5, 13),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -3.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 90,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 90419076007267,
            Volume = 1.5
        }
    },
    HitRemotes = { v7.Resources.HeavyHit }
};
v7.Stats["Jet Missile"] = {
    Active = true,
    Damage = 45,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40,
        RemoveMeter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20,
        Offset = CFrame.new(0, 0, 0)
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3,
        Velocity = Vector3.new(0, 15, 0)
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v6,
    HitRemotes = { v7.Resources.HeavyHit }
};
v7.Stats["Jet Bazooka"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(14, 10, 35),
        Offset = CFrame.new(0, 0, -17.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 1.5
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 105378515225526,
            Volume = 1.5
        }
    },
    HitRemotes = { v7.Resources.HeavyHit }
};
v7.Stats["Jet Axe"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35,
        RemoveMeter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20,
        Offset = CFrame.new(0, 0, -12.5)
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3,
        Velocity = Vector3.new(0, 20, 0)
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v6,
    HitRemotes = { v7.Resources.HeavyHit }
};
v7.Stats["Jet Whip"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = true
    },
    ["First Hit"] = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 17),
            Offset = CFrame.new(0, 0, -9.75)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = v5,
        HitRemotes = { v7.Resources.LightHit }
    },
    ["Second Hit"] = {
        Damage = 20.5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 17),
            Offset = CFrame.new(0, 0, -9.75)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.4
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = v6,
        HitRemotes = { v7.Resources.HeavyHit }
    }
};
v7.Stats["Jet Bullet"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    ["First Hit"] = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitSounds = {},
        HitRemotes = { v7.Resources.LightHit }
    },
    Constant = {
        Damage = 0.5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitRemotes = { v7.Resources.LightHit }
    },
    ["Final Hit"] = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.4
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitSounds = v6
    }
};
v7.Stats["Giant Pistol"] = {
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = true
    },
    Properties = {
        Armor = true
    },
    ["First Hit"] = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 34),
            Offset = CFrame.new(0, 0, -20.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = v6,
        HitRemotes = { v7.Resources.HeavyHit }
    },
    ["Second Hit"] = {
        Damage = 35,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.new(0, 0, -25)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.2,
            Velocity = Vector3.new(0, 50, 0)
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true
        },
        HitSounds = v6,
        HitRemotes = { v7.Resources.HeavyHit }
    }
};
v7.Stats["Giant Pistol Ultimate"] = {
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Active = true,
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = true
    },
    Startup = {
        Damage = 5,
        MinHealth = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Stun = {
            Time = 0.75
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Grab",
                        LookAt = "Attacker",
                        PartName = "Torso"
                    } }
            } },
        HitSounds = v6
    },
    ["First Hit"] = {
        MinHealth = 1,
        Damage = 10,
        Priority = EnumsModule.Intangible.Move
    },
    ["Second Hit"] = {
        MinHealth = 1,
        Damage = 20,
        Priority = EnumsModule.Intangible.Move
    },
    ["Fist Hit"] = {
        MinHealth = 1,
        Damage = 2.14,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Gear2/Ultimate/Hit",
                        LookAt = "Attacker",
                        PartName = "Torso"
                    } }
            } }
    },
    ["After Sequence"] = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 90,
            Time = 0.3
        }
    }
};
v7.Stats["Gear 2 Switch"] = {
    Active = true,
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Meter = {
        RequiredAmount = 100,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 60,
        Manual = true
    }
};

return v7;