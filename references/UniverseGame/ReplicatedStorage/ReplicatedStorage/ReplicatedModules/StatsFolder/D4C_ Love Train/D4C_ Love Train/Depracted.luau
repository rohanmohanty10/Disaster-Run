  

 

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
Knit.OnStart():andThen(function() -- Line: 20
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local u2 = {
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
u2.Stats["Rush Attack"] = {
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
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        },
        HitRemotes = { u2.Resources.Blood }
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
            { 0, function(p3, p4, p5) -- Line: 112
                    -- upvalues: u2 (copy), TweenModule (copy)
                    local Character = p5.Character;

                    for _, descendant in pairs(Character.Stand:GetDescendants()) do
                        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and not table.find(u2.Resources.LeaveParts, descendant.Name) then
                            TweenModule:GetTweenObject(descendant, TweenInfo.new(0.2), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;

                    p5.Trove:Add(function() -- Line: 121
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
            { 50, function(p6, p7, p8) -- Line: 131
                    -- upvalues: TweenModule (copy)
                    for _, descendant in pairs(p8.Character.Stand:GetDescendants()) do
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
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        },
        HitRemotes = { u2.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 23, 27, "Attack" }, { 28, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        },
        HitRemotes = { u2.Resources.LightHit }
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
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        },
        HitRemotes = { u2.Resources.HeavyHit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p9, p10) -- Line: 228, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p9.Stats;

            if not Knit.CollectionService:HasTag(p9.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
u2.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = u2.Resources.LeaveParts,
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 186, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 129, 234)) }),

    OnSummon = function(p11, p12) -- Line: 253, Name: OnSummon
        -- upvalues: TweenModule (copy)
        local Character = p11.Character;
        local _ = Character.Humanoid;
        local Animator = p11.Animator;
        Character:FindFirstChild("Stand");
        local Knife = Character:FindFirstChild("Knife");
        local v13 = p12 and 1 or 0;
        Animator:PlayAnimation(p12 and "Summon" or "Unsummon", 1.3);
        TweenModule:GetTweenObject(Knife, TweenInfo.new(0.3), {
            Transparency = v13
        }):Play();

        for _, descendant in Knife:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                TweenModule:GetTweenObject(descendant, TweenInfo.new(0.3), {
                    Transparency = v13
                }):Play();
            end;
        end;
    end
};
u2.Stats["Bloodstained Rushdown"] = {
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
            } }, { 34, "BarrageAttack", "Punch" }, { 64, "BarrageAttack", "Punch2" }, { 83, "Cancelable", true }, { 83, "Clashable", true }, { 83, "Barrage", true }, { 83, 263, "BarrageAttack", "Hit" }, { 263, "Cancelable", false }, { 263, "Clashable", false }, { 263, "BarrageFinisher" }, { 290, "BarrageAttack", "Finisher" }, { 326, "End" } },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    Hit = TableUtil.Reconcile({
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 14),
            Offset = CFrame.new(0, 0, -5),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        HitRemotes = { u2.Resources.LightHit }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        HitRemotes = { u2.Resources.HeavyHit }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    Punch = {
        Damage = 8,
        HitAnimations = "Default",
        HitRemotes = { u2.Resources.LightHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.65,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        }
    },
    Punch2 = {
        Damage = 8,
        HitAnimations = "Default",
        HitRemotes = { u2.Resources.LightHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.65,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        }
    },
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
u2.Stats["Violent Storm"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p14) -- Line: 388, Name: Check
            return not p14:GetAttribute("LMBDisabled");
        end
    },
    Cooldown = {
        Time = 2,
        AfterMove = true
    },
    Hit = {
        HitAnimations = "Default",
        Damage = 4,
        Stun = 2,
        HitRemotes = { u2.Resources.Blood },
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
        HitRemotes = { u2.Resources.Blood },
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
            BlockBreak = true
        }
    },
    Final = {
        Damage = 15,
        HitRemotes = { u2.Resources.Blood },
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
u2.Stats["Spilling Of Blood"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        Damage = 25,
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
    }
};
u2.Stats["Facial Disfiguration"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
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
        }
    },
    Finisher = {
        Damage = 20,
        Stun = 0.8,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 45,
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
        }
    }
};
u2.Stats["Inimical Rupture"] = {
    Active = true,
    Duration = 0.4,
    Reach = 30,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p15) -- Line: 597, Name: Check
            return not p15:GetAttribute("LMBDisabled");
        end
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { u2.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = true
        }
    },
    Impale = {
        Damage = 40,
        Priority = Enums.Intangible.Move
    }
};
u2.Stats["Powered Slice"] = {
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
        HitRemotes = { u2.Resources.Blood },
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
        HitRemotes = { u2.Resources.Blood },
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
u2.Stats["Precision Disposal"] = {
    Active = true,
    Damage = 40,
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
    HitRemotes = { u2.Resources.Blood },
    Knockback = {
        Speed = 35,
        Time = 0.1,
        RelativeTowards = "Target"
    },
    Ragdoll = {
        Time = 1.5
    }
};
u2.Stats["Fanfire Disposal"] = {
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    HitRemotes = { u2.Resources.Blood },
    Stun = {
        Time = 0.4
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true
    }
};
u2.Stats["Misfortune Riposte"] = {
    Active = true,
    Actionable = {
        Stunned = false,
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Dimension = {
        Damage = 3,
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
u2.Stats["Head Bomb"] = {
    Active = true,
    Damage = 22.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
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
        Unblockable = true
    },

    Invoke = function(p16) -- Line: 896, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p16.Input;
        Knit.GetController("MoveInputController");
        local v17 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v18 = LocalPlayer:GetMouse();
        local v19 = OverlapParams.new();
        v19.FilterType = Enum.RaycastFilterType.Include;
        v19.FilterDescendantsInstances = { workspace.Living };
        v19.MaxParts = 300;
        local v20 = workspace:GetPartBoundsInRadius(v18.Hit.Position, 75, v19);
        local v21 = {};
        local v22 = nil;
        local v23 = nil;

        for _, v in pairs(v20) do
            local v24 = v.Parent:FindFirstChildOfClass("Humanoid");

            if v24 and not (v21[v.Parent] or v:IsDescendantOf(Character)) then
                v21[v.Parent] = v24;
            end;
        end;

        for i, _ in pairs(v21) do
            local v25 = i:FindFirstChild("HumanoidRootPart") or i:FindFirstChildOfClass("BasePart");

            if v25 then
                local Magnitude = (v18.Hit.Position - v25.Position).Magnitude;

                if not v22 or Magnitude < v23 then
                    v23 = Magnitude;
                    v22 = i;
                end;
            end;
        end;

        v17:FireInput(Input, v22);
    end
};
u2.Stats["Presidential Leverage"] = {
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
        HitRemotes = { u2.Resources.LightHit },
        Block = {
            Unblockable = true
        }
    },
    Slam = {
        Damage = 15,
        Priority = Enums.Intangible.Move
    },
    Stab = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        HitRemotes = { u2.Resources.Blood }
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
u2.Stats["Flawless Execution"] = {
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
        HitRemotes = { u2.Resources.LightHit },
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
        HitRemotes = { u2.Resources.Blood },
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
u2.Stats["Dimensional Clone"] = {
    From = "D4C.Dimensional Clone"
};
u2.Stats["Dimensional Shift"] = {
    From = "D4C.Dimensional Shift"
};
u2.Stats["Adverse Force"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        Stun = 4,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { u2.Resources.LightHit },
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
        HitRemotes = { u2.Resources.LightHit }
    },
    Kick = {
        Priority = Enums.Intangible.Move,
        HitRemotes = { u2.Resources.HeavyHit },
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
u2.Stats["Brutal Scotch"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
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
        HitRemotes = { u2.Resources.Blood }
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
u2.Stats.Block = {
    From = "Combat.Block"
};
u2.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
u2.Stats.Breaker = {
    From = "Combat.Breaker"
};

return u2;