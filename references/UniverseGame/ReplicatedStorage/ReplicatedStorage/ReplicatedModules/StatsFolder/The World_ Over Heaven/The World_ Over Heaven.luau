  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
local _ = workspace.CurrentCamera;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local _ = ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
Knit.OnStart():await();
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local u1 = Knit.GetService("EffectService");
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Global/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Global/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Cataclysmic_Throw/Global/Hit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v7 = {
    Summon = {
        From = "Combat.Summon",
        LeaveParts = { "StandHumanoidRootPart" },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 153, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(89, 0, 153)) })
    },
    ["Rush Attack"] = {
        From = "Combat.Rush Attack",
        Actionable = {
            Summoned = false
        },
        AnimationTimed = true,
        MaxCombo = 4,
        ComboTick = 1.5,
        ["LMB-1"] = TableUtil.Reconcile({
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 10, 15, "Attack" }, { 19, "End" } },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 11499501562,
                    Volume = 3
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 10, 15, "Attack" }, { 19, "End" } },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 11499501218,
                    Volume = 3
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher),
        Callbacks = {
            StateChecker = function(p5, p6) -- Line: 141, Name: StateChecker
                -- upvalues: CollectionService (copy), TableUtil (copy)
                local Stats = p5.Stats;

                if not CollectionService:HasTag(p5.Character, "Summoned") then
                    Stats = TableUtil.Copy(Stats, true);
                    Stats.CustomPrefix = "StandOff-LMB";
                end;

                return Stats;
            end
        }
    }
};
v7["Rush Attack"] = TableUtil.Reconcile(v7["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v7.Barrage = TableUtil.Reconcile({
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v2 },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    Finisher = {
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v7["Round Kick"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.15
    },
    Ragdoll = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 10961623819,
            Volume = 6
        }
    },
    HitRemotes = { v3 }
};
v7["Heavy Punch"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 6,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 10983670277,
            Volume = 5
        }
    },
    HitRemotes = { v3 }
};
v7["Behind and Above"] = {
    EndLength = 3,
    MaxCharge = 4,
    ChargeInterval = 0.285,
    LightningInterval = 0.15,
    Active = true,
    Damage = 35,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 1,
        Override = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.15,
        Velocity = Vector3.new(0, 25, 0)
    }
};
v7.Mangle = {
    Active = true,
    CheckPVPSafe = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 13.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.15,
        Velocity = Vector3.new(0, 35, 0)
    },
    Ragdoll = {
        Time = 1.25
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Mangle"
        } },
    HitSounds = {
        Hit = {
            SoundId = 11006507802,
            Volume = 5
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Mangle/Mangle Hit",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } }
};
v7["Cataclysmic Throw"] = {
    ProjectileCount = 12,
    Range = 50,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Active = true,
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Projectile = {
        Distance = 5,
        Damage = 2.5,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 11274583086,
                Volume = 1
            }
        },
        HitRemotes = { v4 }
    }
};
v7["Rampage Force"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Active = true,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Startup = {
        Damage = 5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8.5, 8.5, 8.5),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.25)
        },
        Block = {
            Blockable = false
        },
        Stun = {
            Time = 0.25
        },
        HitRemotes = { v2 }
    },
    Lightning = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false
        },
        HitRemotes = { v2 }
    },
    Hit = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false
        },
        HitRemotes = { v2 }
    },
    Finisher = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false
        },
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 35, 0)
        },
        Ragdoll = {
            Time = 0.75
        },
        HitRemotes = { v3 }
    }
};
v7.Fissure = {
    StartDistance = 1.5,
    Distance = 12,
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Hitbox = {
        Size = Vector3.new(8.5, 8.5, 8.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Cooldown = {
        Time = 16.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 1.1,
        Priority = Enums.Stun.Medium
    },
    HitSounds = {
        Hit = {
            SoundId = 11246343544,
            Volume = 5
        }
    },
    HitRemotes = { v3 }
};
v7.Timestop = {
    Speed = 0.7,
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false,
        CanTimestop = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "PlaySound", "Timestop Voice" }, { 0, "PlaySound", "Timestop Woosh" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 42, "Timestop" }, { 72, "End" } },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 4.5,
        Size = 150,
        StopSounds = { "Timestop SFX" },
        ResumeSounds = { "Timestop Resume" }
    },
    Callbacks = {
        TSTransformer = function(p8) -- Line: 672, Name: TSTransformer
            -- upvalues: TagService (copy), TableUtil (copy)
            if TagService:Get(TagService:GetContainer(p8.Character), "Overwrite Infusion") then
                p8 = TableUtil.Copy(p8, true);
                p8.OverHeaven = true;
                p8.Time = p8.Time + 1;
            end;

            return p8;
        end
    }
};
v7["Timestop Movement"] = {
    From = "Combat.Timestop Movement"
};
v7["Immortal Strikes"] = {
    Duration = 0.8,
    Distance = 25,
    Amount = 20,
    Meter = {
        RequiredLevel = 3,
        MeterGain = 0
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false,
        Timestopped = true
    },
    Active = true,
    Cooldown = {
        Time = 45,
        AfterMove = true
    },
    Dash = {
        CheckPVPSafe = true,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.5, 7.5, 7.5),
            Debug = false,
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4.25)
        },
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 1.5
        }
    },
    Projectile = {
        Damage = 80,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 35, 0)
        },
        HitRemotes = { v4 }
    }
};
v7["Divine Thunder"] = {
    Active = true,
    Damage = 42.5,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Stun = {
        Time = 0.45,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.15,
        Velocity = Vector3.new(0, 25, 0)
    },
    Ragdoll = {
        Time = 1.5
    }
};
v7["Overwrite Infusion"] = {
    Length = 30,
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v7["Divine Retribution"] = {
    Actionable = {
        Active = true,
        MasteryRank = 3
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0
    },
    Barrage = {
        Damage = 4,
        Meter = {
            MeterGain = 0
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 2.5,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 5.5, 13),
            Offset = CFrame.new(0, 0, -6.5)
        },
        HitRemotes = { v2 },
        HitSounds = {
            Hit = {
                SoundId = 11460843063,
                Volume = 1.5
            }
        }
    },
    Finisher = {
        Damage = 25,
        Meter = {
            MeterGain = 0
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 5, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 5.5, 14),
            Offset = CFrame.new(0, 0, -7)
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    },
    SelfHeal = {
        Heal = 25,
        Priority = Enums.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        }
    }
};
v7["Reality Overwrite"] = {
    Active = true,
    CheckPVPSafe = true,
    Damage = 65,
    TrueDamage = true,
    GoBeyond = true,
    InfinityBypass = true,
    IgnoreLoveTrain = true,
    Priority = Enums.Intangible.Move,
    Actionable = {
        Active = true,
        MasteryRank = 6,

        Check = function(p9) -- Line: 944, Name: Check
            -- upvalues: Players (copy), TagService (copy), UIOutput (copy)
            if p9:GetAttribute("Timestopped") then
                local v10 = Players:GetPlayerFromCharacter(p9);

                if not TagService:Get(TagService:GetContainer(p9), "Overwrite Infusion") then
                    if v10 then
                        UIOutput:FireClient(v10, "CreateMiddleNotification", {
                            NumericalContent = 1,
                            NumericalSuffix = "The World: Over Heaven",
                            Verb = "",
                            Subject = "Overwrite Infusion required to be used in Time Stop!"
                        });
                        UIOutput:FireClient(v10, "PlaySound", "ope_invalid_move");
                    end;

                    return false;
                end;
            end;

            return true;
        end
    },
    Cooldown = {
        Time = 38.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        MeterGain = 0
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.15,
        Velocity = Vector3.new(0, 2.5, 0)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        Unlockable = true,
        BypassCounter = true
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Overwritten"
        } },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6, 11),
        Offset = CFrame.new(0, 0, -5.5)
    },
    HitSounds = {
        Hit = {
            SoundId = 91350651127497,
            Volume = 2
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Reality Overwrite Hit",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    Detect = {
        MaxDistance = 45,
        Priority = Enums.Intangible.Move,
        Hitbox = {
            Type = "Magnitude",
            Size = 37.25
        }
    },
    CancelableCutscenes = { "\"I am atomic.\"", "Drums Of Liberation" }
};
v7.Teleport = {
    From = "Combat.Teleport"
};
v7.Block = {
    From = "Combat.Block"
};
v7.Quickstep = {
    From = "Combat.Quickstep"
};
v7.Grab = {
    From = "Combat.Grab",
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v7.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseEnd = function(p11, p12) -- Line: 1095, Name: PoseEnd
            -- upvalues: u1 (copy), EnableBirthmark (copy)
            local _ = p11.Stats;
            local _ = p11.Player;
            u1.FireAllClients("TWOH_POSE", p11.Character, false);
            EnableBirthmark(p11.Character, false);
        end,

        PoseTransition = function(p13, p14) -- Line: 1103, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy), u1 (copy)
            local _ = p13.Stats;
            local _ = p13.Player;
            local Character = p13.Character;
            EnableBirthmark(p13.Character, true);
            task.wait(0.75);
            u1.FireAllClients("TWOH_POSE", Character, true);
        end
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
            ["Round Kick"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Deliver a swift roundhouse kick."
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike."
            },
            ["Behind and Above"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Charge up while this move is held and then unleash thunder strikes forward, the amount of thunder strikes depends on how long the move was held."
            },
            ["Heavy Punch"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Unleash a heavy blow in front of you."
            },
            ["Cataclysmic Throw"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Summon multiple knives in front of you by overwriting reality before commanding them to rush forth.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Mangle = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Deliver a powerful uppercut as you overwrite reality, mangling your opponents bodily functions to greatly slow their movement.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Fissure = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Send forth your stand which delivers a swift shoulder bash and teleports you to any target hit.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Rampage Force"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Get your opponent in a chokehold as you slam them down with the assist of a lightning bolt, then proceed to pummel them into the ground before punching them away.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Divine Thunder"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Slam your stands fist into the ground as you call forth a massive thunder bolt to smite your target.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Immortal Strikes"] = {
                DefaultKeybind = "H",
                State = "StandOff",
                Description = "Dash forward with immense force to deliver a left hook, then proceed to throw your target into the air with the assist of your stand as you stop time to summon a knife barrage around your target.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Your stand briefly stops time in a radius.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleports you a short distance.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Overwrite Infusion"] = {
                DefaultKeybind = "B",
                Description = "Overwrite your bodily functions to greatly enhance your offensive and defensive capabilities for a duration.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "J",
                Description = "Gives you the ability to move during a timestop.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 575000
                    }
                }
            },
            ["Divine Retribution"] = {
                DefaultKeybind = "Z",
                Description = "Enter a vulnerable stance in which when hit, counter the attacker by kicking them with your stand and overwrite yourself to remove debuffs and some injuries.",
                LevelRequirement = 120,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Reality Overwrite"] = {
                DefaultKeybind = "T+",
                State = "StandOn",
                Description = "Slowly wind up a unblockable, divine & heavy hitting punch, which will heavily debuff unfortunate victims who come into contact with it. Pairing it with Overwrite Infusion will result in no slowdown during the usage of the move and an ugomatic teleport to a potential nearby target, once landed it will remove Overwrite Infusion\'s buffs.",
                LevelRequirement = 130,
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
            ["StandOff-LMB-1"] = 12483102391,
            ["StandOff-LMB-2"] = 12483106270,
            ["StandOff-LMB-3"] = 12483107424,
            ["StandOff-LMB-4"] = 12483108580,
            StandBlock = 10808688837,
            StandBlockHit1 = 10808692075,
            StandBlockHit2 = 10808695355,
            StandBlockHit3 = 10808697696,
            StandBlockBreak = 10808701329,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            Grab = 10906128504,
            Throw = 10906131878,
            ThrowVictim = 10906132668,
            ["Heavy Punch"] = 11386536360,
            ["Round Kick"] = 10953924145,
            ["Behind and Above Startup"] = 11386251961,
            ["Behind and Above Loop"] = 11386253322,
            ["Behind and Above End"] = 11386254583,
            Mangle = 10962400136,
            ["Rampage Force Startup"] = 11371960721,
            ["Rampage Force Success"] = 11371962866,
            ["Rampage Force Victim"] = 11371961601,
            ["Overwrite Infusion"] = 10983521106,
            ["Cataclysmic Throw"] = 11091663194,
            Fissure = 11109820411,
            ["Immortal Strikes Startup"] = 11308201056,
            ["Immortal Strikes Success"] = 11308205429,
            ["Immortal Strikes Victim"] = 11308204753,
            ["Immortal Strikes Camera"] = 11372387197,
            Timestop = 11274629341,
            ["Divine Thunder"] = 11274628314,
            ["Reality Overwrite"] = 93723623155399,
            ["Counter Startup"] = 74673599553004,
            ["Counter Hit"] = 133749999620466,
            PoseTransition = 13175462557,
            PoseIdle = 13175464138
        },
        Movement = {
            SummonedWalk = 10953884475,
            SummonedRun = 10953882774,
            Walk = 10953884475,
            Run = 10953882774
        },
        Idle = {
            SummonedIdle = 10953881155,
            Idle = 10953881155
        }
    },
    Stats = v7,
    Sounds = {
        MeterUp3 = {
            SoundId = 10940507113,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 10940500231,
            Volume = 2
        },
        Die = {
            SoundId = 7146792142,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KickVoice = {
            SoundId = 10961632259,
            Volume = 3
        },
        KickWindup = {
            SoundId = 10961622023,
            Volume = 2
        },
        Grab = {
            SoundId = 10961581608,
            Volume = 2
        },
        Grabbed = {
            SoundId = 10961580298,
            Volume = 3
        },
        ThrowVoiceline = {
            SoundId = 10961580766,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 6943345996,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = 6943345864,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = 6943346153,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = 6943345719,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = 6943345996,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = 6943345864,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = 6943346153,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = 6943345719,
            Volume = 2,
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
        ["SwingLMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 11499912997,
            Volume = 2
        },
        Barrage = {
            SoundId = 10983624911,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = 6946567992,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Behind and Above Startup"] = {
            SoundId = 11386977913,
            Volume = 2
        },
        ["Behind and Above Strike"] = {
            SoundId = 11386978531,
            Volume = 2
        },
        ["Heavy Punch Voice"] = {
            SoundId = 10983651204,
            Volume = 2
        },
        ["Heavy Punch Woosh"] = {
            SoundId = 10983654321,
            Volume = 2
        },
        ["Mangle Voice"] = {
            SoundId = 11006462196,
            Volume = 2
        },
        ["Mangle Woosh"] = {
            SoundId = 11006460926,
            Volume = 2
        },
        ["Rampage Force Startup"] = {
            SoundId = 11006542240,
            Volume = 2
        },
        ["Rampage Force Hit"] = {
            SoundId = 11006543979,
            Volume = 2
        },
        ["Fissure Woosh"] = {
            SoundId = 11239555422,
            Volume = 2
        },
        ["Fissure Voice"] = {
            SoundId = 11239555025,
            Volume = 2
        },
        ["Overwrite Infusion Woosh"] = {
            SoundId = 11239556417,
            Volume = 2
        },
        ["Overwrite Infusion Voice"] = {
            SoundId = 11239557084,
            Volume = 2
        },
        ["Cataclysmic Throw Woosh"] = {
            SoundId = 11274583948,
            Volume = 2
        },
        ["Cataclysmic Throw Voice"] = {
            SoundId = 11380612884,
            Volume = 2
        },
        ["Divine Thunder Voice"] = {
            SoundId = 11274834315,
            Volume = 2
        },
        ["Divine Thunder Woosh"] = {
            SoundId = 11274833755,
            Volume = 2
        },
        ["Immortal Strikes Voice"] = {
            SoundId = 11372977425,
            Volume = 2
        },
        ["Immortal Strikes Woosh"] = {
            SoundId = 11372978307,
            Volume = 2
        },
        ["Immortal Strikes Cutscene Voice"] = {
            SoundId = 11372981519,
            Volume = 2
        },
        ["Immortal Strikes Cutscene Woosh"] = {
            SoundId = 11372979591,
            Volume = 2
        },
        ["Rampage Force Voice"] = {
            SoundId = 11379838207,
            Volume = 2
        },
        ["Rampage Force Woosh"] = {
            SoundId = 11379836815,
            Volume = 2
        },
        ["Rampage Force Grab Voice"] = {
            SoundId = 11379840397,
            Volume = 2
        },
        ["Rampage Force Grab Woosh"] = {
            SoundId = 11379839393,
            Volume = 2
        },
        Teleport = {
            SoundId = 11385947307,
            Volume = 2
        },
        ["Timestop Voice"] = {
            SoundId = 11385941429,
            Volume = 2
        },
        ["Timestop Woosh"] = {
            SoundId = 11385941831,
            Volume = 2
        },
        ["Timestop Resume"] = {
            SoundId = 11385940175,
            Volume = 2
        },
        Explosion = {
            SoundId = 11453199824,
            Volume = 2
        },
        SummonSound = {
            SoundId = 11499518534,
            Volume = 2
        },
        SummonEffects = {
            SoundId = 11499517575,
            Volume = 2
        },
        Desummon = {
            SoundId = 11499517901,
            Volume = 2
        },
        DesummonVoiceline = {
            SoundId = 11499519197,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 13176855703,
            Volume = 3
        },
        ["Divine Retribution Startup"] = {
            SoundId = 112005823934655,
            Volume = 2
        },
        ["Divine Retribution Startup Voice"] = {
            SoundId = 100897811114091,
            Volume = 2
        },
        ["Divine Retribution"] = {
            SoundId = 83684897553543,
            Volume = 2
        },
        ["Divine Retribution Voice"] = {
            SoundId = 104066284628661,
            Volume = 2
        },
        ["Reality Overwrite"] = {
            SoundId = 118985947768721,
            Volume = 2
        },
        ["Reality Overwrite Voice"] = {
            SoundId = 109717960052969,
            Volume = 2
        },
        ["Death-Voiceline"] = {
            SoundId = 106097360215446,
            Volume = 3
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
                    SoundId = "rbxassetid://6943346557",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My hands are that which create truth!"
                        } }
                }, {
                    SoundId = "rbxassetid://6943347162",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "We\'ll see whose truth reigns supreme!"
                        } }
                }, {
                    SoundId = "rbxassetid://6943346932",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll end your life myself."
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p15) -- Line: 1827, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p15.Player;
            local Character = p15.Character;
            local SkinName = p15.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v16 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "The World: Over Heaven",
                SkinName = SkinName
            });
            v16.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v16;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    },
    MasteryData = {
        MaxMasteryRank = 6,

        PointCap = function(p17) -- Line: 1854, Name: PointCap
            return 1;
        end
    }
};