  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(Knit.Util.Trove);
local ClientAssets = PathShortcuts.ClientAssets;
require(PathShortcuts.GenericModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.AnimsModule);
v1.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    Actionable = {
        NoPilot = true
    },
    LeaveParts = { "StandHumanoidRootPart", "Pistol", "Disc" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(153, 103, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 55, 98)) }),
    Callbacks = {
        Summon = function(p2) -- Line: 33, Name: Summon
            local _ = p2.Player;
            local Character = p2.Character;
            local _ = p2.Stats;
            local Animator = p2.Animator;
            (Animator:GetAnimation("SummonedIdle") or Animator:GetAnimation("StandIdle")):Play();

            for _, descendant in Character:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "WhitesnakeAura" then
                    descendant.Enabled = true;
                end;
            end;
        end,

        Desummon = function(p3) -- Line: 48, Name: Desummon
            local _ = p3.Player;
            local Character = p3.Character;
            local _ = p3.Stats;
            local Animator = p3.Animator;
            (Animator:GetAnimation("SummonedIdle") or Animator:GetAnimation("StandIdle")):Stop();

            for _, descendant in Character:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "WhitesnakeAura" then
                    descendant.Enabled = false;
                end;
            end;
        end
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.208,
        ActiveEndlag = 0.208,
        Stun = 0.6,
        Sequence = { { 0, "Start" }, { 23, 26, "Attack" }, { 36, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8283374745,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Stun = 0.61,
        Speed = 1.308,
        ActiveEndlag = 0.308,
        Sequence = { { 0, "Start" }, { 23, 26, "Attack" }, { 32, "End" } }
    },
    ["LMB-3"] = {
        Speed = 1.208,
        ActiveEndlag = 0.208,
        Sequence = { { 0, "Start" }, { 29, 32, "Attack" }, { 40, "End" } }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.408,
        ActiveEndlag = 0.208,
        Sequence = { { 0, "Start" }, { 21, 24, "Attack" }, { 30, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 8283375301,
                Volume = 2
            }
        },
        StatusEffects = {}
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.108,
        ActiveEndlag = 0.208,
        Stun = 0.6,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 38, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 11038124693,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        ActiveEndlag = 0.358,
        Stun = 0.6,
        Sequence = { { 0, "Start" }, { 8, 13, "Attack" }, { 25, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1.7,
        Stun = 0.55,
        ActiveEndlag = 0.4,
        Sequence = { { 0, "Start" }, { 10, 13, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 11038126028,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.108,
        ActiveEndlag = 0.208,
        Sequence = {
            { 0, "Start" },
            { 0, function(u4, p5, p6) -- Line: 192
                    -- upvalues: ClientAssets (copy)
                    u4.UserData.Attachment = ClientAssets.Whitesnake.CrossEffects.Attachment:Clone();
                    u4.UserData.Attachment.Parent = p6.Character["Left Arm"];
                    u4.UserData.Attachment.StartupShine:Emit(1);
                    u4.UserData.Attachment.StartupTwinkle:Emit(1);
                    task.delay(0.05, function() -- Line: 199
                        -- upvalues: u4 (copy)
                        u4.UserData.Attachment.Twinkle1:Emit(3);
                        u4.UserData.Attachment.Twinkle2:Emit(3);
                        u4.UserData.Attachment.Swirls:Emit(3);
                    end);
                    task.delay(0.15, function() -- Line: 205
                        -- upvalues: u4 (copy)
                        u4.UserData.Attachment.ParticleEmitter:Emit(8);
                    end);
                    task.delay(0.6, function() -- Line: 209
                        -- upvalues: u4 (copy)
                        u4.UserData.Attachment:Destroy();
                    end);
                end },
            { 36, 42, "Attack" },
            { 48, "End" }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 11038126198,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p7, p8) -- Line: 233, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p7.Stats;

            if not Knit.CollectionService:HasTag(p7.Character, "Summoned") then
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
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p9) -- Line: 288, Name: Transformer
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p9.Stats;

            if Knit.CollectionService:HasTag(p9.Character, "Piloting") then
                local v10 = TableUtil.Copy(Stats, true);
                v10.StartAnim = "PilotPoseTransition";
                v10.LoopAnim = "PilotPoseIdle";

                return v10;
            end;
        end,

        PoseTransition = function(p11) -- Line: 300, Name: PoseTransition
            -- upvalues: Knit (copy), ClientAssets (copy)
            local Character = p11.Character;
            local _ = p11.Stats;
            local AbilityModel = p11.AbilityModel;

            if not AbilityModel:FindFirstChild("PoseDisc") and Knit.CollectionService:HasTag(Character, "Piloting") then
                local v12 = ClientAssets.Whitesnake.PoseDisc:Clone();
                local Weld = Instance.new("Weld");
                Weld.Part0 = AbilityModel["Stand Right Arm"];
                Weld.Part1 = v12.Middle;
                v12:PivotTo(Weld.Part0.CFrame);
                Weld.Parent = v12;
                v12.Parent = AbilityModel;
            end;
        end,

        PoseEnd = function(p13) -- Line: 315, Name: PoseEnd
            local _ = p13.Character;
            local _ = p13.Stats;
            local AbilityModel = p13.AbilityModel;

            if AbilityModel:FindFirstChild("PoseDisc") then
                AbilityModel.PoseDisc:Destroy();
            end;
        end
    }
};
v1["Remote Barrage"] = {
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    LeaveParts = { "StandHumanoidRootPart", "Pistol", "Disc" },
    Stun = {
        Time = 0.55,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 20,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "WS_HIT", "__Legacy" }
        } }
};
v1["Acid Strikes"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Hit = {
        Damage = 3.5,
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
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } }
    },
    Finisher = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 0.9,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.2
        },
        Ragdoll = {
            Time = 1.25
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } }
    }
};
v1.Crucifixion = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 9
    },
    Stun = {
        Time = 0.85,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Block = {},
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect", "__Legacy" }
        }, {
            Name = "Output",
            Arguments = { "FX", "HitEffect", "__Legacy" }
        }, {
            Name = "Output",
            Arguments = { "FX", "HitEffect", "__Legacy" }
        } },
    HitData = {
        Color = Color3.fromRGB(255, 160, 75)
    }
};
v1["Disciplinary Knee"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15
    },
    Grab = {
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
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } }
    },
    Knee = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_KNEE_SLAM", "__Target" }
            } }
    },
    Throw = {
        Damage = 10,
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
                Speed = 64,
                Time = 0.1
            } },
        Ragdoll = {
            Time = 1.5,
            Intangible = false
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } }
    }
};
v1["Domine Quo Vadis"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14
    },
    Hit = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Velocity = Vector3.new(0, -8, 0),
            Time = 0.1
        },
        Block = {
            BlockBreak = true
        },
        Ragdoll = {
            Time = 0.75
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, -0.5, -5),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } }
    },
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1,
            Override = true,
            Velocity = Vector3.new(0, 25, 0)
        },
        Block = {
            BlockBreak = true
        },
        Ragdoll = {
            Time = 0.9
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 9.5),
            Debug = false,
            Offset = CFrame.new(0, -0.5, -6.5),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HEAVY_HIT", "__Legacy" }
            } }
    }
};
v1["Illusory Blow"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.35,
        Priority = EnumsModule.Stun.Medium
    },
    Ragdoll = {
        Time = 1.3
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Time = 0.1
    },
    Block = {
        Blockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 6),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "WS_HEAVY_HIT", "__Legacy" }
        } },
    Cooldown = {
        Time = 10
    }
};
v1["Killer Perception"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Bullet = {
        Damage = 12.5,
        HitAnimations = "Default",
        Stun = {
            Time = 0.23,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    PilotBullet = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.1,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Cooldown = {
        Time = 12
    }
};
v1["Direct Order"] = {
    Active = true,
    CheckPVPSafe = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Block = {
        BlockBreak = true
    },
    Hit = {
        HitAnimations = "Default",
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 10136337414,
                Volume = 2
            }
        },
        Stun = {
            Time = 0.535
        }
    },
    Explode = {
        Damage = 35,
        Priority = 25,
        Ragdoll = {
            Time = 0.65
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        }
    }
};
v1["Rhinoceros Beetle"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Meter = {
        RequiredLevel = 1
    },
    Properties = {
        Armor = true
    },
    Grab = {
        Damage = 20,
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
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8239441785,
                Volume = 2
            }
        }
    },
    Throw = {
        Damage = 22.5,
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
            } },
        Ragdoll = {
            Time = 1
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HEAVY_HIT", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8283375301,
                Volume = 2
            }
        }
    }
};
v1["Pale Pursuit"] = {
    Active = true,
    CheckPVPSafe = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        Manual = true
    },
    LeaveParts = { "StandHumanoidRootPart", "Pistol", "Disc" },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = false
    },
    Search = {
        Hitbox = {
            Size = 35
        }
    },
    Barrage = {
        Damage = 1.5,
        HitAnimations = "Default",
        Stun = {
            Time = 0.5,
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
        Hitbox = {
            Size = Vector3.new(6, 5.5, 10),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.25)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HIT", "__Legacy" }
            } }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.6,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.2
        },
        Block = {
            Blockable = false
        },
        Ragdoll = {
            Time = 1.25
        },
        Hitbox = {
            Size = Vector3.new(6, 5.5, 10),
            Debug = false,
            Offset = CFrame.new(0, 0, -5.25)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "WS_HEAVY_HIT", "__Legacy" }
            } }
    }
};
v1["Disc Extraction"] = {
    Active = true,
    CheckPVPSafe = true,
    Damage = 1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Stun = {
        Time = 2.5,
        Priority = EnumsModule.Stun.Heavy
    },
    Meter = {
        RequiredLevel = 1
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4),
        PilotData = {
            Size = Vector3.new(6, 5.5, 6),
            RelativePart = "Stand.StandHumanoidRootPart"
        }
    }
};
v1["Melt Your Heart"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30
    },
    Meter = {
        RequiredLevel = 2
    }
};
v1["Disc Insertion"] = {
    Active = true,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Block = {
        Unblockable = true
    },
    Ability = {
        Damage = 5,
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        }
    },
    Memory = {
        Damage = 30,
        TrueDamage = true,
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        }
    }
};
v1.PrimeNumbers = {
    Heal = 20,
    InitialHeal = {
        Heal = 10
    },
    Meter = {
        RequiredAmount = 20,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 30,
        Manual = true
    }
};
v1["Prime Numbers"] = {
    From = "self.PrimeNumbers",
    Active = true,
    Actionable = {
        Active = true
    }
};
v1.Disguise = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    LeaveParts = { "StandHumanoidRootPart", "Pistol", "Disc" },
    Cooldown = {
        Manual = true,
        Time = 6
    }
};
v1["Disc Switch"] = {
    Active = false,
    Actionable = {
        Stunned = false,
        Active = false,
        Disabled = false,
        Summoned = false
    }
};
v1.UMoves = {
    Active = false,
    Actionable = {
        Stunned = false,
        Active = false,
        Disabled = false,
        Summoned = false
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
            ["Disc Switch"] = {
                DefaultKeybind = "B",
                Description = "Swap between the two Disc modes [MEMORY / STAND].",
                Equipped = true,
                MoveCapCount = false
            },
            ["Remote Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "The stand is sent out as it performs a quick barrage.",
                Unlocked = true
            },
            ["Acid Strikes"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Description = "The stand performs a combo of jabs.",
                Unlocked = true
            },
            Crucifixion = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "Dash forward with a crucifix in your hand as you use it to strike a target.",
                Unlocked = true
            },
            ["Domine Quo Vadis"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Description = "The stand jabs before slamming down.",
                Unlocked = true
            },
            ["Disciplinary Knee"] = {
                DefaultKeybind = "R+",
                State = "StandOff",
                Description = "Grab a target, slamming their head into your knee and then tossing them away.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Illusory Blow"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "The stand\'s arm is quickly summoned as it deals a quick blow.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Killer Perception"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "The stand brings out a gun, shooting it 3 times before throwing it away.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Direct Order"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Throw out a Disc forward, exploding upon impact with a target.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Rhinoceros Beetle"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "The stand grabs the target before punching them away.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Pale Pursuit"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                Description = "Send out the stand forward as it tracks someone before unleashing a strong barrage at them.",
                LevelRequirement = 65,
                Cost = {
                    AscensionRank = 5,
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Disc Extraction"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "The stand steals a target\'s Disc, storing it. The type of Disc stolen depends on the Disc mode.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Melt Your Heart"] = {
                DefaultKeybind = "H",
                State = "StandOff",
                Description = "The stand is quickly summoned as it manifests acid around the user. Anyone who touches the acid is put to sleep except the user themselves.",
                LevelRequirement = 100,
                Cost = {
                    AscensionRank = 10,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Disc Insertion"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "The stand inserts a stored Disc. The stand Disc deals multiple hits while the memory Disc alters their vision.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Prime Numbers"] = {
                DefaultKeybind = "J",
                Description = "Start reciting your prime numbers, gradually healing 10 hp for up to a maximum of 100 hp.",
                LevelRequirement = 70,
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
            ["LMB-1"] = 10036899069,
            ["LMB-2"] = 10036901629,
            ["LMB-3"] = 10036907704,
            ["LMB-4"] = 10036912652,
            ["StandOff-LMB-1"] = 10688396131,
            ["StandOff-LMB-2"] = 10688401326,
            ["StandOff-LMB-3"] = 10688403836,
            ["StandOff-LMB-4"] = 10688406327,
            StandBlock = 10808688837,
            StandBlockHit1 = 10808692075,
            StandBlockHit2 = 10808695355,
            StandBlockHit3 = 10808697696,
            StandBlockBreak = 10808701329,
            AcidStrikes = 11370443258,
            RemoteBarrageUser = 8283325994,
            RemoteBarrage = 8222733093,
            DomineQuoVadis = 8253822953,
            DomineQuoVadisPilot = 8254133077,
            KneeSlamStartup = 10912968659,
            KneeSlam = 11289217670,
            KneeSlamVictim = 11289268101,
            Crucifixion = 8222028942,
            KillerPerception = 10034709631,
            KillerPerceptionPilot = 10105112285,
            IllusoryBlow = 10054383820,
            RhinocerosBeetleStartup = 9955779856,
            RhinocerosBeetle = 9955782521,
            RhinocerosBeetleVictim = 9955786162,
            DirectOrder = 9855589080,
            HandDisc = 7911757423,
            MeltYourHeart = 10053333254,
            TargetSleep = 8283607580,
            TargetSleeping = 8283609530,
            DiscExtraction = 10048460161,
            DiscExtractTarget = 10094738678,
            DiscInsertion = 10047933669,
            PalePursuitBarrage = 9955803229,
            PalePursuitStartup = 10037484628,
            PalePursuitRun = 9955800110,
            PalePursuitConfirm = 9955801599,
            Disguise = 10059245112,
            CountTransition = 10105282346,
            CountIdle = 10105285054,
            PilotUserIdle = 10035919728,
            PilotUserTransition = 10035917372,
            PoseTransition = 7816101964,
            PoseIdle = 7816100125,
            PilotPoseTransition = 10037143983,
            PilotPoseIdle = 10037137790
        },
        Movement = {
            Walk = 10158780189,
            Run = 10914799131,
            SummonedWalk = 10158780189,
            SummonedRun = 10914799131,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289,
            PilotForwardDash = 10128375083,
            PilotBackwardDash = 10128373129,
            PilotLeftDash = 10128376957,
            PilotRightDash = 10128378333
        },
        Idle = {
            SummonedIdle = 10536859878,
            Idle = 10074269379
        }
    },
    Stats = v1,
    Sounds = {
        SummonEffects = {
            SoundId = "rbxassetid://8379713668",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://8379713668",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://10136587987",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RemoteSummon = {
            SoundId = "rbxassetid://8239432696",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RemoteDesummon = {
            SoundId = "rbxassetid://8248853312",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://10059431634",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://10059431876",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://10059432380",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://10059432633",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://11038125106",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://13138398947",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://11038124864",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://13138399064",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://11038212735",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://13138398815",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://11038125897",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://13138398667",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        AcidStrikes = {
            SoundId = "rbxassetid://10059459463",
            Volume = 1,
            PlaybackSpeed = 1.5,
            Looped = false,
            TimePosition = 0
        },
        RemoteBarrage = {
            SoundId = "rbxassetid://10083852531",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DomineStart = {
            SoundId = "rbxassetid://8283373385",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DomineVoice = {
            SoundId = "rbxassetid://8283374158",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DominePilotVoice = {
            SoundId = "rbxassetid://10136346919",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DomineMiss2 = {
            SoundId = "rbxassetid://8283376267",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DomineMiss1 = {
            SoundId = "rbxassetid://8283375827",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DomineHit2 = {
            SoundId = "rbxassetid://8283375301",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DomineHit1 = {
            SoundId = "rbxassetid://8283374745",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeetleVoice = {
            SoundId = "rbxassetid://10083849156",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeetlePilotVoice = {
            SoundId = "rbxassetid://10136345916",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeetleGrab = {
            SoundId = "rbxassetid://10059489893",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeetleSwing = {
            SoundId = "rbxassetid://10059490226",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CrossStab = {
            SoundId = "rbxassetid://8229573456",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CrossStart = {
            SoundId = "rbxassetid://8232970515",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillerPerceptionVoice = {
            SoundId = "rbxassetid://10059468740",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillerPerceptionPilotVoice = {
            SoundId = "rbxassetid://10136346546",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillerPerception = {
            SoundId = "rbxassetid://10059468343",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunFire = {
            SoundId = "rbxassetid://6508785533",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GunDrop = {
            SoundId = "rbxassetid://10136347747",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        IllusoryStart = {
            SoundId = "rbxassetid://8254510742",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        IllusoryBlow = {
            SoundId = "rbxassetid://8254511066",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DirectOrderVoice = {
            SoundId = "rbxassetid://10055791525",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DirectOrder = {
            SoundId = "rbxassetid://10055715067",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Extract = {
            SoundId = "rbxassetid://10059490500",
            Volume = 1,
            PlaybackSpeed = 1.25,
            Looped = false,
            TimePosition = 0
        },
        ExtractHit = {
            SoundId = "rbxassetid://10059491041",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ExtractGrab = {
            SoundId = "rbxassetid://10083842714",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ExtractVoice = {
            SoundId = "rbxassetid://10083848221",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ExtractStandVoice = {
            SoundId = "rbxassetid://10083842996",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ExtractPilotVoice = {
            SoundId = "rbxassetid://10136344476",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PalePursuitVoice = {
            SoundId = "rbxassetid://10083849843",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PalePursuitRun = {
            SoundId = "rbxassetid://10136348123",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        InsertSwing = {
            SoundId = "rbxassetid://10083832264",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        InsertHit = {
            SoundId = "rbxassetid://10083831726",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        InsertVoice = {
            SoundId = "rbxassetid://10083833005",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        InsertPilotVoice = {
            SoundId = "rbxassetid://10136344144",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeltYourHeartStandVoice = {
            SoundId = "rbxassetid://10083836589",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeltYourHeart = {
            SoundId = "rbxassetid://10083836945",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeltYourHeartHit = {
            SoundId = "rbxassetid://10108752707",
            Volume = 1.3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeltYourHeartSleep = {
            SoundId = "rbxassetid://10108753573",
            Volume = 1.3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Count = {
            SoundId = "rbxassetid://10083836299",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Disguise = {
            SoundId = "rbxassetid://10136331795",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Disguised = {
            SoundId = "rbxassetid://10136336317",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Undisguise = {
            SoundId = "rbxassetid://10141966253",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://9992381568",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Knee Grab Startup SFX"] = {
            SoundId = "rbxassetid://18556702920",
            Volume = 1.3
        },
        ["Knee Grab Startup VL"] = {
            SoundId = "rbxassetid://18556703295",
            Volume = 1.3
        },
        ["Knee Grab SFX"] = {
            SoundId = "rbxassetid://18556703807",
            Volume = 1.3
        },
        ["Knee Grab VL"] = {
            SoundId = "rbxassetid://18556703562",
            Volume = 1.3
        },
        Grab = {
            SoundId = "rbxassetid://18556784864",
            Volume = 2
        },
        Grabbed = {
            SoundId = "rbxassetid://18556785052",
            Volume = 2
        },
        GrabbedVoiceline = {
            SoundId = "rbxassetid://18556784689",
            Volume = 2
        },
        Throw = {
            SoundId = 1,
            Volume = 1
        }
    },
    QuoteInfo = {
        Groups = {
            StandOff = {
                Visible = true
            },
            StandOn = {
                Visible = false
            }
        },
        Quotes = {
            StandOff = { {
                    SoundId = "rbxassetid://9061950072",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Humans ought to lead a life that leads them to heaven."
                        } }
                }, {
                    SoundId = "rbxassetid://10083850917",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "That was vexing, but my snake would never lose to frogs."
                        } }
                }, {
                    SoundId = "rbxassetid://10083852199",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Truly, an evil disposition cannot be corrected."
                        } }
                }, {
                    SoundId = "rbxassetid://9061946812",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'ll never wake up again."
                        } }
                } },
            StandOn = { {
                    SoundId = "rbxassetid://10136615863",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The soul of a dead criminal, returns to the earth in the form of a frog in want of companions to the afterlife. Doesn\'t it describe this hellish scene perfectly?"
                        } }
                }, {
                    SoundId = "rbxassetid://10136616232",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This DISC shall suit you."
                        } }
                }, {
                    SoundId = "rbxassetid://10136616640",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is Whitesnake\'s ability!"
                        } }
                }, {
                    SoundId = "rbxassetid://10136617594",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You shall be my scapegoat for the murder. This way, everything works out peacefully."
                        } }
                } }
        }
    }
};