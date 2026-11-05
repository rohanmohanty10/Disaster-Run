  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local TweenModule = require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;
local u2;

if game:GetService("RunService"):IsServer() then
    local v3 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    u2 = require(v3.Common);
else
    u2 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 28
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
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
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 26, 30, "Attack" }, { 33, "End" } },
        HitSounds = u4.Resources.BloodLMB,
        HitRemotes = { u4.Resources.Blood }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 27, 31, "Attack" }, { 42, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 25, 28, "Attack" }, { 38, "End" } }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.75,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, function(p5, p6, p7) -- Line: 113
                    -- upvalues: u4 (copy), TweenModule (copy)
                    local Character = p7.Character;

                    for _, descendant in pairs(Character.Stand:GetDescendants()) do
                        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and not table.find(u4.Resources.LeaveParts, descendant.Name) then
                            TweenModule:GetTweenObject(descendant, TweenInfo.new(0.2), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;

                    p7.Trove:Add(function() -- Line: 122
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
            { 0, "PlaySound", "SwingLMB 4" },
            { 36, 44, "Attack" },
            { 50, function(p8, p9, p10) -- Line: 132
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
        HitSounds = u4.Resources.StandLMB2,
        HitRemotes = { u4.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 23, 27, "Attack" }, { 28, "End" } },
        HitSounds = u4.Resources.StandLMB1,
        HitRemotes = { u4.Resources.LightHit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 18, 22, "Attack" }, { 28, "End" } }
    },
    ["LMB-3"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 19, 23, "Attack" }, { 27, "End" } }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 22, 25, "Attack" }, { 42, "End" } },
        HitSounds = u4.Resources.StandLMB2,
        HitRemotes = { u4.Resources.HeavyHit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p11, p12) -- Line: 214, Name: StateChecker
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
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 186, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 129, 234)) }),

    OnSummon = function(p13, p14) -- Line: 239, Name: OnSummon
        -- upvalues: TweenModule (copy)
        local Character = p13.Character;
        local _ = Character.Humanoid;
        local Animator = p13.Animator;
        Character:FindFirstChild("Stand");
        local Knife = Character:FindFirstChild("Knife");
        local v15 = p14 and 1 or 0;
        local v16 = Animator:GetAnimation(p14 and "Summon" or "Desummon");

        if v16 then
            v16:Play();
        end;

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
u4.Stats["Cleaving Barrage"] = TableUtil.Reconcile({
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
        HitSounds = u4.Resources.BarrageHit,
        HitRemotes = { u4.Resources.LightHit }
    },
    Finisher = {
        HitSounds = u4.Resources.BarrageEnd,
        HitRemotes = { u4.Resources.HeavyHit }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = u4.Resources.BarrageHit
    },
    ClashFinisher = {
        HitSounds = u4.Resources.BarrageEnd
    }
}, BaseStatsModule.Stand_Barrage);
u4.Stats["Violent Storm"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p17) -- Line: 313, Name: Check
            return not p17:GetAttribute("LMBDisabled");
        end
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Hit = {
        HitAnimations = "Default",
        Damage = 4,
        Stun = 2,
        HitRemotes = { u4.Resources.Blood },
        HitSounds = u4.Resources.Storm1,
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
        }
    },
    Barrage = {
        HitAnimations = "Default",
        Damage = 2,
        Stun = 2,
        HitRemotes = { u4.Resources.Blood },
        HitSounds = u4.Resources.Storm2,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.15
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Final = {
        Damage = 15,
        HitSounds = u4.Resources.Storm3,
        HitRemotes = { u4.Resources.Blood },
        Ragdoll = {
            Time = 1
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
        }
    }
};
u4.Stats["Powered Slice"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 7,
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
        HitSounds = u4.Resources.Storm2,
        HitRemotes = { u4.Resources.Blood },
        Block = {
            PerfectBlockable = true,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.identity
        }
    },
    Pierce = {
        Damage = 30,
        HitAnimations = "Default",
        HitSounds = u4.Resources.Storm1,
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
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.identity
        },
        Ragdoll = {
            Time = 2
        }
    }
};
u4.Stats["Swift Puncture"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Chop = {
        Damage = 15,
        Stun = 1,
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
        HitRemotes = { u4.Resources.Blood },
        HitSounds = u4.Resources.Chop,
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        }
    },
    Impale = {
        Damage = 5,
        Stun = 2,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        }
    },
    Throw = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.2
        },
        StatusEffects = { {
                Name = "Bleed"
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
u4.Stats["Precision Disposal"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = {
            Ignore = { "Barrage" }
        }
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(48, 48, 64),
            Offset = CFrame.new(0, 0, -32)
        }
    },
    HitRemotes = { u4.Resources.Blood },
    HitSounds = u4.Resources.Precision,
    Knockback = {
        Speed = 35,
        Time = 0.1,
        RelativeTowards = "Target"
    },
    Ragdoll = {
        Time = 1.5
    }
};
u4.Stats["Fanfire Disposal"] = {
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = {
            Ignore = { "Barrage" }
        }
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    HitRemotes = { u4.Resources.Blood },
    HitSounds = u4.Resources.Fanfire,
    Stun = {
        Time = 0.4
    },
    Block = {
        PerfectBlockable = false
    }
};
u4.Stats["Capital Punishment"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Startup = {
        Damage = 5,
        Stun = 1,
        HitRemotes = { u4.Resources.LightHit },
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
    Slam = {
        Damage = 10,
        Priority = Enums.Intangible.Move
    },
    Stab = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.Blood }
    },
    Hit = {
        Damage = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.LightHit }
    },
    Kick = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { u4.Resources.HeavyHit },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 75,
            Time = 0.1
        },
        Ragdoll = {
            Time = 3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
u4.Stats["Menger Sponge"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Linger = {
        Damage = 2.5,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Chop = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Heavy
        },
        Ragdoll = {
            Time = 3
        },
        StatusEffects = { {
                Name = "Bleed"
            } },
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
u4.Stats["Killer\'s Hand"] = {
    Active = true,
    CheckPVPSafe = true,
    Duration = 0.8,
    Reach = 50,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p18) -- Line: 810, Name: Check
            return not p18:GetAttribute("LMBDisabled");
        end
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            CheckPVPSafe = true,
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { u4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            Unblockable = true
        }
    },
    Slice = {
        Damage = 7,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.Blood }
    },
    Headbutt = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.LightHit }
    },
    Cut = {
        Damage = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u4.Resources.Blood }
    },
    Release = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
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
u4.Stats["Dimensional Clone"] = {
    Active = true,
    MaxClones = 3,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 35,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Block = {
        BypassCounter = true,
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 50,
        Offset = CFrame.identity
    }
};
u4.Stats["Dimensional Shift"] = {
    Active = true,
    CheckPVPSafe = true,
    MaxClones = 3,
    DimensionDuration = 30,
    SpeedReduction = 0.7,
    Actionable = {
        Active = true,

        Check = function(p19) -- Line: 942, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v20;

            if p19 then
                v20 = p19:GetAttribute("InDomain") or p19:GetAttribute("CantDomain");
            else
                v20 = p19;
            end;

            local v21 = game.Players:GetPlayerFromCharacter(p19);

            if v20 and v21 then
                UIOutput:FireClient(v21, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "D4C",
                    Verb = "",
                    Subject = "You can\'t use this ability during a closed Domain."
                });
                UIOutput:FireClient(v21, "PlaySound", "ope_invalid_move");

                return false;
            end;

            local v22 = not v20 and not workspace:GetAttribute("ActiveDimension");

            return v22;
        end
    },
    Cooldown = {
        Time = 125,
        Manual = true,
        AfterMove = true
    },
    _Meter = {
        RequiredAmount = 75,
        RemoveMeter = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 50,
        Offset = CFrame.identity
    }
};
u4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p23) -- Line: 985, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy), u2 (ref)
            local v24 = TableUtil.Copy(p23.Stats, true);

            if Knit.CollectionService:HasTag(p23.Character, "Summoned") then
                local v25 = math.random(1, 10);
                v24.PoseMusic = "StandPoseMusic";

                if v25 <= 1 then
                    v24.PoseMusic = "LvlPoseMusic";
                end;

                p23.Trove:Add(u2.CreateFlag(p23.Character, {
                    MakePartP0 = true,
                    UseMotor6D = true,
                    Part = p23.Character["Left Arm"],
                    Offset = CFrame.new(0, -3.5, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
                }));
                v24.StartAnim = "StandPoseTransition";
                v24.LoopAnim = "StandPoseIdle";
            end;

            return v24;
        end
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
            RelativeTowards = "Target",
            Speed = 40,
            Time = 0.1
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
u4.Stats["Clone Swap"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p26) -- Line: 1153, Name: Check
            return p26:GetAttribute("ActiveClone");
        end
    }
};
u4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
u4.Stats.Breaker = {
    From = "Combat.Breaker"
};

return u4;