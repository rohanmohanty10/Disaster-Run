  

 

local v1 = {};
game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ClientModulesPath.TweenModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6;

if game:GetService("RunService"):IsServer() then
    local v7 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Crazy Diamond", true);
    u6 = require(v7.Common);
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
else
    u6 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 37
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref)
    u2 = Knit.GetService("RigService");
    u3 = Knit.GetService("EffectService");
    u4 = Knit.GetService("TagService");
    u5 = Knit.GetService("AnimationService");
end);
local v8 = {
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
    },
    Heal = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heal",
                AutoSerialize = true
            } }
    }
};
v1.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 42, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(202, 117, 255)) }),

    OnSummon = function(p9, p10) -- Line: 108, Name: OnSummon
        local Character = p9.Character;
        local _ = Character.Humanoid;
        local _ = p9.Animator;
        Character:FindFirstChild("Stand");

        if Character:GetAttribute("Rampage") then
            local v11 = next;
            local v12, v13 = Character:GetDescendants();

            for _, v in v11, v12, v13 do
                if v:IsA("ParticleEmitter") then
                    if v.Name == "RampageAura" then
                        v.Enabled = p10;
                    end;

                    if v.Name == "StandAura" then
                        v.Enabled = false;
                    end;
                end;
            end;
        end;
    end
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 0.94,
        Endlag = 0.35,
        ActiveEndlag = 0.308,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 16, function(p14, p15, p16) -- Line: 147
                    -- upvalues: u6 (ref), BaseStatsModule (copy)
                    u6:TryRestoration(p16, BaseStatsModule.Rush_Attack);
                end },
            { 16, 18, "Attack" },
            { 19, "End" }
        },
        HitRemotes = { v8["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17487793700,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 0.94,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 4" },
            { 16, function(p17, p18, p19) -- Line: 177
                    -- upvalues: u6 (ref), BaseStatsModule (copy)
                    u6:TryRestoration(p19, BaseStatsModule.Rush_Attack_Finisher);
                end },
            { 16, 18, "Attack" },
            { 19, "End" }
        },
        HitRemotes = { v8["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17487793820,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        ActiveEndlag = 0.308,
        Speed = 1.41,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 19, function(p20, p21, p22) -- Line: 199
                    -- upvalues: u6 (ref), BaseStatsModule (copy)
                    u6:TryRestoration(p22, BaseStatsModule.Rush_Attack);
                end },
            { 19, 24, "Attack" },
            { 30, "End" }
        },
        HitRemotes = { v8["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17487793700,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.115,
        ActiveEndlag = 0.508,
        Cooldown = 1,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 36, function(p23, p24, p25) -- Line: 227
                    -- upvalues: u6 (ref), BaseStatsModule (copy)
                    u6:TryRestoration(p25, BaseStatsModule.Rush_Attack_Finisher);
                end },
            { 36, 42, "Attack" },
            { 48, "End" }
        },
        HitRemotes = { v8["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17487793820,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p26, p27) -- Line: 253, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p26.Stats;

            if not Knit.CollectionService:HasTag(p26.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Grab = {
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
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p28, p29) -- Line: 303, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy), u3 (ref)
            EnableBirthmark(p28.Character, true);
            u3.FireAllClients("Emit Particle V3", {
                Path = "Particles/PoseEmit",
                AutoSerialize = true,
                Origin = p28.Character.Torso.CFrame,
                Player = p28.Player,
                AbilityName = p28.AbilityName,
                SkinName = p28.SkinName
            });
        end,

        Transformer = function(p30) -- Line: 315, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v31 = TableUtil.Copy(p30.Stats, true);
            v31.PoseMusic = "PoseMusic" .. math.random(1, 3);

            if Knit.CollectionService:HasTag(p30.Character, "Summoned") then
                v31.PoseMusic = "StandPoseMusic" .. math.random(1, 3);
                v31.StartAnim = "StandPoseTransition";
                v31.LoopAnim = "StandPoseIdle";
            end;

            return v31;
        end,

        PoseEnd = function(p32, p33) -- Line: 326, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p32.Character, false);
        end
    }
};
v1.Barrage = TableUtil.Reconcile({
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
        HitRemotes = { v8["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17487793929,
                Volume = 2
            }
        },

        PreHit = function(p34, p35, p36) -- Line: 360, Name: PreHit
            -- upvalues: u6 (ref)
            u6:TryRestoration(p34, p36);
        end
    },
    Finisher = {
        HitRemotes = { v8["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17487793561,
                Volume = 2
            }
        },

        PreHit = function(p37, p38, p39) -- Line: 377, Name: PreHit
            -- upvalues: u6 (ref)
            u6:TryRestoration(p37, p39);
        end
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 17487793929,
                Volume = 2
            }
        }
    },
    ClashFinisher = {
        HitSounds = {
            Hit = {
                SoundId = 17487793561,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v1["Bearing Shot"] = {
    Active = true,
    Damage = 30,
    Stun = 0.75,
    Distance = 2.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 17487881331,
            Volume = 2
        }
    },
    HitRemotes = { v8["Blood Hit"] },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 5,
        Offset = CFrame.identity
    }
};
v1["Precise Shards"] = {
    Active = true,
    Damage = 15,
    Stun = 0.3,
    Distance = 2.5,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 13.5,
        AfterMove = true
    },
    Block = {
        PerfectBlockable = false
    },
    HitRemotes = { v8["Blood Hit"] },
    HitSounds = {
        Hit = {
            SoundId = 17487881331,
            Volume = 2
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 3,
        Offset = CFrame.identity
    }
};
v1.Rampage = {
    Active = true,
    Time = 30,
    Actionable = {
        Active = true,

        Check = function(p40) -- Line: 500, Name: Check
            return not p40:GetAttribute("Rampage");
        end
    },
    Cooldown = {
        Time = 45,
        Manual = true
    },
    Meter = {
        RequiredAmount = 50
    }
};
v1["Stoning Thrust"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Thrust = {
        CheckPVPSafe = true,
        Stun = 0.5,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.identity
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        }
    },
    Trap = {
        Priority = EnumsModule.Intangible.Move,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "RockTrap",
                Overrides = {
                    Lifetime = 4
                }
            } }
    },
    Punch = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v8["Light Hit"] }
    },
    Slam = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move
    },
    Barrage = {
        Damage = 1.2,
        Priority = EnumsModule.Intangible.Move
    }
};
v1["Reverse Healing"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Punch = {
        Damage = 10,
        Stun = 0.8,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        },
        HitRemotes = { v8["Light Hit"] }
    },
    Heal = {
        Visual = 20,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v8.Heal }
    },
    Knock = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.25,
            Velocity = Vector3.new(0, 15, 0)
        },
        HitRemotes = { v8["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 17845225759,
                Volume = 2
            }
        }
    }
};
v1["Duplex Combination"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Punch = {
        HitAnimations = "Default",
        Damage = 15,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -8)
        },
        HitRemotes = { v8["Light Hit"] },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 17487829022,
                Volume = 2
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.25
        }
    },
    Slam = {
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15,
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.3,
            Velocity = Vector3.new(0, 5, 0)
        }
    }
};
v1["Destructive Blitz"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Punch = {
        Meter = false,
        HitAnimations = "Default",
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -8)
        },
        HitRemotes = { v8["Light Hit"] },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 17845026661,
                Volume = 2
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.25
        }
    },
    Slam = {
        Meter = false,
        HitAnimations = "Default",
        Damage = 15,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 11.5,
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 1.35
        },
        Ragdoll = {
            Time = 1.35,
            Intangible = false
        }
    }
};
v1["Recoil Impale"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Punch = {
        Meter = false,
        Damage = 10,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v8["Heavy Hit"] },
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = true
        },
        Stun = {
            Time = 1
        }
    },
    Impale = {
        Stun = 2.1,
        Damage = 30,
        Meter = false,
        Priority = EnumsModule.Intangible.Move
    }
};
v1["Blood Throw"] = {
    Active = true,
    Damage = 15,
    Meter = false,
    Distance = 2.5,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13.5,
        AfterMove = true
    },
    Hitbox = {
        Size = 3
    },
    HitSounds = {
        Hit = {
            SoundId = 17845027773,
            Volume = 2
        }
    },
    Block = {
        PerfectBlockable = false
    }
};
v1["Diamond Devastation"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = true
    },
    Startup = {
        Meter = false,
        Damage = 10,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15,
            Predict = false,
            Offset = CFrame.new(0, 0, -10)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Punch = {
        Meter = false,
        Damage = 4,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v8["Light Hit"] }
    },
    Smash = {
        Meter = false,
        Damage = 5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move
    },
    Breaker = {
        Meter = false,
        Damage = 5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move
    },
    Barrage = {
        Meter = false,
        Damage = 0.6,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move
    },
    Finisher = {
        Meter = false,
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Ragdoll = {
            Time = 3
        }
    }
};
v1["Line Breaker"] = {
    Active = true,
    Cooldown = 10,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 0.7
    },
    Block = {
        PerfectBlockable = false
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 10357795859,
            Volume = 1.5
        }
    },
    HitRemotes = { v8["Heavy Hit"] }
};

return {
    Stats = v1,
    Moveset = require(script.Moveset),
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Metadata = require(script.Metadata)
};