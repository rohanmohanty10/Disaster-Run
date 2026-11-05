  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local ReplicatedModules = PathShortcuts.ReplicatedModules;
local _ = PathShortcuts.ClientAssets;
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Enums = require(ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnableTrail = require(script.EnableTrail);
local v2 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 6
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
v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 23, 25, "Attack" }, { 26, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 14255013145,
                Volume = 1
            }
        },
        HitRemotes = { v2.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 21, 23, "Attack" }, { 27, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 18, 20, "Attack" }, { 27, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 25, 27, "Attack" }, { 40, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 14255013727,
                Volume = 1
            }
        },
        HitRemotes = { v2.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p3, p4) -- Line: 121, Name: PreAnim
            -- upvalues: EnableTrail (copy), AssetHandler (copy), ParticleHandler (copy)
            local _ = p3.Player;
            local Character = p3.Character;
            local _ = p3.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            local Count = p4.MoveState.Count;

            if Count == 1 then
                EnableTrail(Character, { "Right", true });

                return;
            end;

            if Count == 2 then
                EnableTrail(Character, { "Right", true });

                return;
            end;

            if Count == 3 then
                EnableTrail(Character, { "Left", true });

                return;
            end;

            if Count == 4 then
                if p3.SkinName == "Homelander" then
                    local u5 = p3.Trove:Construct(Instance, "Attachment");
                    u5.Parent = Character.Head;
                    local u6 = AssetHandler.CloneAsset("Particles/HeadLaser", p3);
                    ParticleHandler.Unusualify(u6, p3);
                    u6.Parent = Character;

                    for _, descendant in u6:GetDescendants() do
                        if descendant:IsA("Beam") then
                            descendant.Attachment1 = u5;
                        end;
                    end;

                    ParticleHandler.AttachTo(u6, {
                        Part = Character.Head
                    });
                    ParticleHandler.EnableAllParticles(u6, false);
                    task.delay(0.3, function() -- Line: 156
                        -- upvalues: ParticleHandler (ref), u6 (copy), u5 (copy)
                        ParticleHandler.EnableAllParticles(u6, true);
                        game.TweenService:Create(u5, TweenInfo.new(0.06666666666666667), {
                            Position = Vector3.new(0, 0, -8)
                        }):Play();
                    end);
                    local u7 = false;
                    p3.Trove:Add(function() -- Line: 165, Name: Disable
                        -- upvalues: u7 (ref), ParticleHandler (ref), u6 (copy)
                        if u7 then
                            return;
                        end;

                        u7 = true;
                        ParticleHandler.EnableAllParticles(u6, false);
                        ParticleHandler.DestroyEmit(u6);
                    end);

                    return;
                end;

                EnableTrail(Character, { "Left", true });
            end;
        end,

        PostAnim = function(p8, p9) -- Line: 183, Name: PostAnim
            -- upvalues: EnableTrail (copy)
            local _ = p8.Player;
            local Character = p8.Character;
            local _ = p8.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            EnableTrail(Character, { "Both", false });
        end
    }
};
v2.Stats.Block = {
    From = "Combat.Block"
};
v2.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Stats.Pose = {
    From = "Combat.Pose"
};
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};
v2.Stats.Grab = {
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
v2.Stats.Regeneration = {
    Active = true,
    Heal = 1,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p10) -- Line: 239, Name: Check
            return p10.Humanoid.Health < p10.Humanoid.MaxHealth;
        end
    },
    Cooldown = {
        Time = 2.5,
        AfterMove = true
    },
    HitRemotes = { v2.Resources.Regeneration }
};
v2.Stats["Relentless Barrage"] = {
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
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -5)
    },
    Damage = 1,
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
    HitRemotes = { v2.Resources.LightHit },
    HitSounds = {
        Hit = v2.Resources.BarrageHitSound
    },
    HitAnimations = "Default",
    Finisher = {
        Damage = 27,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Stun = {
            Time = 0.85
        },
        Ragdoll = {
            TIme = 1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitSounds = {
            Hit = v2.Resources.BarrageFinisherSound
        },
        HitRemotes = { v2.Resources.HeavyHit }
    }
};
v2.Stats["Driving Force"] = {
    Active = true,
    Distance = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Strike = {
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 11),
            Predict = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        },
        HitSounds = {
            Hit = v2.Resources.ForceHitSound
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Finisher = {
        Damage = 35,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 11),
            Predict = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
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
        HitSounds = {
            Hit = v2.Resources.ForceFinisherSound
        },
        HitRemotes = { v2.Resources.HeavyHit }
    }
};
v2.Stats["Phantom Mirage"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Impale = {
        Damage = 14,
        Priority = Enums.Intangible.Move
    },
    Strike = {
        Damage = 12,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            HitboxType = "ClientHitbox",
            Offset = CFrame.identity
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitRemotes = { v2.Resources.LightHit },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = v2.Resources.ForceFinisherSound
        }
    }
};
v2.Stats["Shadow Step"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block" }
        }
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    }
};
v2.Stats["Corpse Hurl"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5, 5, 15),
        Offset = CFrame.new(0, 0, -7)
    },
    Stun = {
        Time = 0.65
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    Ragdoll = {
        Time = 0.65
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.15
    },
    HitRemotes = {}
};
v2.Stats["Surprise Impact"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Detect = {
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            Size = 35
        }
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        Size = 6,
        Predict = false
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 5,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 0.5
    }
};
v2.Stats["Inhumane Perception"] = {
    Duration = 0.5,
    Active = true,
    CheckPVPSafe = true,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p11) -- Line: 633, Name: Check
            return not p11:GetAttribute("AssistedEyesight");
        end
    },
    Meter = {
        RequiredAmount = 25
    },
    Stun = {
        Time = 1
    },
    Cooldown = {
        Time = 40,
        AfterMove = true
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Glare"
        } },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true
    }
};
v2.Stats["Vaporization Freezing Technique"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Freeze = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.45
        },
        HitRemotes = { v2.Resources.FreezeHit },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Freeze",
                Overrides = {
                    Lifetime = 5
                }
            } }
    }
};
v2.Stats["Space Ripper Stingy Eyes"] = {
    Active = true,
    Damage = 20,
    MaxSize = 50.3,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        Size = Vector3.new(80, 1, 2),
        Predict = false
    },
    Ragdoll = {
        Time = 3
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 30,
        Time = 0.2
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 4,
            Overrides = {
                Lifetime = 5.5,
                Rate = 0.5
            }
        } }
};
v2.Stats["Life Drain"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Predict = false,
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -5.5)
    },
    Stun = {
        Time = 1.5
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {},
    HitAnimations = "Default",
    Run = {
        CheckPVPSafe = true,
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            HitboxType = "ClientHitbox",
            Offset = CFrame.identity
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = { v2.Resources.HeavyHit },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = v2.Resources.ForceHitSound
        }
    },
    Slam = {
        Damage = 5,
        Priority = Enums.Intangible.Move
    },
    Drain = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v2.Resources.Blood },
        Lifesteal = {
            Type = "Flat",
            Amount = 9
        },
        Meter = {
            MeterGain = 0
        }
    },
    Throw = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v2.Resources.HeavyHit },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5
        }
    }
};
v2.Stats["Scorched Earth"] = {
    Active = true,
    FlightHeight = 20,
    FlightFrames = 44,
    Damage = 4,
    TrueDamage = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        Size = 12,
        Predict = false
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 8,
        Time = 0.1
    },
    Stun = {
        Time = 0.4
    },
    Ragdoll = {
        Time = 0.6
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = v2.Resources.HeavyHit
    },
    HitRemotes = { v2.Resources.HeavyHit }
};
v2.Stats["America\'s Finest"] = {
    Active = false,
    Damage = 1.25,
    HipHeight = 3,
    MaxSlope = 0.5,
    Speed = 38,
    Frequency = 5,
    RunDuration = 2.5,
    TurnRate = 0.2,
    MaxHitsPerTarget = 50,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40,
        RemoveMeter = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
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
v2.Stats["Deep Dive"] = {
    Active = false,
    Speed = 110,
    Damage = 35,
    UGrainBypass = true,
    Priority = Enums.Intangible.Move,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 40,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 15
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = true
    },
    Ragdoll = {
        Time = 1.5,
        Intangible = false
    },
    Stun = {
        Time = 1.5
    },
    Knockback = {
        Override = true,
        Speed = 50,
        Time = 0.15,
        Velocity = Vector3.new(0, 40, 0),
        RelativeTowards = "Target"
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 37.5
    }
};

return v2;