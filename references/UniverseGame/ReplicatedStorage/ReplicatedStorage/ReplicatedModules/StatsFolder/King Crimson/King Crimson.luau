  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local TweenModule = require(game.ReplicatedStorage.ClientModules.TweenModule);
local v1 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Unlock = {
                Visible = false,
                Show = false,
                Priority = 5
            },
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOn = {
                Visible = false,
                Priority = 2
            },
            StandOff = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    RigInfo = require(script.RigInfo),
    Metadata = require(script.Metadata)
};
v1.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = { "StandHumanoidRootPart", "FAKE", "StandAura2" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 5, 5)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 5, 5)) })
};
v1.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB" }, { 22, 25, "Attack" }, { 27, "End" } },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 11107147004,
                Volume = 2
            }
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        HitSounds = {
            Hit = {
                SoundId = 11107148097,
                Volume = 2
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB" }, { 32, 37, "Attack" }, { 45, "End" } },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 11107149015,
                Volume = 2
            }
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = { { 0, "Start" }, { 16, 19, "Attack" }, { 24, "End" } },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 11247094607,
                Volume = 2
            }
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Sequence = { { 0, "Start" }, { 17, 20, "Attack" }, { 24, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Sequence = { { 0, "Start" }, { 17, 20, "Attack" }, { 24, "End" } }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 6, function(p2, p3, p4, p5) -- Line: 186
                    -- upvalues: TweenModule (copy)
                    local v6 = p5.SequenceTrove or p5.Trove;
                    local u7 = p4.Character.Stand["Stand Left Arm"];
                    TweenModule:GetTweenObject(u7, TweenInfo.new(0.3), {
                        Transparency = 0
                    }):Play();

                    for _, descendant in ipairs(u7:GetDescendants()) do
                        if (descendant:IsA("Weld") or descendant:IsA("WeldConstraint")) and descendant.Part1 then
                            if descendant.Part1.Name ~= "FAKE" then
                                TweenModule:GetTweenObject(descendant.Part1, TweenInfo.new(0.3), {
                                    Transparency = 0
                                }):Play();
                            end;

                            for _, descendant2 in ipairs(descendant.Part1:GetDescendants()) do
                                if descendant2:IsA("BasePart") or (descendant2:IsA("Texture") or descendant2:IsA("Decal")) then
                                    TweenModule:GetTweenObject(descendant2, TweenInfo.new(0.3), {
                                        Transparency = 0
                                    }):Play();
                                end;
                            end;
                        end;
                    end;

                    v6:Add(function() -- Line: 205
                        -- upvalues: TweenModule (ref), u7 (copy)
                        TweenModule:GetTweenObject(u7, TweenInfo.new(0.3), {
                            Transparency = 1
                        }):Play();

                        for _, descendant in ipairs(u7:GetDescendants()) do
                            if (descendant:IsA("Weld") or descendant:IsA("WeldConstraint")) and descendant.Part1 then
                                if descendant.Part1.Name ~= "FAKE" then
                                    TweenModule:GetTweenObject(descendant.Part1, TweenInfo.new(0.3), {
                                        Transparency = 1
                                    }):Play();
                                end;

                                for _, descendant2 in ipairs(descendant.Part1:GetDescendants()) do
                                    if descendant2:IsA("BasePart") or (descendant2:IsA("Texture") or descendant2:IsA("Decal")) then
                                        TweenModule:GetTweenObject(descendant2, TweenInfo.new(0.3), {
                                            Transparency = 1
                                        }):Play();
                                    end;
                                end;
                            end;
                        end;
                    end);
                end },
            { 18, 21, "Attack" },
            { 27, "End" }
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 11247094879,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p8, p9) -- Line: 238, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p8.Stats;

            if not Knit.CollectionService:HasTag(p8.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Breaker = {
    From = "Combat.Breaker"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Stats.Pose = {
    From = "Combat.Pose"
};
v1.Stats.Grab = {
    From = "Combat.Grab",
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Throw = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    }
};
v1.Stats.Barrage = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Barrage", {
                Cancelable = false
            } }, { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = false
            } }, { 12, "Barrage", true }, { 12, 19, "BarrageAttack", "Hit_Punishable" }, { 20, 42, "BarrageAttack", "Hit" }, { 42, "BarrageAttack", "Finisher" }, { 42, "End" } },
    Hit_Punishable = {
        Frequency = 6,
        Damage = 1.5,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.2,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {}
    },
    Hit = {
        Frequency = 6,
        Damage = 1.5,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.2,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 11157626172,
                Volume = 2
            }
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Finisher = {
        Frequency = 360,
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.45
        },
        Ragdoll = {
            Time = 0.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            BlockBreak = false,
            PerfectBlockable = false
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 11157629779,
                Volume = 2
            }
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Callbacks = {
        BarrageEffect = function(p10, p11, p12, p13) -- Line: 446, Name: BarrageEffect
            -- upvalues: Knit (copy)
            local Character = p11.Character;

            if p13 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                Knit.Remotes.Output:FireAllClients("FX", "Stand_Barrage", Character, {
                    Offset = CFrame.new(0, 0, -1.5)
                });
                p12.SequenceTrove:Add(function() -- Line: 454
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end
    }
};
v1.Stats["Cleaving Strikes"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 12,
        HitAnimations = "Default",
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 11107271689,
                Volume = 2
            }
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Finisher = {
        Damage = 12,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.2
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 11107270771,
                Volume = 2
            }
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    }
};
v1.Stats["Ground Slam"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Stun = {
        Time = 0.75
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 32,
        Time = 0.1,
        Velocity = Vector3.new(0, 24, 0)
    },
    Ragdoll = {
        Time = 0.75
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 10.5,
        Debug = false,
        Offset = CFrame.new(0, 0, -2)
    },
    StatusEffects = { {
            ApplyTo = "Attacker",
            Name = "Lethality"
        } }
};
v1.Stats.Chop = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Chop",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 11107287912,
            Volume = 2
        }
    },
    StatusEffects = { {
            ApplyTo = "Attacker",
            Name = "Lethality"
        } }
};
v1.Stats.Impale = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Attempt = {
        Damage = 10,
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.Blood },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Puncture = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1.3,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v1.Stats["Scalpel Throw"] = {
    Active = true,
    Damage = 2.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Stun = {
        Time = 0.25
    },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 11158014581,
            Volume = 1
        }
    },
    StatusEffects = { {
            ApplyTo = "Attacker",
            Name = "Lethality"
        } },
    HitRemotes = { v1.Resources.Blood }
};
v1.Stats["Downward Strike"] = {
    Active = true,
    CheckPVPSafe = true,
    Damage = 32.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 42,
        Velocity = Vector3.new(0, 16, 0),
        Time = 0.2
    },
    Ragdoll = {
        Time = 1
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Debug = false,
        Offset = CFrame.new(0, 0, -6)
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = true
    },
    StatusEffects = { {
            ApplyTo = "Attacker",
            Name = "Lethality"
        } }
};
v1.Stats["Sudden Blow"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Attempt = {
        Hitbox = {
            CheckPVPSafe = true,
            Size = Vector3.new(6, 6, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -3.75)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true
        }
    },
    Attack = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Ragdoll = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v1.Resources.HeavyHit },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Impale = {
        Damage = 25,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Puncture = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        }
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    }
};
v1.Stats.Foresight = {
    Active = true,
    Time = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "Foresight",
        Time = 20,
        Manual = true
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    }
};
v1.Stats.Witness = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20
    }
};
v1.Stats["Fierce Grab"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Slam = {
        CheckPVPSafe = true,
        Damage = 17.5,
        Priority = EnumsModule.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            Blockable = true,
            BlockBreak = true,
            BypassCounter = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Startup = {
        CheckPVPSafe = true,
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Throw = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 36, 0),
                Speed = 60,
                Time = 0.1
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        HitRemotes = { v1.Resources.HeavyHit },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } }
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    }
};
v1.Stats["Time Erase"] = {
    Active = true,
    SpeedBuff = 34,
    Actionable = {
        Active = true,

        Check = function(p14) -- Line: 1091, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v15;

            if p14 then
                v15 = p14:GetAttribute("InDomain");
            else
                v15 = p14;
            end;

            local v16 = game.Players:GetPlayerFromCharacter(p14);

            if v15 and v16 then
                UIOutput:FireClient(v16, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "King Crimson",
                    Verb = "",
                    Subject = "You can\'t use this ability during a closed Domain."
                });
                UIOutput:FireClient(v16, "PlaySound", "ope_invalid_move");
            end;

            return not v15;
        end
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 75
    },
    TimeErase = {
        Length = 10,
        Cooldown = {
            Name = "Time Erase",
            Time = 60
        }
    }
};
v1.Stats.Teleport = {
    Active = true,
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },

    Invoke = function(p17) -- Line: 1144, Name: Invoke
        -- upvalues: Knit (copy)
        local _ = p17.Input;
        local Character = game.Players.LocalPlayer.Character;
        local _ = p17.Stats;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v18 = Knit.GetService("MoveInputService");

        if Knit.CollectionService:HasTag(Character, "Timestopped") then
            return;
        end;

        local v19 = RaycastParams.new();
        v19.FilterType = Enum.RaycastFilterType.Exclude;
        v19.FilterDescendantsInstances = { Character, workspace.Effects };
        local v20 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local v21 = workspace:Raycast(HumanoidRootPart.Position, v20 * 18, v19);
        local v22 = not (v21 and v21.Position) and 18 or (HumanoidRootPart.Position - v21.Position).Magnitude;
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v20).LookVector.Unit * v22;
        v18:FireInput(p17.RawInput);
        task.wait(0.25);
    end
};
v1.Stats["Timeskip Blow"] = {
    Actionable = {
        Active = true,

        Check = function(p23) -- Line: 1184, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v24;

            if p23 then
                v24 = p23:GetAttribute("InDomain");
            else
                v24 = p23;
            end;

            local v25 = game.Players:GetPlayerFromCharacter(p23);

            if v24 and v25 then
                UIOutput:FireClient(v25, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "King Crimson",
                    Verb = "",
                    Subject = "You can\'t use this ability during a closed Domain."
                });
                UIOutput:FireClient(v25, "PlaySound", "ope_invalid_move");
            end;

            return not v24;
        end
    },
    Cooldown = {
        Time = 30
    },
    Meter = {
        RequiredLevel = 2
    }
};
v1.Stats["Arm Chop"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Priority = EnumsModule.Intangible.Move,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 35
    },
    Chop = {
        Damage = 35,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        StatusEffects = { {
                ApplyTo = "Attacker",
                Name = "Lethality"
            } },
        HitSounds = {
            Hit = {
                SoundId = 6925104130,
                Volume = 2
            }
        },
        HitRemotes = { v1.Resources.Blood }
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    }
};

return v1;