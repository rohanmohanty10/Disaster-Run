  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Trove = require(Knit.Util.Trove);
local ClientAssets = PathShortcuts.ClientAssets;
local GenericModule = require(PathShortcuts.GenericModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local AnimsModule = require(PathShortcuts.AnimsModule);
local v2 = { {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/LightHit"
            } }
    } };
local v3 = { {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/HeavyHit",
                LookAt = "Attacker"
            } }
    } };
v1.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    StandAura = false,
    Actionable = {
        NoPilot = true
    },
    CustomTransparency = {
        ["Meshes/moon_Head.002"] = {
            SummonTransparency = 0.05
        },
        ["head 2"] = {
            SummonTransparency = 1
        }
    },
    LeaveParts = { "head 2", "StandHumanoidRootPart" },
    AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(71, 239, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 98, 61)) }),
    Callbacks = {
        Summon = function(p4) -- Line: 74, Name: Summon
            -- upvalues: Knit (copy), ParticleHandler (copy)
            Knit.GetService("AnimationService").Get(p4.Character.Humanoid.Animator):PlayAnimation("Summon");

            for _, descendant in pairs(p4.AbilityModel:GetDescendants()) do
                if descendant.Name == "StandAura" and (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                    descendant.Enabled = true;
                    descendant.Archivable = false;
                end;
            end;

            local v5 = ParticleHandler.TryHSVShift(p4.Stats.AuraColor or p4.ParentStats.Summon.AuraColor, ParticleHandler.GetUnusualHSVData(p4));

            for _, child in pairs(p4.Character:GetChildren()) do
                if child:IsA("BasePart") then
                    for _, child2 in pairs(child:GetChildren()) do
                        if child2.Name == "StandAura" and child2:IsA("ParticleEmitter") then
                            child2.Enabled = true;
                            child2.Color = v5;
                        end;
                    end;
                end;
            end;
        end,

        Unsummon = function(p6) -- Line: 100, Name: Unsummon
            for _, descendant in pairs(p6.AbilityModel:GetDescendants()) do
                if descendant.Name == "StandAura" and (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                    descendant.Enabled = false;
                end;
            end;

            for _, child in pairs(p6.Character:GetChildren()) do
                if child:IsA("BasePart") then
                    for _, child2 in pairs(child:GetChildren()) do
                        if child2.Name == "StandAura" and child2:IsA("ParticleEmitter") then
                            child2.Enabled = false;
                        end;
                    end;
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
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 20, 25, "Attack" }, { 30, "End" } },
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 13138395444,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        HitSounds = {
            Hit = {
                SoundId = 13138395444,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        HitSounds = {
            Hit = {
                SoundId = 13138395444,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 2,
        Sequence = { { 0, "Start" }, { 35, "Attack" }, { 40, "End" } },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 13138395283,
                Volume = 1.5
            }
        },
        StatusEffects = {}
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 28, "End" } },
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 11038124693,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 8, 13, "Attack" }, { 18, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 10, 13, "Attack" }, { 18, "End" } },
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
            { 0, function(u7, p8, p9) -- Line: 238
                    -- upvalues: ClientAssets (copy)
                    u7.UserData.Attachment = ClientAssets.Whitesnake.CrossEffects.Attachment:Clone();
                    u7.UserData.Attachment.Parent = p9.Character["Left Arm"];
                    u7.UserData.Attachment.StartupShine:Emit(1);
                    u7.UserData.Attachment.StartupTwinkle:Emit(1);
                    task.delay(0.05, function() -- Line: 245
                        -- upvalues: u7 (copy)
                        u7.UserData.Attachment.Twinkle1:Emit(3);
                        u7.UserData.Attachment.Twinkle2:Emit(3);
                        u7.UserData.Attachment.Swirls:Emit(3);
                    end);
                    task.delay(0.15, function() -- Line: 251
                        -- upvalues: u7 (copy)
                        u7.UserData.Attachment.ParticleEmitter:Emit(8);
                    end);
                    task.delay(0.6, function() -- Line: 255
                        -- upvalues: u7 (copy)
                        u7.UserData.Attachment:Destroy();
                    end);
                end },
            { 36, 42, "Attack" },
            { 48, "End" }
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11038126198,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p10, p11) -- Line: 273, Name: StateChecker
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
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p12, p13) -- Line: 295, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p12.Character, true);
        end,

        PoseEnd = function(p14, p15) -- Line: 298, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p14.Character, false);
        end
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
v1["Center Of Gravity"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 16
    },
    Hit = {
        CheckPVPSafe = true,
        HitAnimations = "Default",
        Stun = {
            Time = 2.5,
            Priority = EnumsModule.Stun.Heavy
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Debug = false,
            Offset = CFrame.new(0, 0, -7)
        },
        Block = {
            PerfectBlockable = false
        }
    }
};
v1.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 0.6,
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 11033141758,
                Volume = 1.5
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "LesserInversion",
                Damage = 0.8
            } }
    },
    Finisher = {
        Damage = 15,
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11033142958,
                Volume = 1.5
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "LesserInversion",
                Damage = 10
            } }
    },
    ClashHit = {},
    ClashFinisher = {}
}, BaseStatsModule.Stand_Barrage);
v1["Arm Crusher"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 12
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11038428359,
                Volume = 1.5
            }
        }
    },
    Invert = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        }
    }
};
v1["Inversion Strike"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 12
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11033151208,
                Volume = 1.5
            }
        }
    },
    Invert = {
        Damage = 15,
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Heavy
        },
        HitSounds = {
            Hit = {
                SoundId = 11033150718,
                Volume = 1.5
            }
        }
    }
};
v1["Heart Inversion"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 12
    },
    Hit = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11033151208,
                Volume = 1.5
            }
        }
    },
    Invert = {
        Damage = 20,
        Stun = {
            Time = 0.6
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
                SoundId = 11033150718,
                Volume = 1.5
            }
        }
    }
};
v1["Only One Punch"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 18
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 25
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.9,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Debug = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = v3
    },
    Punch = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Stun = {
            Time = 0.9,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        }
    },
    Throw = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 32,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        }
    }
};
v1["Singularity Point"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 16
    },
    Hit = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 1.2,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(5.9500003, 5.9500003, 5.9500003),
            Debug = false,
            Offset = CFrame.new(0, 0, -2.975),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11062791765,
                Volume = 1.5
            }
        }
    },
    Pull = {
        CheckPVPSafe = true,
        Stun = {
            Time = 1.2
        },
        Knockback = {
            Speed = 15,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 7.5,
            Debug = false,
            Offset = CFrame.new(0, 0, -7),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        }
    }
};
v1["Debris Shotgun"] = {
    Active = true,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 15
    },
    Meter = {
        RequiredLevel = 1
    },
    Hit = {
        Damage = 11,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.8,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 42,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 11, 11),
            Debug = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitSounds = {
            Hit = {
                SoundId = 11068398181,
                Volume = 1.5
            }
        }
    },
    SummonHit = {
        Damage = 7,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 22.5,
            Time = 0.2
        },
        Ragdoll = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(30, 3, 30),
            Debug = false,
            Offset = CFrame.new(0, -2.65, -5)
        },
        HitSounds = {
            Hit = {
                SoundId = 11033150718,
                Volume = 1.5
            }
        }
    },
    Invert = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.5
        }
    },
    Debris = {
        Damage = 12,
        Priority = EnumsModule.Intangible.Ragdoll,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        },
        Ragdoll = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v1["Palm Kinesis"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 12
    },
    Hit = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11062721192,
                Volume = 1.5
            }
        }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        },
        Ragdoll = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11062721750,
                Volume = 1.5
            }
        }
    },
    Invert = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.6
        }
    }
};
v1["Gravitational Elimination"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 60
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 75
    },
    Hit = {
        Damage = 10,
        MinHealth = 1,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 0.9,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Debug = false,
            Offset = CFrame.new(0, 0, -7)
        }
    },
    Punch = {
        MinHealth = 1,
        Damage = 2.5,
        Meter = {
            MeterGain = 0
        },
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.9,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = false
        }
    },
    Uppercut = {
        Damage = 10,
        MinHealth = 1,
        Meter = {
            MeterGain = 0
        },
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.9,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = false
        }
    },
    Throw = {
        Damage = 10,
        Meter = {
            MeterGain = 0
        },
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false
        }
    }
};
v1["Gravitational Shift"] = {
    Active = true,
    Time = 20,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 20
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 50
    },

    Invoke = function(p16) -- Line: 1113, Name: Invoke
        -- upvalues: Knit (copy), Trove (copy), EnumsModule (copy), AnimsModule (copy), GenericModule (copy)
        local Character = p16.Player.Character;
        local Humanoid = Character.Humanoid;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local _ = p16.Input;
        Knit.GetController("MoveInputController");
        local v17 = Knit.GetService("MoveInputService");
        local u18 = Knit.GetController("CombatController");
        v17:FireInput(p16.RawInput):expect();

        if Character:GetAttribute("GravityShift") and not Character:GetAttribute("GravityShiftHooked") then
            Character:SetAttribute("GravityShiftHooked", true);
            local u19 = Trove.new();
            u19:AttachToInstance(Character);

            local function Drift() -- Line: 1153
                -- upvalues: Character (copy), u18 (copy), EnumsModule (ref), HumanoidRootPart (copy), AnimsModule (ref), Humanoid (copy), GenericModule (ref)
                if Character:GetAttribute("Drifting") then
                    return;
                end;

                if not Character:GetAttribute("GravityShift") then
                    return;
                end;

                if u18.IsActive(Character, EnumsModule.Active.Main) then
                    return;
                end;

                Character:SetAttribute("Drifting", true);
                local v20 = HumanoidRootPart.Velocity * Vector3.new(1, 0, 1);
                local u21;

                if v20 == Vector3.new(0, 0, 0) then
                    u21 = -HumanoidRootPart.CFrame.LookVector;
                else
                    u21 = v20.Unit;
                end;

                local u22 = math.clamp((HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude, 20, 24);
                local u23 = math.clamp(HumanoidRootPart.Velocity.Y, -175, 175);
                local u24 = 0;
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
                AnimsModule.playClient("C-Moon", "Float", nil, 1.5);
                task.spawn(function() -- Line: 1182
                    -- upvalues: Character (ref), Humanoid (ref), u18 (ref), EnumsModule (ref), u21 (ref), u22 (ref), GenericModule (ref), u23 (ref), u24 (ref), BodyVelocity (copy), HumanoidRootPart (ref), AnimsModule (ref)
                    time();
                    local v25 = os.clock() - 0.016666666666666666;

                    while Character:GetAttribute("Drifting") and (Character:GetAttribute("GravityShift") and (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and (Humanoid:GetState() == Enum.HumanoidStateType.Freefall and not u18.IsActive(Character, EnumsModule.Active.Main)))) do
                        local v26 = os.clock() - v25;
                        v25 = os.clock();

                        if Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
                            u21 = u21:Lerp(Humanoid.MoveDirection, v26 * 4);
                        end;

                        u22 = GenericModule.Lerp(u22, 20, v26 * 1.5);
                        u23 = GenericModule.Lerp(u23, 0, v26 * 0.75);
                        u24 = GenericModule.Lerp(u24, 60, v26 * 0.4);
                        BodyVelocity.Velocity = u21 * u22 + Vector3.new(0, -u24 + u23, 0);
                        BodyVelocity.Parent = HumanoidRootPart;
                        task.wait();
                    end;

                    Character:SetAttribute("Drifting", nil);
                    BodyVelocity:Destroy();
                    AnimsModule.stopClient("C-Moon", "Float");
                end);
            end;

            u19:Connect(Character:GetAttributeChangedSignal("GravityShift"), function() -- Line: 1211
                -- upvalues: Character (copy)
                if not Character:GetAttribute("GravityShift") then
                    Character:SetAttribute("GravityShiftHooked", nil);
                end;
            end);
            u19:Connect(Character.AncestryChanged, function() -- Line: 1217
                -- upvalues: Character (copy), u19 (copy)
                if not Character:IsDescendantOf(game) then
                    u19:Destroy();
                end;
            end);
            u19:Connect(game:GetService("UserInputService").InputBegan, function(p27, p28) -- Line: 1223
                -- upvalues: Humanoid (copy), Drift (copy)
                if not p28 and (p27.KeyCode == Enum.KeyCode.Space and Humanoid:GetState() == Enum.HumanoidStateType.Freefall) then
                    Drift();
                end;
            end);
        end;
    end
};
v1["Prime Numbers"] = {
    From = "Whitesnake.PrimeNumbers",
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
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
            Inversion = {
                State = "Passive",
                Description = "Some moves apply an Inversion effect on the victim. Inversion deals damage when the effect ends. If stacked, destroys the effect and deals half of the original damage. Inversion is unblockable, and goes through nearly all resistances.",
                Equipped = true,
                MoveCapCount = false
            },
            ["Lesser Inversion"] = {
                State = "Passive",
                Description = "Barrage applies Lesser Inversion, which deals damage when the effect ends. If stacked, overrides the previous damage. Lesser inversion is unblockable, and goes through nearly all resistances.",
                Equipped = true,
                MoveCapCount = false
            },
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
            ["Center Of Gravity"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "Manifest the stand to invert the gravitational force in front of you, leaving victims stunned and vulnerable to attacks.",
                Unlocked = true
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike.",
                Unlocked = true
            },
            ["Arm Crusher"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "Briefly summon the stand to crush an opponent\'s arms.",
                Unlocked = true
            },
            ["Inversion Strike"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Description = "Throw out a punch that pushes back your opponent.",
                Unlocked = true
            },
            ["Heart Inversion"] = {
                DefaultKeybind = "R+",
                State = "StandOn",
                Description = "Strike someone in the chest and invert their heart to blow them away.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Only One Punch"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Unleash a punch on the ground in front of you. If the move is landed, trap the opponent in a state of zero gravity and uppercut them away.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Singularity Point"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Swipe forward with your fist and create a gravitational force that pulls opponents towards you.",
                LevelRequirement = 20,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Debris Shotgun"] = {
                DefaultKeybind = "T",
                Description = "Smash the ground with your fists and lift up debris before shooting it forward.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Palm Kinesis"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Deliver a 2 hit combo using your palms.",
                LevelRequirement = 30,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Gravitational Elimination"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Slam down on your opponent and hold them in place with zero gravity, before pulling them forward and delivering a devastating punch that knocks them away.",
                LevelRequirement = 65,
                Cost = {
                    AscensionRank = 10,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Gravitational Shift"] = {
                DefaultKeybind = "B",
                Description = "Lower the gravitational force around you, which boosts your jump and reflects incoming projectiles.",
                LevelRequirement = 90,
                Cost = {
                    AscensionRank = 5,
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Prime Numbers"] = {
                DefaultKeybind = "J",
                Description = "Start reciting your prime numbers, gradually healing 10 hp for up to a maximum of 100 hp.",
                LevelRequirement = 80,
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
            ["LMB-1"] = 11063407023,
            ["LMB-2"] = 11063410729,
            ["LMB-3"] = 11063412797,
            ["LMB-4"] = 11063414925,
            ["StandOff-LMB-1"] = 10688396131,
            ["StandOff-LMB-2"] = 10688401326,
            ["StandOff-LMB-3"] = 10688403836,
            ["StandOff-LMB-4"] = 10688406327,
            StandBlock = 10808688837,
            StandBlockHit1 = 10808692075,
            StandBlockHit2 = 10808695355,
            StandBlockHit3 = 10808697696,
            StandBlockBreak = 10808701329,
            BarrageStartup = 11064727600,
            Barrage = 11064717857,
            BarrageFinisher = 11064723359,
            BarrageClashEnd = 10839831781,
            CenterOfGravity = 10999442929,
            Grab = 10907328566,
            Throw = 10907329255,
            ThrowVictim = 10907329938,
            InversionStrike = 11092487307,
            InversionStrikeVictim = 10981072367,
            HeartInversion = 11092518454,
            HeartInversionVictim = 10981148112,
            ArmCrusher = 10629210500,
            ArmCrusherVictim = 10632044582,
            SingularityPoint = 11092535961,
            OnlyOnePunch = 11062207096,
            OnlyOnePunchAttack = 11062210242,
            OnlyOnePunchVictim = 11062212505,
            GroundSlam = 10981318242,
            DebrisShotgun = 10981321823,
            PalmKinesis = 11092566315,
            EliminationStartup = 11231006296,
            EliminationStartupVictim = 11231028815,
            Elimination = 11231118645,
            EliminationVictim = 11231140458,
            EliminationCamera = 11231241727,
            GravityShift = 11237697351,
            PilotUserIdle = 11100475650,
            PilotUserTransition = 11100473471,
            PilotForwardDash = 10128375083,
            PilotBackwardDash = 10128373129,
            PilotLeftDash = 10128376957,
            PilotRightDash = 10128378333,
            CountTransition = 10105282346,
            CountIdle = 10105285054,
            PoseIdle = 8101642004,
            PoseTransition = 8101642840,
            ["Quote-1"] = 11106373775,
            ["Quote-2"] = 11106382126,
            ["Quote-3"] = 11106383700,
            Float = 11265008044
        },
        Movement = {
            Walk = 10998529485,
            SummonedWalk = 10998529485,
            Run = 10914799131,
            SummonedRun = 10914799131,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 10998520770,
            Idle = 10998515521
        }
    },
    Stats = v1,
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://11033125911",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://13138398499",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://11033127235",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Desummon-Voiceline"] = {
            SoundId = "rbxassetid://13140811156",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Remote-Summon-SFX"] = {
            SoundId = "rbxassetid://13140811987",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Remote-Summon-Voiceline"] = {
            SoundId = "rbxassetid://13140812166",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://13138396672",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://13138397155",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://13138395129",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://13138397447",
            Volume = 2,
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
        BarrageVoiceline = {
            SoundId = 13138398177,
            Volume = 2
        },
        BarrageRemoteVoiceline = {
            SoundId = 11247047593,
            Volume = 2
        },
        Barrage = {
            SoundId = 11033137843,
            Volume = 2
        },
        CenterOfGravity = {
            SoundId = 11033145404,
            Volume = 2
        },
        CenterOfGravityVoiceline = {
            SoundId = 13138397000,
            Volume = 2
        },
        InversionStrike = {
            SoundId = 11033148298,
            Volume = 2
        },
        InversionStrikeVoiceline = {
            SoundId = 13138397566,
            Volume = 2
        },
        InversionStrikeRemoteVoiceline = {
            SoundId = 11247048144,
            Volume = 2
        },
        HeartInversion = {
            SoundId = 11033158658,
            Volume = 2
        },
        HeartInversionVoiceline = {
            SoundId = 13138397974,
            Volume = 2
        },
        HeartInversionRemoteVoiceline = {
            SoundId = 13140811271,
            Volume = 2
        },
        ArmCrusher = {
            SoundId = 11038429151,
            Volume = 2
        },
        ArmCrusherVoiceline = {
            SoundId = 13138399495,
            Volume = 2
        },
        SingularityPoint = {
            SoundId = 11062792961,
            Volume = 2
        },
        SingularityPointVoiceline = {
            SoundId = 13138396832,
            Volume = 2
        },
        SingularityPointRemoteVoiceline = {
            SoundId = 13140811428,
            Volume = 2
        },
        SingularityPointPull = {
            SoundId = 11062790870,
            Volume = 2
        },
        BodyInversion = {
            SoundId = 11101005820,
            Volume = 2
        },
        BodyInversionVoiceline = {
            SoundId = 13138397684,
            Volume = 2
        },
        BodyInversionHit = {
            SoundId = 11101006154,
            Volume = 2
        },
        BodyInversionHitVoiceline = {
            SoundId = 13138397321,
            Volume = 2
        },
        DebrisShotgun = {
            SoundId = 11038432895,
            Volume = 2
        },
        DebrisShotgunVoiceline = {
            SoundId = 13140811840,
            Volume = 2
        },
        DebrisShotgunRemoteVoiceline = {
            SoundId = 13140811840,
            Volume = 2
        },
        DebrisHit = {
            SoundId = 11038432217,
            Volume = 2
        },
        PalmKinesis = {
            SoundId = 11062720372,
            Volume = 2
        },
        PalmKinesisVoiceline = {
            SoundId = 13138397824,
            Volume = 2
        },
        PalmKinesisRemoteVoiceline = {
            SoundId = 13140810414,
            Volume = 2
        },
        Elimination = {
            SoundId = 13138396268,
            Volume = 2
        },
        EliminationVoiceline = {
            SoundId = 13138395833,
            Volume = 2
        },
        EliminationStartup = {
            SoundId = 13138396043,
            Volume = 2
        },
        EliminationStartupVoiceline = {
            SoundId = 13138398350,
            Volume = 2
        },
        GravityFieldReflect = {
            SoundId = 11247015936,
            Volume = 2
        },
        GravityField = {
            SoundId = 13140811657,
            Looped = true,
            Volume = 2
        },
        GravityFieldVoiceline = {
            SoundId = 13138396502,
            Volume = 2
        },
        Count = {
            SoundId = "rbxassetid://10083836299",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Grab = {
            SoundId = 11038643123,
            Volume = 2
        },
        Grabbed = {
            SoundId = 11038640046,
            Volume = 2
        },
        GrabbedVoiceline = {
            SoundId = 13140810868,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 13140811020,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13140810545,
            Volume = 2
        },
        LesserInversion = {
            SoundId = 11038852708,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 10394749914,
            Volume = 2,
            PlaybackSpeed = 0.9,
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
                    SoundId = "rbxassetid://13138399892",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Stand up. This is far from over."
                        } }
                }, {
                    SoundId = "rbxassetid://13138400100",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Stand down. You are hardly even a trial for me."
                        } }
                }, {
                    SoundId = "rbxassetid://13138399755",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "If you can\'t understand fate, then you must simply have to die. "
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p29) -- Line: 1949, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p29.Player;
            local Character = p29.Character;
            local SkinName = p29.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v30 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v30.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v30;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};