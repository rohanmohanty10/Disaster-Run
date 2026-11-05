  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local ClientAssets = PathShortcuts.ClientAssets;
local TableUtil = require(Knit.Util.TableUtil);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
v1.Summon = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart", "StandOffKatana" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 208, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 129, 2)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 20, 25, "Attack" }, { 30, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = ClientAssets["D4C: Love Train"].LMBEffects.Hit,
            Offset = CFrame.Angles(1.5707963267948966, 0, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 6706979361,
                Volume = 0.8
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 2,
        Sequence = { { 0, "Start" }, { 35, "Attack" }, { 40, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = ClientAssets["D4C: Love Train"].LMBEffects.Heavy,
            Offset = CFrame.Angles(1.5707963267948966, 0, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 10466221970,
                Volume = 1
            }
        },
        StatusEffects = {}
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p2, p3, p4) -- Line: 92
                    local Character = p4.Character;
                    Character.Knife.Transparency = 0;
                    Character.Knife.Trail.Enabled = true;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 0;
                        end;
                    end;
                end },
            { 19, 24, "Attack" },
            { 27, function(p5, p6, p7) -- Line: 104
                    local Character = p7.Character;
                    Character.Knife.Transparency = 1;
                    Character.Knife.Trail.Enabled = false;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 1;
                        end;
                    end;
                end },
            { 28, "End" }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = ClientAssets["D4C: Love Train"].KnifeHit.Attachment
        },
        HitSounds = {
            Hit = {
                SoundId = 11038124693,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p8, p9, p10) -- Line: 138
                    local Character = p10.Character;
                    Character.Knife.Transparency = 0;
                    Character.Knife.Trail.Enabled = true;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 0;
                        end;
                    end;
                end },
            { 19, 24, "Attack" },
            { 27, function(p11, p12, p13) -- Line: 150
                    local Character = p13.Character;
                    Character.Knife.Transparency = 1;
                    Character.Knife.Trail.Enabled = false;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 1;
                        end;
                    end;
                end },
            { 28, "End" }
        },
        Stun = {
            Time = 0.75
        }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p14, p15, p16) -- Line: 171
                    local Character = p16.Character;
                    Character.Knife.Transparency = 0;
                    Character.Knife.Trail.Enabled = true;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 0;
                        end;
                    end;

                    for _, child in pairs(Character.Stand["Stand Left Arm"]:GetChildren()) do
                        if child:IsA("Weld") and child.Part1 then
                            game:GetService("TweenService"):Create(child.Part1, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;

                    task.wait(0.26);

                    for _, child in pairs(Character.Stand["Stand Left Arm"]:GetChildren()) do
                        if child:IsA("Weld") and child.Part1 then
                            game:GetService("TweenService"):Create(child.Part1, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end },
            { 10, 13, "Attack" },
            { 17, function(p17, p18, p19) -- Line: 199
                    local Character = p19.Character;
                    Character.Knife.Transparency = 1;
                    Character.Knife.Trail.Enabled = false;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 1;
                        end;
                    end;
                end },
            { 18, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 11038126028,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p20, p21, p22) -- Line: 224
                    local Character = p22.Character;
                    Character.Knife.Transparency = 0;
                    Character.Knife.Trail.Enabled = true;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 0;
                        end;
                    end;
                end },
            { 36, 42, "Attack" },
            { 42, function(p23, p24, p25) -- Line: 236
                    local Character = p25.Character;
                    Character.Knife.Transparency = 1;
                    Character.Knife.Trail.Enabled = false;

                    for _, child in pairs(Character.Knife:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 1;
                        end;
                    end;
                end },
            { 48, "End" }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = ClientAssets["C-Moon"].Effects.HeavyHit,
            Offset = CFrame.Angles(1.5707963267948966, 0, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 11038126198,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p26, p27) -- Line: 269, Name: StateChecker
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
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
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
v1["Body Carving"] = {
    Active = true,
    Damage = 6.25,
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
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.2
    },
    HitSounds = {
        Hit = {
            SoundId = 10086012284,
            Volume = 1
        }
    },
    FinalHit = {
        Damage = 17.5,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, -3.75)
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.2
        },
        HitSounds = {
            Hit = {
                SoundId = 10086011536,
                Volume = 1
            }
        }
    }
};
v1["Hand Of Fortune"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 9
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(6, 6, 6),
        Offset = CFrame.new(0, 0, -3.75)
    },
    Stun = {
        Time = 0.7,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 20,
        Time = 0.05
    },
    Block = {},
    HitSounds = {
        Hit = {
            SoundId = 10464843113,
            Volume = 1
        }
    }
};
v1["Throat Incision"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Grab = {
        Damage = 2,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Stun = {
            Time = 1.5,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10086010512,
                Volume = 1
            }
        }
    },
    Stab = {
        Damage = 38,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 1.35,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10086010512,
                Volume = 1
            }
        }
    },
    Throw = {
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.3,
            Velocity = Vector3.new(0, 5, 0)
        },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v1["Spilling Of Blood"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Stun = {
        Time = 2.1,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 10086010512,
            Volume = 1
        }
    }
};
v1["Severing Chokehold"] = {
    Active = true,
    Damage = 1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BlockCancel = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Hit1 = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move + 1,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "D4CLT_CHOKE_SLAM", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8051702012,
                Volume = 1
            }
        }
    },
    Hit2 = {
        Damage = 29,
        Priority = EnumsModule.Intangible.Move + 1,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "D4CLT_CHOKE_SLAM", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8051702012,
                Volume = 1
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3,
            Velocity = Vector3.new(0, 30, 0)
        }
    }
};
v1["Head Bomb"] = {
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
        Priority = EnumsModule.Stun.Medium
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

    Invoke = function(p28) -- Line: 659, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p28.Input;
        Knit.GetController("MoveInputController");
        local v29 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v30 = LocalPlayer:GetMouse();
        local v31 = OverlapParams.new();
        v31.FilterType = Enum.RaycastFilterType.Include;
        v31.FilterDescendantsInstances = { workspace.Living };
        v31.MaxParts = 300;
        local v32 = workspace:GetPartBoundsInRadius(v30.Hit.Position, 75, v31);
        local v33 = {};
        local v34 = nil;
        local v35 = nil;

        for _, v in pairs(v32) do
            local v36 = v.Parent:FindFirstChildOfClass("Humanoid");

            if v36 and not (v33[v.Parent] or v:IsDescendantOf(Character)) then
                v33[v.Parent] = v36;
            end;
        end;

        for i, _ in pairs(v33) do
            local v37 = i:FindFirstChild("HumanoidRootPart") or i:FindFirstChildOfClass("BasePart");

            if v37 then
                local Magnitude = (v30.Hit.Position - v37.Position).Magnitude;

                if not v34 or Magnitude < v35 then
                    v35 = Magnitude;
                    v34 = i;
                end;
            end;
        end;

        v29:FireInput(Input, v34);
    end
};
v1["Presidential Leverage"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    HitSounds = {
        Hit = {
            SoundId = 10086011536,
            Volume = 1
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 12,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5)
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "Box Emit Particle",
                "__Legacy",
                {
                    EmitType = "Enabled",
                    EmitDuration = 0.15,
                    CustomParent = "Torso",
                    Particle = Knit.ClientAssets["D4C: Love Train"].HeavyHitEffect.Attachment
                }
            }
        }
    },
    SecondHit = {
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "Q_HIT_EMIT",
                    "__Legacy",
                    {
                        Effect = ClientAssets["D4C: Love Train"].RBlood.Attachment
                    }
                }
            }
        }
    }
};
v1["Chop Strike"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Stun = {
        Time = 0.8,
        Priority = EnumsModule.Stun.Medium
    },
    HitSounds = {
        Hit = {
            SoundId = 10086010673,
            Volume = 1
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6, 6, 7.35),
        Debug = false,
        Offset = CFrame.new(0, 0, -3.85)
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "Box Emit Particle",
                "__Legacy",
                {
                    EmitType = "Enabled",
                    EmitDuration = 0.175,
                    CustomParent = "Torso",
                    Particle = Knit.ClientAssets["D4C: Love Train"].HeavyHitEffect.Attachment
                }
            }
        }
    }
};
v1["State Funeral"] = {
    Active = true,
    Damage = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    HitSounds = {
        Hit = {
            SoundId = 10464847016,
            Volume = 1
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.25, 6.25, 6.25),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "Box Emit Particle",
                "__Legacy",
                {
                    EmitType = "Enabled",
                    EmitDuration = 0.175,
                    CustomParent = "Torso",
                    Particle = Knit.ClientAssets["D4C: Love Train"].HeavyHitEffect.Attachment
                }
            }
        }
    },
    Slam = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 1.35,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10464850369,
                Volume = 1
            }
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "Box Emit Particle",
                    "__Legacy",
                    {
                        EmitType = "Enabled",
                        EmitDuration = 0.175,
                        CustomParent = "Torso",
                        Particle = Knit.ClientAssets["D4C: Love Train"].HeavyHitEffect.Attachment
                    }
                }
            }
        }
    }
};
v1["Fanfire Disposal"] = {
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Stun = {
        Time = 0.35,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "BulletHitEffect",
                "__Legacy",
                {
                    Color = Color3.new(0.466667, 0.768627, 1)
                }
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 7086617073,
            Volume = 3
        }
    }
};
v1["Precision Disposal"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Block = {
        BlockBreak = true
    },
    Ragdoll = {
        Time = 0.4
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "BulletHitEffect",
                "__Legacy",
                {
                    Color = Color3.new(1, 0.54902, 0.152941)
                }
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 7086617073,
            Volume = 3
        }
    }
};
v1["Gut Gouge"] = {
    Active = true,
    Damage = 40,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16
    },
    Stun = {
        Time = 1.5,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 4.5,
        Debug = false,
        Offset = CFrame.new(-0.35, 0, -5)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 1.25
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 2,
        Velocity = Vector3.new(0, 5, 0)
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "Box Emit Particle",
                "__Legacy",
                {
                    EmitType = "Enabled",
                    EmitDuration = 0.15,
                    CustomParent = "Torso",
                    Particle = Knit.ClientAssets["Crazy Diamond"].BloodEffect2.Attachment
                }
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 10086010673,
            Volume = 1
        }
    }
};
v1["Love Train"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Meter = {
        RequiredLevel = 4,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 30
    }
};

return {
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
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Summon = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Hand Of Fortune"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Send forth your stand\'s hand, impaling anyone it hits."
            },
            ["Body Carving"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Perform a series of punches and chops."
            },
            ["Throat Incision"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Pull out your knife, grabbing and stabbing the target in the throat."
            },
            ["Spilling Of Blood"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "After winding up, the stand throws a strong forward punch, impaling anyone it hits."
            },
            ["Severing Chokehold"] = {
                DefaultKeybind = "R+",
                State = "StandOn",
                LevelRequirement = 35,
                Description = "The stand grabs anyone in front of you, holding them by the neck before slamming them down into the floor repeatedly, finally kicking them away.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Head Bomb"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                LevelRequirement = 60,
                Description = "Pull out the target\'s head from an alternate universe, the head will roll towards the target and explode on contact.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Presidential Leverage"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                LevelRequirement = 45,
                Description = "Lunge forth, hitting all targets in the way.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Chop Strike"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Briefly summon your stand to do a swift chop.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["State Funeral"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Perform a swipe, following up with a swift punch sending the target to the floor.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Fanfire Disposal"] = {
                DefaultKeybind = "G",
                Description = "Pull out a revolver, firing 6 consecutive rounds.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Precision Disposal"] = {
                DefaultKeybind = "G+",
                LevelRequirement = 15,
                Description = "Take aim, firing a single shot.",
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Gut Gouge"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "After winding up, the stand gouges the target\'s stomach",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Love Train"] = {
                DefaultKeybind = "V",
                State = "StandOn",
                LevelRequirement = 120,
                Description = "Surround yourself with a wall of light, putting you in an unreachable pocket dimension. All damage done to you will be redirected to another target. Using any attack will disable this move but can reactivate itself passively as long as you have meter",
                Cost = {
                    AscensionRank = 10,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 11063407023,
            ["LMB-2"] = 11063410729,
            ["LMB-3"] = 11063412797,
            ["LMB-4"] = 11063414925,
            Summon = 8604415872,
            ["StandOff-LMB-1"] = 10307709714,
            ["StandOff-LMB-2"] = 10307711291,
            ["StandOff-LMB-3"] = 10307712737,
            ["StandOff-LMB-4"] = 10307738458,
            LoveTrainStartup = 8675840017,
            ["Dimension Hide"] = 7851087001,
            ["Dimension Hide Exit"] = 7856121850,
            ["Dimension Beatdown User"] = 8488442914,
            ["Dimension Beatdown Victim"] = 8500522374,
            ["Dash Camera"] = 8695287751,
            ["Dash User"] = 8695862218,
            ["Dash Clone"] = 8695867476,
            ["Dash Victim"] = 8715135121,
            ["Dash Victim Clone"] = 8695872112,
            ["Severing Chokeslam Start"] = 8614164038,
            ["Severing Chokeslam"] = 8614827594,
            ["Severing Victim"] = 8614166899,
            Chokeslammed = 8614169552,
            PoseIdle = 8574228830,
            PoseTransition = 8574225633,
            ["First Napkin"] = 10137381164,
            ["First Napkin Victim"] = 10137388962,
            GunWindup = 10002442542,
            FanfireDisposal = 10002444730,
            PrecisionDisposal = 10002447207,
            GutGougeWindup = 10002449906,
            GutGouge = 10002452257,
            GutGougeVictim = 10002454324,
            BodyCarving = 10036276073,
            SpillingOfBloodWindup = 10002462639,
            SpillingOfBlood = 10002459558,
            SpillingOfBloodVictim = 10002464833,
            PilotUserIdle = 10035919728,
            PilotUserTransition = 10035917372,
            ["State Funeral"] = 10086880269,
            ["State Funeral User"] = 10382989072,
            ["State Funeral Victim"] = 10382991168,
            ChopStrike = 10138512331,
            ChopStrikeStandOff = 10139619761,
            PincerAttack = 10289504741,
            IncisionAttempt = 10139358481,
            Incision = 10139361358,
            IncisionVictim = 10139364675,
            HandOfFortuneUser = 10343445032,
            HandOfFortuneStand = 10513677517,
            HeadBomb = 10361194439,
            PresidentialLeverage = 10466366249
        },
        Movement = {
            Walk = 8577083049,
            Run = 8577096811,
            SummonedWalk = 8577083049,
            SummonedRun = 8577096811,
            LoveTrainWalk = 7370960151,
            LoveTrainRun = 7370961968
        },
        Idle = {
            SummonedIdle = 10286553949,
            Idle = 10284132160,
            LoveTrainIdle = 10284136033
        }
    },
    Stats = v1,
    Sounds = {
        CounterHitSFX = {
            SoundId = 8756596010,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CounterHitVoice = {
            SoundId = 8756594928,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = 10536623659,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Dimension = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Explosion = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ExplosionVoice = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FlagSFX = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Gun = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunEquip = {
            SoundId = 3120031857,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunFire = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunFireOFF = {
            SoundId = 8756590785,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunVoiceline = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunVoicelineOFF = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyPunch = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = 10466219547,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = 10466220364,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = 10466221018,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10466221507,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = 10536708084,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 10536707266,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = 10536708924,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 10536708466,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = 10536711042,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 10536709279,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = 7076936591,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        testsfx = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RStart = {
            SoundId = 8706755014,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RCombo = {
            SoundId = 8714570871,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RHold = {
            SoundId = 10536625039,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SFX = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Slammed = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonEffects = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = 8601269440,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = 6706981173,
            Volume = 0.800000011920929,
            PlaybackSpeed = 0.800000011920929,
            Looped = false,
            TimePosition = 0
        },
        Uppercut = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ihop = {
            SoundId = 12727745056,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LovetrainWindup = {
            SoundId = 8975352304,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LovetrainActivate = {
            SoundId = 8975353022,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LovetrainIdle = {
            SoundId = 7462170848,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        LovetrainMusic = {
            SoundId = 10039481334,
            Volume = 2,
            PlaybackSpeed = 0.669,
            Looped = true,
            TimePosition = 0,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.86
                }
            }
        },
        PoseMusic = {
            SoundId = 10039481334,
            Volume = 2,
            PlaybackSpeed = 0.669,
            Looped = true,
            TimePosition = 0,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.86
                }
            }
        },
        LovetrainDisable = {
            SoundId = 8975353711,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LovetrainActivateCall = {
            SoundId = 12727745056,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LovetrainWindupCall = {
            SoundId = 8975351636,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Redirection = {
            SoundId = 8601276334,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1
                }
            }
        },
        VIn = {
            SoundId = 8756588620,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        VOut = {
            SoundId = 8756589518,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightHit = {
            SoundId = 8756590222,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Chop = {
            SoundId = 8756591372,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyHit = {
            SoundId = 8756593313,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CounterVoice = {
            SoundId = 8756594323,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["R-Tap-Voice"] = {
            SoundId = 10086010835,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["R-Tap-Approach"] = {
            SoundId = 10086011346,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["H-Move-Voice"] = {
            SoundId = 10086011067,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["H-Move-SFX"] = {
            SoundId = 10086012059,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["E-Swoosh"] = {
            SoundId = 10086011777,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StandoffEVoice = {
            SoundId = 10464846338,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StandoffE = {
            SoundId = 10464844959,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StandoffEHit = {
            SoundId = 10464843113,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["B-Tap"] = {
            SoundId = 10086012645,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["B-Hold"] = {
            SoundId = 10086012481,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TStartup = {
            SoundId = 10466001948,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        THit = {
            SoundId = 10466003200,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeadBounce = {
            SoundId = 10464837790,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeadToss = {
            SoundId = 10464841739,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeadTossVoice = {
            SoundId = 10465451061,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        YWoosh = {
            SoundId = 10464847978,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        YVoice = {
            SoundId = 10464848835,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        YFollowupWoosh = {
            SoundId = 10464849786,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        YFollowupVoice = {
            SoundId = 10464850950,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Incision = {
            SoundId = 10533672225,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        IncisionVoice = {
            SoundId = 10492910906,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        IncisionStab = {
            SoundId = 10533672845,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CounterStartSFX = {
            SoundId = "rbxassetid://7076935530",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CounterStart = {
            SoundId = "rbxassetid://7076936591",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Guesswhoback = {
            SoundId = "rbxassetid://7076940724",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Fallsfx = {
            SoundId = "rbxassetid://7076939657",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://10362536682",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The only energy that can cross dimensional walls is my D4C."
                        } }
                }, {
                    SoundId = "rbxassetid://10362537267",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My heart and actions are utterly unclouded! They are all those of justice."
                        } }
                }, {
                    SoundId = "rbxassetid://10362537664",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "THE CORPSE FAVORS ME, VALENTINE!"
                        } }
                } }
        }
    }
};