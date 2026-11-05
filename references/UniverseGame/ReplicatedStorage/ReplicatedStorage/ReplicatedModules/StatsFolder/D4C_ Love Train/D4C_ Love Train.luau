  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = ReplicatedStorage["Client Assets"];
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local TweenModule = require(PathShortcuts.ClientModulesPath.TweenModule);
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 22
    -- upvalues: u2 (ref), Knit (copy)
    u2 = Knit.GetService("EffectService");
end);

if game:GetService("RunService"):IsServer() then
    local v3 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    require(v3.Common);
end;

local u4 = {
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
    Resources = require(script.Resources)
};
u4.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    CustomPrefix = "LMB",
    ComboTick = 1.5,
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.8,
        Stun = 0.65,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "StandOffSwingLMB-1" }, { 26, 30, "Attack" }, { 33, "End" } },
        HitSounds = u4.Resources.BloodLMB,
        HitRemotes = { u4.Resources.Blood }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "StandOffSwingLMB-2" }, { 27, 31, "Attack" }, { 42, "End" } },
        HitSounds = u4.Resources.BloodLMB
    },
    ["StandOff-LMB-3"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "StandOffSwingLMB-3" }, { 25, 28, "Attack" }, { 38, "End" } },
        HitSounds = u4.Resources.BloodLMB
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.75,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, function(p5, p6, p7) -- Line: 121
                    -- upvalues: u4 (copy), TweenModule (copy)
                    local Character = p7.Character;

                    for _, descendant in pairs(Character.Stand:GetDescendants()) do
                        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and not table.find(u4.Resources.LeaveParts, descendant.Name) then
                            TweenModule:GetTweenObject(descendant, TweenInfo.new(0.2), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;

                    p7.Trove:Add(function() -- Line: 130
                        -- upvalues: Character (copy), TweenModule (ref)
                        for _, descendant in pairs(Character.Stand:GetDescendants()) do
                            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                                TweenModule:GetTweenObject(descendant, TweenInfo.new(0.3), {
                                    Transparency = 1
                                }):Play();
                            end;
                        end;
                    end);
                end },
            { 0, "PlaySound", "StandOffSwingLMB-4" },
            { 36, 44, "Attack" },
            { 50, function(p8, p9, p10) -- Line: 140
                    -- upvalues: TweenModule (copy)
                    for _, descendant in pairs(p10.Character.Stand:GetDescendants()) do
                        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                            TweenModule:GetTweenObject(descendant, TweenInfo.new(0.3), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end },
            { 50, "End" }
        },
        Hitbox = BaseStatsModule.Stand_Rush_Attack.Hitbox,
        HitSounds = u4.Resources.LightHitSFX,
        HitRemotes = { u4.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-1" }, { 23, 27, "Attack" }, { 28, "End" } },
        HitSounds = u4.Resources.LightHitSFX,
        HitRemotes = { u4.Resources.LightHit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-2" }, { 18, 22, "Attack" }, { 28, "End" } },
        HitSounds = u4.Resources.LightHitSFX
    },
    ["LMB-3"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-3" }, { 19, 23, "Attack" }, { 27, "End" } },
        HitSounds = u4.Resources.LightHitSFX
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB-4" }, { 22, 25, "Attack" }, { 42, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        },
        HitRemotes = { u4.Resources.HeavyHit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p11, p12) -- Line: 231, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p11.Stats;

            if not Knit.CollectionService:HasTag(p11.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
u4.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = u4.Resources.LeaveParts,
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 186, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 129, 234)) }),

    OnSummon = function(p13, p14) -- Line: 256, Name: OnSummon
        -- upvalues: TweenModule (copy)
        local Character = p13.Character;
        local _ = Character.Humanoid;
        local Animator = p13.Animator;
        Character:FindFirstChild("Stand");
        local Knife = Character:FindFirstChild("Knife");
        local v15 = p14 and 1 or 0;
        Animator:PlayAnimation(p14 and "Summon" or "Unsummon", 1.3);
        TweenModule:GetTweenObject(Knife, TweenInfo.new(0.3), {
            Transparency = v15
        }):Play();

        for _, descendant in Knife:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                TweenModule:GetTweenObject(descendant, TweenInfo.new(0.3), {
                    Transparency = v15
                }):Play();
            end;
        end;
    end
};
u4.Stats["Bloodstained Rushdown"] = {
    Active = true,
    Speed = 1.1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } }, { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } }, { 34, "Cancelable", true }, { 34, "BarrageAttack", "Punch" }, { 64, "BarrageAttack", "Punch2" }, { 83, "Clashable", true }, { 83, "Barrage", true }, { 83, 263, "BarrageAttack", "Hit" }, { 263, "Cancelable", false }, { 263, "Clashable", false }, { 263, "BarrageFinisher" }, { 290, "BarrageAttack", "Finisher" }, { 326, "End" } },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    Hit = TableUtil.Reconcile({
        Damage = 0.6,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 14),
            Offset = CFrame.new(0, 0, -5),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        HitRemotes = { u4.Resources.LightHit },
        HitSounds = u4.Resources.BarrageHit
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        HitSounds = u4.Resources.BarrageEnd,
        HitRemotes = { u4.Resources.HeavyHit }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    Punch = {
        Damage = 8,
        HitAnimations = "Default",
        HitRemotes = { u4.Resources.LightHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.65,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitSounds = u4.Resources.BarrageHit
    },
    Punch2 = {
        Damage = 8,
        HitAnimations = "Default",
        HitRemotes = { u4.Resources.LightHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.65,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitSounds = u4.Resources.BarrageHit
    },
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
u4.Stats["Violent Storm"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p16) -- Line: 402, Name: Check
            return not p16:GetAttribute("LMBDisabled");
        end
    },
    Cooldown = {
        Time = 9,
        AfterMove = true
    },
    Hit = {
        HitAnimations = "Default",
        Damage = 4,
        Stun = 2.4,
        HitRemotes = { u4.Resources.Blood },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.15
        },
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 72253066957608,
                Volume = 2
            }
        }
    },
    Barrage = {
        HitAnimations = "Default",
        Damage = 2.15,
        Stun = 0.35,
        HitRemotes = { u4.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.15
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = {
            Hit = {
                SoundId = 134923352135073,
                Volume = 2
            }
        },
        Block = {
            PerfectBlockable = false
        }
    },
    BarrageLast = {
        HitAnimations = "Default",
        Damage = 2.25,
        Stun = 1.25,
        HitRemotes = { u4.Resources.Blood },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.15
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = {
            Hit = {
                SoundId = 134923352135073,
                Volume = 2
            }
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Final = {
        Damage = 10,
        HitRemotes = { u4.Resources.Blood },
        Ragdoll = {
            Time = 1.25
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 125169257879150,
                Volume = 2
            }
        }
    }
};
u4.Stats["Facial Disfiguration"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hit = {
        Damage = 10,
        Stun = 0.8,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.identity
        },
        HitSounds = u4.Resources.BarrageHit,
        HitRemotes = { u4.Resources.Blood }
    },
    Finisher = {
        Damage = 15,
        Finisher = true,
        Stun = 1.5,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.identity
        },
        HitSounds = u4.Resources.BarrageHit,
        HitRemotes = { u4.Resources.Blood }
    },
    Ender = {
        Damage = 25,
        Stun = 0.8,
        HitAnimations = "Default",
        Knockback = {
            Speed = 60,
            Velocity = Vector3.new(0, 40, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 3
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.identity
        },
        HitSounds = u4.Resources.BarrageHit,
        HitRemotes = { u4.Resources.Blood }
    }
};
u4.Stats["Inimical Rupture"] = {
    Active = true,
    Duration = 0.4,
    Reach = 30,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p17) -- Line: 645, Name: Check
            return not p17:GetAttribute("LMBDisabled");
        end
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Damage = 10,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { u4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = true
        }
    },
    Impale = {
        Damage = 35,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 93716475090814,
                Volume = 2
            }
        }
    }
};
u4.Stats["Liberty Lunge"] = {
    Active = true,
    Damage = 35,
    Speed = 2.35,
    EndFrame = 125,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(8, 6, 15),
        Offset = CFrame.identity
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Velocity = Vector3.new(0, 14, 0),
        Time = 0.12
    },
    Stun = {
        Time = 1.25
    },
    Ragdoll = {
        Time = 1.4
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    HitRemotes = { u4.Resources.Blood },
    HitSounds = {
        Hit = {
            SoundId = 133481333308541,
            Volume = 1
        }
    }
};
u4.Stats["Powered Slice"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Slice = {
        Damage = 15,
        Stun = 0.8,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitRemotes = { u4.Resources.Blood },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.identity
        }
    },
    Pierce = {
        Damage = 30,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.1
        },
        HitRemotes = { u4.Resources.Blood },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.identity
        },
        Ragdoll = {
            Time = 2
        }
    }
};
u4.Stats["Eagle Impact"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    EndFrame = 40,
    AttackFrame = 26,
    Iteration = 5,
    AppearFrame = 10,
    DontDisappear = true,
    DisappearFrame = 31,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 0.15
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 10,
        RemoveMeter = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "StandHumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    Knockback = {
        RelativePart = "Target",
        Speed = 40,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
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
                    Particle = v1.Universal.UniversalHeavyVFX,
                    Offset = CFrame.Angles(0, 3.141592653589793, 0),
                    Color = Color3.fromRGB(255, 255, 255)
                }
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 13703109636,
            Volume = 1.5
        }
    },
    Block = {
        PerfectBlockable = false
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "WoundedRightArm",
            Lifetime = 3,
            Cut = true
        } },
    C0 = CFrame.new(0, 0, 9),
    Detect = {
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    }
};
u4.Stats["Precision Disposal"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(48, 48, 64),
            Offset = CFrame.new(0, 0, -32)
        }
    },
    HitRemotes = { u4.Resources.Blood },
    Knockback = {
        Speed = 35,
        Time = 0.1,
        RelativeTowards = "Target"
    },
    Ragdoll = {
        Time = 1.5
    },
    HitSounds = {
        Hit = {
            SoundId = 85061869675937,
            Volume = 2
        }
    }
};
u4.Stats["Fanfire Disposal"] = {
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    HitRemotes = { u4.Resources.Blood },
    Stun = {
        Time = 0.4
    },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 85061869675937,
            Volume = 2
        }
    }
};
u4.Stats["Misfortune Riposte"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Dimension = {
        Damage = 2,
        Priority = Enums.Intangible.Move
    },
    Throw = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 60,
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
    }
};
u4.Stats["Head Bomb"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Manual = true
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 0.3,
        Priority = Enums.Stun.Medium
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 6430992501,
            Volume = 1.5
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 65,
        Time = 0.2,
        Velocity = Vector3.new(0, 5, 0)
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },

    Invoke = function(p18) -- Line: 1112, Name: Invoke
        -- upvalues: Knit (copy)
        Knit.GetController("MoveInputController");
        local v19 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v20 = LocalPlayer:GetMouse();
        local v21 = OverlapParams.new();
        v21.FilterType = Enum.RaycastFilterType.Include;
        v21.FilterDescendantsInstances = { workspace.Living };
        v21.MaxParts = 300;
        local v22 = workspace:GetPartBoundsInRadius(v20.Hit.Position, 75, v21);
        local v23 = {};
        local v24 = nil;
        local v25 = nil;

        for _, v in pairs(v22) do
            local v26 = v.Parent:FindFirstChildOfClass("Humanoid");

            if v26 and not (v23[v.Parent] or v:IsDescendantOf(Character)) then
                v23[v.Parent] = v26;
            end;
        end;

        for i, _ in pairs(v23) do
            local v27 = i:FindFirstChild("HumanoidRootPart") or i:FindFirstChildOfClass("BasePart");

            if v27 then
                local Magnitude = (v20.Hit.Position - v27.Position).Magnitude;

                if not v24 or Magnitude < v25 then
                    v25 = Magnitude;
                    v24 = i;
                end;
            end;
        end;

        v19:FireInput(p18.RawInput, v24);
    end
};
u4.Stats["Constitutional Example"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 11,
        AfterMove = true
    },
    Hit = {
        Damage = 20,
        Stun = 0.8,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        HitRemotes = { u4.Resources.Blood }
    },
    Barrier = {
        Damage = 1.25,
        Hitbox = {
            Size = Vector3.new(20, 8, 5),
            Predict = false
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.3
        },
        HitSounds = {
            Hit = {
                SoundId = 139366061694799,
                Volume = 2
            }
        }
    }
};
u4.Stats["Presidential Leverage"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            HitboxType = "ClientHitbox",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { u4.Resources.LightHit },
        Block = {
            Blockable = true
        }
    },
    Slam = {
        Damage = 15,
        Priority = Enums.Intangible.Move
    },
    Stab = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.Blood }
    },
    Throw = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 60,
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
    Barrier = {
        Damage = 2,
        Hitbox = {
            Size = Vector3.new(5, 8, 20),
            Predict = false
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.3
        }
    }
};
u4.Stats["Flawless Execution"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            HitboxType = "ClientHitbox",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { u4.Resources.LightHit },
        Block = {
            Unblockable = true
        }
    },
    Slam = {
        Damage = 15,
        Priority = Enums.Intangible.Move
    },
    Shoot = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.Blood },
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Speed = 60,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
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
    }
};
u4.Stats["Dimensional Clone"] = {
    From = "D4C.Dimensional Clone"
};
u4.Stats["Dimensional Shift"] = {
    From = "D4C.Dimensional Shift"
};
u4.Stats["Spilling Of Blood"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Startup = {
        Damage = 20,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        }
    },
    Throw = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            Speed = 35,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
u4.Stats["Adverse Force"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Stun = 4,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { u4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Strike = {
        Damage = 3.5,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 1,
            Priority = Enums.Stun.True
        },
        HitRemotes = { u4.Resources.LightHit }
    },
    Kick = {
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.HeavyHit },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.2
        },
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
u4.Stats["Brutal Scotch"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Cut = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.Blood }
    },
    Release = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 20, 0),
            Time = 0.2
        },
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
u4.Stats.Block = {
    From = "Combat.Block"
};
u4.Stats.Pose = {
    From = "Combat.Pose"
};
u4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
u4.Stats.Breaker = {
    From = "Combat.Breaker"
};

return u4;