  

 

local v1 = {};
local CurrentCamera = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);

local function GetFacing(p2, p3) -- Line: 16
    -- upvalues: CurrentCamera (copy)
    local v4 = nil;
    local v5 = nil;
    local v6 = p3 or 10;
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local Humanoid = p2:FindFirstChild("Humanoid");

    if HumanoidRootPart and Humanoid then
        for _, child in ipairs(workspace.Living:GetChildren()) do
            if child ~= p2 then
                local Humanoid2 = child:FindFirstChild("Humanoid");
                local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

                if Humanoid2 and (HumanoidRootPart2 and (Humanoid.Health > 0 and (Humanoid2.Health > 0 and CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector:Dot(CurrentCamera.CFrame.LookVector) > 0))) then
                    local _, v7 = CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                    if v7 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude;

                        if v6 >= Magnitude then
                            if v4 then
                                if Magnitude < v5 then
                                    v4 = child;
                                end;
                            else
                                v4 = child;
                                v5 = Magnitude;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v4;
    end;
end;

local v8 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/LightHit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v9 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/LightHit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
v1.Summon = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart", "arm" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Damage = 11.25,
    ["LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.425,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v8 },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    },
    ["LMB-4"] = {
        Cooldown = 0.75,
        Damage = 25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v9 },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    },
    ["StandOff-LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.35,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.475,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v8 },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    },
    ["StandOff-LMB-2"] = {
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.45,
            Priority = EnumsModule.Stun.Medium
        }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.475,
            Priority = EnumsModule.Stun.Medium
        }
    },
    ["StandOff-LMB-4"] = {
        Speed = 1.75,
        Cooldown = 0.75,
        Damage = 25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 36, 42, "Attack" }, { 48, "End" } },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v9 },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    },
    Callbacks = {
        StateChecker = function(p10, p11) -- Line: 311, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p10.Stats;

            if not Knit.CollectionService:HasTag(p10.Character, "Summoned") then
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
v1.Barrage = TableUtil.Reconcile({
    Cooldown = 8,
    Hit = {
        HitAnimations = "Default",
        HitRemotes = { v8 },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    Finisher = {
        Frequency = 360,
        HitAnimations = "Default",
        HitRemotes = { v9 },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    ClashFinisher = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.15
        },
        Block = {
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v1["Flying Uppercut"] = {
    Active = true,
    Cooldown = 12.5,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 0.7
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
    },
    HitSounds = {
        Hit = {
            SoundId = 10847606376,
            Volme = 5
        }
    },
    HitRemotes = { v9 },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "KQ_MARK_SHA_TARGET"
        } }
};
v1["Instant Detonation"] = {
    Active = true,
    Damage = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        Blockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 10855814917,
            Volme = 3
        }
    },
    HitRemotes = { v8 },
    Explosion = {
        Damage = 44,
        Knockback = {
            RelativeTowards = "Target",
            Speed = 36,
            Time = 0.1
        },
        Block = {
            Blockable = false
        },
        Ragdoll = {
            Time = 0.75
        }
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "KQ_MARK_SHA_TARGET"
        } }
};
v1["Primary Ability"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 4,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 1,
    Stun = {
        Time = 0.8
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    HitSounds = {
        Hit = {
            SoundId = 10897845576,
            Volme = 3
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/BombPlanted",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    Block = {
        Blockable = false
    },
    HitAnimations = "Default",
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "KQ_MARK_SHA_TARGET"
        } },
    Hit1 = {
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitRemotes = { v8 },
        HitSounds = {
            Hit = {
                SoundId = 10897845357,
                Volume = 1
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    },
    Hit2 = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.7
        },
        Block = {
            Blockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.2
        },
        Ragdoll = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 10897845357,
                Volme = 3
            }
        },
        HitRemotes = { v9 },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    },
    Explosion = {
        Damage = 35,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Quickstep + 1,
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.3
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 20, 20),
            Debug = false,
            Offset = CFrame.identity
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 60,
            Time = 0.2,
            Override = true,
            Velocity = Vector3.new(0, 50, 0)
        },
        Ragdoll = {
            Time = 1.5
        },
        HitSounds = {
            Hit = {
                SoundId = 10627078934,
                Volme = 3
            }
        },
        HitRemotes = { v9 },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    }
};
v1["Cugious Strike"] = {
    Active = true,
    Damage = 22.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    Block = {},
    HitSounds = {
        Hit = {
            SoundId = 10897845803,
            Volme = 3
        }
    },
    HitRemotes = { v9 }
};
v1["Face Slam"] = {
    Active = true,
    Damage = 5.5,
    HitAnimations = "Default",
    Cooldown = {
        Time = 60,
        Manual = true
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    HitSounds = {
        Hit = {
            SoundId = 10897845803,
            Volme = 3
        }
    },
    HitRemotes = { v9 },
    Block = {
        Unblockable = true
    },
    Grab = {
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v8 }
    },
    Hit = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    },
    Throw = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.3
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
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v1["Yen Coin"] = {
    Active = true,
    Damage = 35,
    Distance = 5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Hitbox = {
        Type = "Region3",
        Size = Vector3.new(20, 20, 20),
        Debug = true,
        Origin = CFrame.new(),
        Offset = CFrame.new(0, 0, 0)
    },
    Cooldown = {
        Time = 15,
        Manual = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Block = {
        Unblockable = true
    },
    Priority = EnumsModule.Intangible.Ragdoll + 1,
    Stun = {
        Time = 0.3
    },
    Knockback = {
        RelativePart = "Target",
        Speed = 60,
        Time = 0.2,
        Override = true,
        Velocity = Vector3.new(0, 50, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 10627078934,
            Volme = 3
        }
    },
    HitRemotes = { v9 },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "KQ_MARK_SHA_TARGET"
        } },

    Invoke = function(p12) -- Line: 884, Name: Invoke
        -- upvalues: Knit (copy), GetFacing (copy)
        local Input = p12.Input;
        local v13 = Knit.GetService("MoveInputService");
        local v14 = GetFacing(game.Players.LocalPlayer.Character, 50);

        if not v14 then
            return;
        end;

        v13:FireInput(Input, v14);
    end
};
v1["Secondary Ability"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Manual = true
    }
};
v1["Quadruple Bomb Finish"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Manual = true
    },
    Grab = {
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10944295800,
                Volme = 3
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    },
    Throw = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.3
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
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    },
    Hit = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move + 1,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    }
};
v1["Power Display"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 12,
        Manual = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 1.35
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    Block = {
        Unblockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 10969901513,
            Volme = 5
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/KQ Donut",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "KQ_MARK_SHA_TARGET"
        } },
    Throw = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.3
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
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
};
v1["Quick Plant"] = {
    Active = true,
    Damage = 5.5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 7.5,
        Manual = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.05
    },
    Block = {
        PerfectBlockable = true,
        Blockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 10897845803,
            Volme = 3
        }
    },
    HitRemotes = { v9 },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "KQ_MARK_SHA_TARGET"
        } },
    Hit = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10847606376,
                Volme = 5
            }
        },
        HitRemotes = { v9 }
    },
    Throw = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.3
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
            Time = 1
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10847606376,
                Volme = 5
            }
        },
        HitRemotes = { v8 }
    }
};
v1.Grab = {
    From = "Combat.Grab",
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
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
    From = "Combat.Pose"
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
            ["Flying Uppercut"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Briefly unleash your stand to deliver a quick jab, implanting a bomb and sending the flying backwards."
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike."
            },
            ["Instant Detonation"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "A low sweeping kick, exploding on contact, knocking the target down."
            },
            ["Primary Ability"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Reach forward to grab a target and implant a bomb in them. Using this ability while an enemy has a bomb implanted in them will detonate your bombs."
            },
            ["Face Slam"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Throw the target to the ground before grabbing them by the head and repeatedly slamming their face into the ground.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Cugious Strike"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Swipe forward and remove an arm from the victim.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Yen Coin"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Toss a coin that\'s been imbued with a bomb at a nearby enemy that explodes on contact.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Quadruple Bomb Finish"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                Description = "Grab your target before throwing them to ground and sequentially activating four bombs sending them flying.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Secondary Ability"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Deploy Sheer Heart Attack to drive towards the next enemy hit. If it reaches them it delivers a devastating explosion.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Power Display"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Grab in front of you and implant a bomb in the target before throwing them backwards.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Quick Plant"] = {
                DefaultKeybind = "V",
                State = "StandOff",
                Description = "Grab your target, kicking them to the ground, implanting a bomb in them before kicking them away.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 11127865908,
            ["StandOff-LMB-2"] = 11127868260,
            ["StandOff-LMB-3"] = 11127869614,
            ["StandOff-LMB-4"] = 11127870798,
            ["Stand-Block"] = 10808688837,
            ["Stand-BlockHit1"] = 10808692075,
            ["Stand-BlockHit2"] = 10808695355,
            ["Stand-BlockHit3"] = 10808697696,
            ["Stand-BlockBreak"] = 10808701329,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            Grab = 10906128504,
            Throw = 10906131878,
            ThrowVictim = 10906132668,
            ["Flying Uppercut"] = 10840806004,
            ["Primary Bomb"] = 10843864386,
            Detonate1 = 10856506805,
            Detonate2 = 10856508771,
            ["Stand Restrain Startup"] = 11165590102,
            ["Stand Restrain User"] = 10848564777,
            ["Stand Restrain Victim"] = 10848566966,
            ["Stand Restrain Victim Loop"] = 10848569219,
            ["Stand Restrain User Loop"] = 10848571714,
            Explode = 10855711598,
            CugiousStrike = 10857148827,
            ["Plant Bomb"] = 10855748127,
            ["Kick Away"] = 10897756070,
            ["Coin Toss"] = 10857145963,
            PoseIdle = 7508212350,
            PoseTransition = 7508188405,
            DonutStartup = 10898048721,
            DonutUser = 10898039552,
            DonutVictim = 10898041509,
            ["Face Slam Startup"] = 10912968659,
            ["Face Slam Victim"] = 10912971104,
            ["Face Slam User"] = 10912975539,
            ["Face Slam Camera"] = 10912977180,
            ["SHA Plant"] = 10938569205,
            ["Quadruple Bomb Finish"] = 10944261635,
            ["Quadruple Bomb Finish User"] = 10944263399,
            ["Quadruple Bomb Finish Victim"] = 10944265280,
            ["Quick Plant"] = 11126752547,
            ["Quick Plant User"] = 11126755703,
            ["Quick Plant Victim"] = 11126757411,
            ["Quote-1"] = 10976760361,
            ["Quote-2"] = 10976761195,
            ["Quote-3"] = 10976763020
        },
        Movement = {
            Walk = 10856503017,
            Run = 10856500879,
            SummonedWalk = 10856503017,
            SummonedRun = 10856500879,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 10842851957,
            Idle = 10842851957
        }
    },
    Stats = v1,
    Sounds = {
        SummonEffects = {
            SoundId = 10842835858,
            Volume = 2
        },
        SummonSound = {
            SoundId = 6417693074,
            Volume = 4
        },
        Desummon = {
            SoundId = 10919876810,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 10927467009,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 10927937748,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 10842905304,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 10842905185,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 10842905241,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 10842905370,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 10842905304,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 10842905185,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 10842905241,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10842905370,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 7167737842,
            Volume = 3
        },
        Barrage = {
            SoundId = 10835571201,
            Volume = 3
        },
        Grab = {
            SoundId = 10906275061,
            Volume = 2
        },
        Grabbed = {
            SoundId = 10906275262,
            Volume = 2
        },
        Throw = {
            SoundId = 10906746801,
            Volume = 3
        },
        ThrowVoiceline = {
            SoundId = 10919755744,
            Volume = 2
        },
        PowerSFX = {
            SoundId = 10920809881,
            Volume = 2
        },
        PowerVoice = {
            SoundId = 10920810178,
            Volume = 2
        },
        PrimaryV1 = {
            SoundId = 10842751862,
            Volume = 3
        },
        PrimaryV2 = {
            SoundId = 10842751768,
            Volume = 3
        },
        PrimaryV3 = {
            SoundId = 10842751660,
            Volume = 3
        },
        PrimaryV4 = {
            SoundId = 10842751526,
            Volume = 3
        },
        ClickSwitch = {
            SoundId = 10842752271,
            Volume = 3
        },
        Planted = {
            SoundId = 6425414680,
            Volume = 1
        },
        BombPlace = {
            SoundId = 7167739366,
            Volume = 2
        },
        UppercutVoice = {
            SoundId = 10847606246,
            Volume = 2
        },
        UppercutSFX = {
            SoundId = 10847606454,
            Volume = 2
        },
        RestrainVoice = {
            SoundId = 10855815043,
            Volume = 2
        },
        RestrainBeginning = {
            SoundId = 10855815135,
            Volume = 2
        },
        RestrainConnect = {
            SoundId = 10855818191,
            Volume = 2
        },
        BombPlantVLAttempt = {
            SoundId = 10897845259,
            Volume = 2
        },
        BombPlantSuccessVL = {
            SoundId = 10897845160,
            Volume = 2
        },
        BombPlantKicksWoosh = {
            SoundId = 10897845160,
            Volume = 2
        },
        BombPlantSFX = {
            SoundId = 10897845423,
            Volume = 2
        },
        ArmChopVoice = {
            SoundId = 10897845642,
            Volume = 2
        },
        ArmChopSwing = {
            SoundId = 10897845731,
            Volume = 2
        },
        ["Face Slam Startup SFX"] = {
            SoundId = 10913283245,
            Volume = 2
        },
        ["Face Slam Startup Voiceline"] = {
            SoundId = 10913301852,
            Volume = 2
        },
        ["Face Slam"] = {
            SoundId = 10920548335,
            Volume = 2
        },
        ["Power Display Voice"] = {
            SoundId = 10920810178,
            Volume = 2
        },
        ["Power Display Swing"] = {
            SoundId = 10920809881,
            Volume = 2
        },
        ["Quadruple Bomb Finish Startup Woosh"] = {
            SoundId = 10944295541,
            Volume = 2
        },
        ["Quadruple Bomb Finish Startup Voice"] = {
            SoundId = 10944295608,
            Volume = 2
        },
        ["Quadruple Bomb Finish SFX"] = {
            SoundId = 10944295704,
            Volume = 2
        },
        ["Quadruple Bomb Finish Voice"] = {
            SoundId = 10944295440,
            Volume = 2
        },
        ["Yen Throw Voice"] = {
            SoundId = 10969901544,
            Volume = 2
        },
        ["Yen Throw SFX"] = {
            SoundId = 10969901566,
            Volume = 2
        },
        ["SHA Voice"] = {
            SoundId = 11118195383,
            Volume = 2
        },
        ["SHA SFX"] = {
            SoundId = 11118195236,
            Volume = 2
        },
        QuickPlantWoosh = {
            SoundId = 11159624051,
            Volume = 2
        },
        QuickPlantVoice = {
            SoundId = 11159624129,
            Volume = 2
        },
        QuickPlantSuccededVoice = {
            SoundId = 11159624100,
            Volume = 2
        },
        QuickPlantSucceededSFX = {
            SoundId = 11159624170,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 10382709317,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
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
                    SoundId = "rbxassetid://10953324772",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My Killer Queen is capable of turning anything into a bomb."
                        } }
                }, {
                    SoundId = "rbxassetid://10953322411",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m going to have to eliminate you."
                        } }
                }, {
                    SoundId = "rbxassetid://10953322056",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I, Kira Yoshikage, am going around this in a timely manner. I\'ll make sure things get bombed."
                        } }
                } }
        }
    }
};