  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local ClientAssets = PathShortcuts.ClientAssets;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy), u3 (ref), u4 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("QuoteService");
    u4 = Knit.GetService("MoveIndicatorService");
end);
local v5 = {
    LightHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                AutoSerialize = true,
                Particle = ClientAssets.Assets.Abilities["Black Blur"].Particles.HitFX
            }
        }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                AutoSerialize = true,
                Particle = ClientAssets.Assets.Abilities["Black Blur"].Particles.HeavyHitFX
            }
        }
    },
    BloodHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "Blood Rays",
            {
                Part = "__Target",
                SearchPart = "HumanoidRootPart",
                TrailRange = NumberRange.new(2, 5)
            }
        }
    },
    BloodHit_Cid = {
        Name = "Output",
        Arguments = {
            "FX",
            "Shadow_Hit",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                Particle = ClientAssets.Universal.BloodVFX
            }
        }
    },
    LMBHit1 = {
        SoundId = 136528963419045,
        Volume = 3
    },
    LMBHit2 = {
        SoundId = 95858995995547,
        Volume = 3
    },
    HeavyHitSound = {
        SoundId = "",
        Volume = 2
    }
};
local v6 = {
    Stats = {},
    Resources = v5
};
v6.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Active = true
    },
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 1,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.3,
        Sequence = { { 0, "Start" }, { 5, "PlaySound", "SwingLMB" }, { 24, 28, "Attack" }, { 40, "End" } },
        Stun = {
            Time = 0.55
        },
        HitRemotes = { v6.Resources.LightHit },
        HitSounds = { v6.Resources.LMBHit1 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.3,
        Sequence = { { 0, "Start" }, { 5, "PlaySound", "SwingLMB" }, { 26, 30, "Attack" }, { 40, "End" } },
        HitSounds = { v6.Resources.LMBHit1 },
        HitRemotes = { v6.Resources.LightHit }
    },
    ["LMB-3"] = {
        Speed = 1.3,
        Sequence = { { 0, "Start" }, { 5, "PlaySound", "SwingLMB" }, { 24, 28, "Attack" }, { 40, "End" } },
        HitSounds = { v6.Resources.LMBHit1 },
        HitRemotes = { v6.Resources.LightHit }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 5, "PlaySound", "SwingLMB" }, { 26, 30, "Attack" }, { 42, "End" } },
        Hitbox = {
            Type = "Magnitude",
            Size = 10,
            Offset = CFrame.identity
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 0.75
        },
        HitRemotes = { v6.Resources.HeavyHit },
        HitSounds = { v6.Resources.LMBHit2 }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v6.Stats.Block = {
    From = "Combat.Block"
};
v6.Stats.Breaker = {
    From = "Combat.Breaker"
};
v6.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v6.Stats.Grab = {
    From = "Combat.Grab"
};
v6.Stats.Pose = {
    From = "Combat.Pose",
    MusicAmount = 2,
    SkipTransition = true
};
v6.Stats["Shadow Heal"] = {
    Active = true,
    Heal = 1,
    MinimumHeal = 20,
    MaximumHeal = 75,
    MaximumHealRingRequirement = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Block = {
        PerfectBlockable = false,
        Unblockable = true
    }
};
v6.Stats["Chaos Rift"] = {
    Active = true,
    ChargeInterval = 0.1,
    MaxCharges = 25,
    DistancePerCharge = 2.75,
    TargetCacheLength = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 6,
        AfterMove = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 8
    },
    Attack = {
        Damage = 25,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 0.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 2,
            Time = 0.15,
            Velocity = Vector3.new(0, 50, 0)
        },
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Homing Target Lock",
                Overrides = {
                    Lifetime = 10
                }
            } }
    }
};
v6.Stats["Chaos Blast"] = {
    Active = true,
    Damage = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 35,
        AfterMove = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 27.5
    },
    Stun = {
        Time = 2
    },
    Ragdoll = {
        Time = 2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 45,
        Time = 0.25,
        Velocity = Vector3.new(0, 20, 0),
        Origin = CFrame.identity
    },
    Block = {
        PerfectBlockable = false,
        Unblockable = true
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Homing Target Lock",
            Overrides = {
                Lifetime = 10
            }
        } }
};
v6.Stats["Chaos Spear"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    ChargeInterval = 0.1,
    MaxCharges = 25,
    DoomSpearAt = 12,
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Spear = {
        ProcCoefficient = 0.25,
        Damage = 5,
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 17.5, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        }
    },
    ["Doom Spear"] = {
        ProcCoefficient = 0.5,
        Damage = 5,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 17.5, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 1.5,
                Overrides = {
                    Lifetime = 5,
                    Rate = 1
                }
            } }
    }
};
v6.Stats["Infused Punch"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 7, 11),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.2,
        Velocity = Vector3.new(0, 5, 0)
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = true
    },
    Search = {
        Size = 16,
        Offset = CFrame.new(0, 0, -8)
    }
};
v6.Stats["Propulsion Kick"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 11,
        AfterMove = true
    },
    Ground = {
        Damage = 30,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 7, 14),
            Offset = CFrame.new(0, 0, -7)
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 55,
            Time = 0.2,
            Velocity = Vector3.new(0, 15, 0)
        },
        Block = {
            PerfectBlockable = true,
            BlockBreak = true
        }
    },
    InitialSpin = {
        Hitbox = {
            Type = "Magnitude",
            Size = 5.5
        }
    },
    Backwards = {
        Damage = 2,
        Hitbox = {
            HitboxType = "ClientHitbox",
            Type = "Magnitude",
            Size = 6
        },
        Stun = {
            Time = 0.35
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = false,
            Blockable = true
        }
    },
    Air = {
        Damage = 20,
        Hitbox = {
            HitboxType = "ClientHitbox",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 10, 8),
            Offset = CFrame.new(0, -7.5, -2.75)
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.2
        },
        Block = {
            PerfectBlockable = true,
            BlockBreak = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Homing Target Lock",
                Overrides = {
                    Lifetime = 10
                }
            } }
    }
};
v6.Stats["Homing Attack"] = {
    Active = true,
    DistanceToTeleport = 12.5,
    TeleportationInterval = 3,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false,
        MeterGain = 0
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        Type = "Magnitude",
        Size = 6
    },
    Attack = {
        Damage = 15,
        Stun = {
            Time = 1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true
        }
    },
    Detect = {
        MaxDistance = 9000000000,
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            Type = "Magnitude",
            Size = 30
        },
        Block = {
            PerfectBlockable = false,
            BypassCounter = true,
            Blockable = false,
            BlockCancel = false
        }
    }
};
v6.Stats.Spindash = {
    Active = true,
    Damage = 2,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = true,
        MeterGain = 0
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        Type = "Magnitude",
        Size = 5.25
    },
    Stun = {
        Time = 0.2
    },
    Block = {
        Blockable = true,
        BlockBreak = false,
        PerfectBlockable = false
    }
};
v6.Stats.Jackpot = {
    Priority = EnumsModule.Intangible.Move,
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Damage = 35,
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 45,
        Time = 0.15
    },
    HitSounds = { {
            SoundId = 83991951467027,
            Volume = 2
        } },
    HitRemotes = { v6.Resources.BloodHit_Cid, v6.Resources.BloodHit },
    Super = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.15,
            Velocity = Vector3.new(0, 12.5, 0)
        },
        HitRemotes = { v6.Resources.BloodHit }
    }
};
v6.Stats["Super Shadow"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 2,
        AfterMove = true
    }
};
v6.Stats["Dark Rush"] = {
    Active = true,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 1.8,
        Stun = {
            Time = 0.5,
            Barrage = true,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -6)
        }
    },
    Finisher = {
        Damage = 22,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.15
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Size = Vector3.new(13.5, 13.5, 13.5),
            Offset = CFrame.new(0, 0, -6.75)
        }
    }
};
v6.Stats.Timestop = {
    Active = true,
    Actionable = {
        Active = true,
        CanTimestop = true,
        Timestopped = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Sequence = { { 0, "PlayAnim", "Chaos Control" }, { 0, "PlaySound", "Chaos Control" }, { 0, "PlaySound", "Chaos Control Voiceline" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 57, "Timestop" }, { 90, "End" } },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 3.75,
        IgnoreCooldown = true,
        StopSounds = { "Chaos Control Stop" },
        ResumeSounds = { "Chaos Control Resume" }
    }
};
v6.Stats["Chaotic Displacement"] = {
    Distance = 15,
    WaitTime = 0.1,
    Active = true,
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Active = true
    },
    Cooldown = {
        Time = 0.1,
        Manual = true
    },

    Invoke = function(p7) -- Line: 869, Name: Invoke
        -- upvalues: Knit (copy), EffectsHandler (copy)
        local Character = p7.Character;
        local Stats = p7.Stats;
        local v8 = Character:GetAttribute("STHTPStacks");

        if not v8 or v8 == 0 then
            return;
        end;

        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v9 = Knit.GetService("MoveInputService");
        local v10 = RaycastParams.new();
        v10.FilterType = Enum.RaycastFilterType.Exclude;
        v10.FilterDescendantsInstances = { Character, workspace.Effects, workspace.ItemSpawns };
        local v11 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Distance = Stats.Distance;
        local v12 = workspace:Raycast(HumanoidRootPart.Position, v11 * Distance, v10);

        if v12 then
            Distance = (HumanoidRootPart.Position - v12.Position).Magnitude;
        end;

        local v13 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v11).LookVector.Unit * Distance;
        v9:FireInput(p7.RawInput, v13);
        EffectsHandler.Wait(Stats.WaitTime);
    end
};
v6.Stats.Barrier = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 5,
        RemoveMeter = false
    }
};

return {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            Super = {
                Visible = false,
                Priority = 2
            },
            Chaos = {
                Visible = false,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Chaotic Inbument"] = {
                State = "Passive",
                Description = "I\'m the coolest.",
                Equipped = true,
                DisplayName = "Void Imbument"
            },
            ["Void Inhibitor"] = {
                State = "Passive",
                Description = "Your true potential is sealed away via a ring on each arm. It may be unlocked under special conditions.",
                Equipped = true
            },
            Stars = {
                State = "Passive",
                Description = "TBA",
                Equipped = true
            },
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false,
                Description = "In"
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Chaos Rift"] = {
                DefaultKeybind = "Q",
                Unlocked = true,
                DisplayName = "Void Rift",
                Description = "Q Description"
            },
            ["Dark Rush"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Box Description"
            },
            ["Infused Punch"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Xeno Description"
            },
            ["Homing Attack"] = {
                DefaultKeybind = "R+",
                Unlocked = true,
                Description = "Crimin Description"
            },
            ["Chaotic Displacement"] = {
                DefaultKeybind = "V",
                Unlocked = true,
                DisplayName = "Void Rift",
                Description = "Loki Description"
            },
            ["Chaos Spear"] = {
                DefaultKeybind = "T",
                Unlocked = true,
                DisplayName = "Burning Spear",
                Description = "Z4 Description"
            },
            Spindash = {
                DefaultKeybind = "G",
                Unlocked = true,
                DisplayName = "Void Roller",
                Description = "Mxitz Description"
            },
            ["Chaos Blast"] = {
                DefaultKeybind = "H",
                Unlocked = true,
                DisplayName = "Void Burst",
                Description = "Nub Description"
            },
            ["Shadow Heal"] = {
                DefaultKeybind = "H+",
                Unlocked = true,
                DisplayName = "Dark Renewal",
                Description = "Ran out of Scripters Description"
            },
            Jackpot = {
                DefaultKeybind = "Y",
                Unlocked = true,
                Description = "Hzl Description"
            },
            ["Super Shadow"] = {
                DefaultKeybind = "U",
                Unlocked = true,
                DisplayName = "\"Behold, True Power\"",
                Description = "Byeee Description"
            },
            ["Propulsion Kick"] = {
                DefaultKeybind = "B",
                Unlocked = true,
                Description = "Ran out of Scripters Description 2"
            },
            Timestop = {
                DefaultKeybind = "J",
                Unlocked = true,
                DisplayName = "Reality Fracture",
                Description = "Davodio Description"
            },
            Barrier = {
                DefaultKeybind = "V+",
                State = "Super",
                Unlocked = true,
                Description = "Ran out of Scripters Description 4"
            }
        }
    },
    Stats = v6.Stats,
    Animations = {
        Action = {
            ["LMB-1"] = 76138417823314,
            ["LMB-2"] = 85668529347312,
            ["LMB-3"] = 72546807675196,
            ["LMB-4"] = 93686561933043,
            Grab = 13931952917,
            Throw = 13931954655,
            ThrowVictim = 13931956115,
            ["Dark Rush"] = 128714407506984,
            ["Infused Punch"] = 128229276303329,
            ["Chaos Control"] = 104674486291386,
            ["Chaos Blast"] = 137152671902825,
            ["Chaos Spear Startup"] = 134554901475474,
            ["Chaos Spear Loop"] = 127268863266329,
            ["Chaos Spear Fire"] = 99262969209210,
            ["Chaos Rift Startup"] = 80672664839109,
            ["Chaos Rift Loop"] = 87778325550971,
            ["Chaos Rift End"] = 86742050088707,
            ["Spindash Startup"] = 120943311327093,
            ["Spindash Loop"] = 73974966537103,
            ["Spindash End"] = 132049405822596,
            ["Homing Attack Startup"] = 75845618331016,
            ["Homing Attack Loop"] = 119528936972823,
            ["Homing Attack End"] = 138100158780309,
            ["Propulsion Kick Ground"] = 126163217942954,
            ["Propulsion Kick Startup"] = 134903618632884,
            ["Propulsion Kick Loop"] = 103247583184892,
            ["Propulsion Kick End"] = 102003208365401,
            ["Shadow Heal Startup"] = 90262712830754,
            ["Shadow Heal Loop"] = 130986454995550,
            PoseTransition = 76790260968813,
            PoseIdle = 99514970647087
        },
        Movement = {
            Walk = 77437751820784,
            Run = 113312286173738
        },
        Idle = {
            Idle = 77592304609737
        }
    },
    Sounds = {
        SwingLMB = {
            SoundId = 77986091718211,
            Volume = 2
        },
        ["Homing Attack Voiceline"] = {
            SoundId = 132615987497420,
            Volume = 2
        },
        ["Chaos Control Voiceline"] = {
            SoundId = 136634088752240,
            Volume = 2
        },
        ["Chaos Control Stop"] = {
            SoundId = 86903330503550,
            Volume = 10,
            SoundEffects = {
                DistortionSoundEffect = {
                    Level = 0.5
                }
            }
        },
        ["Chaos Control Resume"] = {
            SoundId = 101493591512049,
            Volume = 10,
            SoundEffects = {
                DistortionSoundEffect = {
                    Level = 0.5
                }
            }
        },
        TeleportSFX = {
            SoundId = 200633492,
            Volume = 1
        },
        ["Jackpot Shoot"] = {
            SoundId = 4580856203,
            Volume = 2
        },
        ["Super Shadow Music"] = {
            SoundId = 129066641306205,
            Volume = 1.5,
            Looped = true,
            PlaybackSpeed = 1.6666666666666667,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(25, 600000),
            LoopRegion = NumberRange.new(29.423333333333336, 600000)
        },
        ["Chaos Mode Music"] = {
            SoundId = 93027673258361,
            Volume = 1.5,
            PlaybackSpeed = 1.6666666666666667,
            Looped = true
        },
        RingLoss = {
            SoundId = 8512779051,
            Volume = 1
        },
        ["PoseMusic-1"] = {
            SoundId = 129066641306205,
            Volume = 3,
            PlaybackSpeed = 1.6666666666666667,
            Looped = true
        },
        ["PoseMusic-2"] = {
            SoundId = 93027673258361,
            Volume = 3,
            PlaybackSpeed = 1.6666666666666667,
            Looped = true
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = false
            }
        },
        Quotes = {
            Universal = {}
        }
    },
    Resources = v5
};