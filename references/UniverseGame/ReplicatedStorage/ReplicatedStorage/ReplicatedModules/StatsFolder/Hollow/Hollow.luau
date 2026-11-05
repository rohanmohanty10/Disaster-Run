  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local CollectionService = PathShortcuts.CollectionService;
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local ReplicatedModules = PathShortcuts.ReplicatedModules;
local _ = PathShortcuts.ClientAssets;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Enums = require(ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 27
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v6 = {
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
    Resources = require(script.Resources),

    PostRig = function(p4) -- Line: 50, Name: PostRig
        -- upvalues: TagService (copy)
        local Character = p4.Character;
        local Player = p4.Player;

        repeat
            task.wait(0.25);
        until Character:WaitForChild("Head");

        if Player and Player:IsA("Player") then
            Player:HasAppearanceLoaded();
        end;

        task.defer(function() -- Line: 58
            -- upvalues: Character (copy), TagService (ref)
            Character:ScaleTo(1.76);
            local v5 = TagService:GetContainer(Character);
            TagService:Add(v5, "NoRun");
            TagService:Add(v5, "WalkSpeedMultiplier", 0.75);
            TagService:Add(v5, "NoRagdoll", true);
            TagService:Add(v5, "NoHitAnimations");
        end);
    end
};
v6.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1,
        Damage = 15,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 41, 52, "Attack" }, { 55, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 101046343389890,
                Volume = 1
            }
        },
        HitRemotes = { v6.Resources.LightHit },
        Stun = {
            Time = 2
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 20, 26),
            Offset = CFrame.new(0, 0, -13)
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 35, 47, "Attack" }, { 50, "End" } },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 20, 26),
            Offset = CFrame.new(0, 0, -13)
        },
        Stun = {
            Time = 2
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1,
        Multiple = true,
        Damage = 15,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 34, 40, "Attack" },
            { 44, function(p7, p8, p9, p10, p11) -- Line: 141
                    p7.Hit[p10.FullName] = {};
                end },
            { 49, 55, "Attack" },
            { 58, "End" }
        },
        Stun = {
            Time = 2
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 20, 26),
            Offset = CFrame.new(0, 0, -13)
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1,
        Damage = 25,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 15, function(p12, p13, p14, p15) -- Line: 168
                    p12:GetCache("Cache");
                    local _ = p14.Character;
                    local _ = p14.RootPart;
                    local _ = p14.Trove;
                end },
            { 40, function(p16) -- Line: 190
                    p16:GetCache("Cache");
                end },
            { 45, function(p17, p18, p19, p20) -- Line: 195
                    -- upvalues: u3 (ref), u2 (ref)
                    local AttackStats = p20.AttackStats;
                    local _ = p19.Player;
                    local Character = p19.Character;
                    local RootPart = p19.RootPart;
                    local v21 = u3.Hitbox({
                        Caster = Character,
                        Stats = AttackStats
                    });

                    for _, v in ipairs(v21) do
                        u3.Attack({
                            Attacker = Character,
                            Target = v.Character,
                            Stats = AttackStats
                        });
                    end;

                    u3.PlaySound(Character, "LMB-4 Slam");
                    u2.FireAllClients("Slam Effect", {
                        Character = Character,
                        Origin = RootPart.CFrame * CFrame.new(0, -2.45, -11.5),
                        Radius = AttackStats.Hitbox.Size
                    });
                    u2.FireAllClients("Q_RADIAL", {
                        Distance = 30,
                        Effect = "Camera Shake",
                        Origin = RootPart.CFrame,
                        Arguments = { { 5.5, 13, 0, 0.9, Vector3.new(0.25, 0.25, 0.25), Vector3.new(1, 1, 1) } }
                    });
                end },
            { 41, 47, "Attack" },
            { 105, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 71241680104507,
                Volume = 1
            }
        },
        HitRemotes = { v6.Resources.HeavyHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Offset = CFrame.new(0, 0, -15)
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            Speed = 8,
            Time = 0.35,
            Velocity = Vector3.new(0, 38, 0),
            RelativeTowards = "Target"
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v6.Stats["Undead Summoning"] = {
    Active = true,
    EnemiesPerPlayer = 3,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 150
    }
};
v6.Stats["Scythe Spinner"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(30, 20, 26),
        Offset = CFrame.new(0, 0, -13)
    },
    Hit = {
        Damage = 3,
        HitAnimations = "Default",
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 1,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 18892171298,
                Volume = 1
            }
        },
        HitRemotes = { v6.Resources.LightHit }
    },
    Gust_Hit = {
        Damage = 1,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 30
        },
        Stun = {
            Time = 0.3
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 18892171298,
                Volume = 1
            }
        },
        HitRemotes = { v6.Resources.LightHit }
    },
    Finisher_Hit = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.95
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Ragdoll = {
            TIme = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 18892170980,
                Volume = 1
            }
        },
        HitRemotes = { v6.Resources.HeavyHit }
    }
};
v6.Stats["Scythe Slam"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    First_Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 20, 26),
            Offset = CFrame.new(0, 0, -13)
        },
        Stun = {
            Time = 1.5
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        },
        HitRemotes = { v6.Resources.HeavyHit }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 25,
        Offset = CFrame.new(0, 0, -13)
    },
    Damage = 55,
    Stun = {
        Time = 1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = true
    },
    Ragdoll = {
        Time = 1.3
    },
    Knockback = {
        Speed = 8,
        Time = 0.35,
        Velocity = Vector3.new(0, 38, 0),
        RelativeTowards = "Target"
    },
    HitSounds = {
        Hit = {
            SoundId = 14448219007,
            Volume = 1
        }
    },
    HitRemotes = {}
};
v6.Stats["Sweet Treat"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    ["Extra Candy"] = {
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            Size = 12,
            Offset = CFrame.new(0, 0, 0)
        },
        Stun = {
            Time = 0.75
        },
        Knockback = {
            Speed = 30,
            Time = 0.35,
            Velocity = Vector3.new(0, 35, 0),
            RelativeTowards = "Target"
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 30,
        Offset = CFrame.new(0, 0, -5)
    },
    Damage = 50,
    Stun = {
        Time = 0.75
    },
    Knockback = {
        Speed = 30,
        Time = 0.35,
        Velocity = Vector3.new(0, 35, 0),
        RelativeTowards = "Target"
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 1.5
    },
    HitSounds = {
        Hit = {
            SoundId = 14448219007,
            Volume = 1
        }
    },
    HitRemotes = { v6.Resources.HeavyHit }
};
v6.Stats["Skull Gun"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Projectile = {
        Damage = 30,
        HitAnimations = "Default",
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Stun = {
            Time = 1
        },
        Knockback = {
            Speed = 1,
            Time = 0.1,
            RelativeTowards = "Target"
        },
        HitSounds = {
            Hit = {
                SoundId = 132291204995469,
                Volume = 1
            }
        }
    },
    Explosion = {
        Damage = 15,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.75
        },
        Knockback = {
            Speed = 30,
            Time = 0.35,
            Velocity = Vector3.new(0, 35, 0),
            RelativeTowards = "Target"
        },
        Ragdoll = {
            Time = 1.5
        }
    }
};
v6.Stats["Witch\'s Brew"] = {
    Active = true,
    Actionable = {
        Active = true
    },

    Check = function(p22) -- Line: 650, Name: Check
        -- upvalues: CollectionService (copy)
        return not CollectionService:HasTag(p22, "Brewed");
    end,

    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v6.Stats.Mist = {
    HitAnimations = "Default",
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false,
        BypassCoutner = true
    },
    Damage = math.random(15, 30),
    Stun = {
        Time = 1
    },
    HitRemotes = {
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
                    Particle = ReplicatedStorage["Client Assets"].Assets.Abilities.Hollow.Particles.Universal.MistExplosions
                }
            }
        }
    }
};

return v6;