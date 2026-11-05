  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local ReplicatedStorage = PathShortcuts.ReplicatedStorage;
local _ = PathShortcuts.Players.LocalPlayer;
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local ParticleInfo = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 22
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Common/Hit",
            AutoSerialize = true,
            LookAt = "Attacker",
            HueShift = false
        } }
};
local v8 = {
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
    Resources = require(script.Resources),
    Metadata = {
        PostRig = function(p5) -- Line: 65, Name: PostRig
            -- upvalues: ParticleInfo (copy), ParticleHandler (copy)
            local Character = p5.Character;
            Character:WaitForChild("Left Arm").Transparency = 1;

            if p5.SkinName then
                local v6 = ParticleInfo.GetSkinInfo(p5.SkinName);
                local v7;

                if v6 and v6.Metadata.HSVShift then
                    v7 = v6.Metadata.HSVShift;
                else
                    v7 = nil;
                end;

                for _, descendant in Character.Weapon:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") and v7 then
                        descendant.Color = ParticleHandler.HSVShift(descendant.Color, v7);
                    end;
                end;
            end;
        end
    }
};
v8.Stats.Block = {
    From = "Combat.Block"
};
v8.Stats.Breaker = {
    From = "Combat.Breaker"
};
v8.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v8.Stats.Pose = {
    From = "Combat.Pose"
};
v8.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 13, function(p9, p10, p11) -- Line: 121
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Gryphon LMB", p11);
                end },
            { 14, 17, "Attack" },
            { 22, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        },
        HitRemotes = { v4 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 13, function(p12, p13, p14) -- Line: 144
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Gryphon LMB", p14);
                end },
            { 15, 17, "Attack" },
            { 23, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 15, function(p15, p16, p17) -- Line: 165
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Gryphon LMB", p17);
                end },
            { 19, 21, "Attack" },
            { 26, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 14448218594,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.1,
        Damage = 16,
        Sequence = {
            { 0, "Start" },
            { 24, 26, "Attack" },
            { 26, function(p18, p19, p20) -- Line: 186
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Gryphon LMB", p20);
                end },
            { 30, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 14448218250,
                Volume = 1
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 6, 10),
            Offset = CFrame.new(0, 0, -8)
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p21, p22) -- Line: 209, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Count = p21.CharacterState["Rush Attack"].Count;
            local v23 = TableUtil.Copy(p21.Stats, true);
            local v24 = v23["LMB-" .. Count];

            if Count < 4 then
                v24.Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(9, 8, 10),
                    Offset = CFrame.new(0, 0, -5)
                };
            end;

            v24.Stun = {
                Time = 0.7
            };

            return v23;
        end
    }
};
v8.Stats.Grab = {
    From = "Combat.Grab",
    AttackFrame = 62
};
v8.Stats["Yasopp Assist"] = {
    Damage = 30,
    Actionable = {
        Active = true,

        Check = function(p25) -- Line: 246, Name: Check
            return not p25:GetAttribute("YassopAssist");
        end
    },
    Cooldown = {
        Time = 25,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Hitbox = {
        Size = Vector3.new(16.5, 16.5, 44),
        Debug = false,
        Offset = CFrame.new(0, 0, -20)
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        Speed = 50,
        Velocity = Vector3.new(0, 14, 0),
        Time = 0.12
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    HitSounds = {
        Hit = {
            SoundId = 18892184427,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/YasoppAssist/BulletHitVFX",
                    AutoSerialize = true,
                    LookAt = "Attacker",
                    HueShift = false
                } }
        } }
};
v8.Stats["Crescent Cycle"] = {
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
    HitSounds = {
        Hit = {
            SoundId = 18892171298,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    HitRemotes = { v4 },
    Finisher = {
        Damage = 25,
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
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 18892170980,
                Volume = 1
            }
        },
        HitRemotes = { v4 }
    }
};
v8.Stats["Piercing Falcon"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
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
            SoundId = 18892174265,
            Volume = 1
        }
    },
    HitRemotes = { v4 }
};
v8.Stats["Lightning Draw"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 22,
        Debug = false
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        Speed = 46,
        Time = 0.1
    },
    Block = {
        BlockBreak = true,
        Blockable = true,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 18892172739,
            Volume = 1
        }
    }
};
v8.Stats["Divine Departure"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 27.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30,
        RemoveMeter = true
    },
    RunDistance = 80,
    Hitbox = {
        Size = Vector3.new(25, 10, 20),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -12)
    },
    Damage = 20,
    Block = {
        PerfectBlockable = true,
        Blockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Velocity = Vector3.new(0, 19, 0),
        Speed = 45,
        Time = 0.12
    },
    Stun = {
        Time = 1.5
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 18892175793,
            Volume = 1
        }
    },
    Explosion = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Blockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Velocity = Vector3.new(0, 20, 0),
            Speed = 45,
            Time = 0.25
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.75
        },
        HitRemotes = { v4 }
    }
};
v8.Stats["Bolt Gash"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10.5, 10.5, 10.5),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 15,
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
            SoundId = 18892173686,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/BoltGash/BloodBlowStab",
                    LookAt = "Target",
                    HueShift = false
                } }
        } },
    Followup = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.15
        },
        Stun = {
            Time = 1.25
        }
    }
};
v8.Stats["Earth-Rending Sever"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 18.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15,
        RemoveMeter = true,
        MeterGain = 0
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(25, 10, 20),
        Offset = CFrame.new(0, 0, -7.5)
    },
    Damage = 15,
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
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 18892177119,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/RendingSever/HitVFX",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    Projectile = {
        Damage = 30,
        Meter = false,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.5,
            Velocity = Vector3.new(0, 5, 0)
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
                SoundId = 18892205748,
                Volume = 1
            }
        },
        HitRemotes = {}
    }
};
v8.Stats["Superior Slash"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = true
    },
    Finisher = {
        Damage = 50,
        Priority = Enums.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(18, 18, 18),
            Offset = CFrame.new(0, 0, -12.5)
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 40,
            Time = 0.4,
            Velocity = Vector3.new(0, 35, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.85
        }
    },
    Lock = {
        CheckPVPSafe = true,
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 30, 30),
            Offset = CFrame.new(0, 0, -12.5)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        Stun = {
            Time = 4
        }
    }
};
v8.Stats["Final Departure"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 10,
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Finisher = {
        Damage = 85,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Knockback = {
            Speed = 60,
            Time = 0.4,
            Velocity = Vector3.new(0, 35, 0),
            RelativeTowards = "Target"
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 1
        }
    }
};
v8.Stats["Thunderous Crash"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        BlockBreak = true,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        Speed = 40,
        Time = 0.15,
        Velocity = Vector3.new(0, 35, 0),
        RelativeTowards = "Target"
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 32,
        Debug = false
    },
    HitSounds = {
        Hit = {
            SoundId = 18892174838,
            Volume = 1
        }
    }
};
v8.Stats["Thunderous Shatter"] = {
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
    Limit = 4,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 17.5,
        Offset = CFrame.new(0, -1.5, 0)
    },
    Damage = 10,
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = false,
        Blockable = true
    },
    HitAnimations = "Default",
    Burst = {
        Damage = 25,
        HitAnimations = "Default",
        Knockback = {
            Speed = 30,
            Time = 0.15,
            Velocity = Vector3.new(0, 35, 0),
            RelativeTowards = "Target"
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.85
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true,
            Blockable = true
        }
    }
};

return v8;