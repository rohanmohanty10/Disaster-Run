  

 

game:GetService("RunService");
game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local EnumsModule = require(PathShortcuts.EnumsModule);
local TableUtil = require(Knit.Util.TableUtil);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local _ = game.ReplicatedStorage.Remotes.Output;
local u1;

if game:GetService("RunService"):IsServer() then
    u1 = require(game.ServerScriptService.ServerLibrary.AbilityMoves.Stands["Weather Report"].WeatherElements);
else
    u1 = nil;
end;

local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 23
    -- upvalues: u2 (ref), Knit (copy)
    u2 = Knit.GetService("TagService");
end);
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V2", "__Legacy", {
            ParticleName = "WRWindeffect",
            LookAt = "Attacker"
        } }
};
local v4 = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        ParticleName = "WeatherReportHitEffect",
        LookAt = "Attacker",
        AutoSerialize = true
    } };
local v9 = {
    Summon = {
        From = "Combat.Summon",
        SummonV2 = true,
        LeaveParts = { "StandHumanoidRootPart" },
        SummonParticle = {
            ParticleName = "WRSummon",
            PartName = "SummonParticle"
        },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 222, 255)) })
    },
    Pose = {
        From = "Combat.Pose",
        MusicAmount = 4,
        Callbacks = {
            PoseTransition = function(p5, p6) -- Line: 84, Name: PoseTransition
                -- upvalues: EnableBirthmark (copy)
                EnableBirthmark(p5.Character, true);
            end,

            PoseEnd = function(p7, p8) -- Line: 87, Name: PoseEnd
                -- upvalues: EnableBirthmark (copy)
                EnableBirthmark(p7.Character, false);
            end
        }
    },
    Grab = {
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
    },
    Block = {
        From = "Combat.Block"
    },
    Quickstep = {
        From = "Combat.Quickstep"
    },
    ["Rush Attack"] = TableUtil.Reconcile({
        From = "Combat.Rush Attack",
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        MaxCombo = 4,
        Endlag = 0.2,
        ComboTick = 1.5,
        ["LMB-3"] = {
            HitSounds = {
                Hit = {
                    SoundId = 10193014837,
                    Volume = 3
                }
            }
        },
        ["LMB-4"] = TableUtil.Reconcile({
            Sequence = { { 0, "PlayAnim" }, { 0, "PlaySound" }, { 0, "PlayVoiceline" }, { 0, "CreateTag", "NoRun" }, { 20, "Attack" }, { 25, "End" } },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 64,
                Time = 0.2
            },
            HitSounds = {
                Hit = {
                    SoundId = 10193015843,
                    Volume = 5
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher),
        Sequence = { { 0, "PlayAnim" }, { 0, "PlaySound" }, { 0, "PlayVoiceline" }, { 0, "CreateTag", "NoRun" }, { 15, "Attack" }, { 25, "End" } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        HitAnimations = "Default",
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 10193014202,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack)
};
v9["Rush Attack"] = TableUtil.Reconcile(v9["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v9["Triple Air Cleave"] = {
    Active = true,
    Damage = 8,
    Cooldown = 15,
    Element = "Wind",
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.8,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 10324383011,
            Volume = 3
        }
    },
    Texture1 = {
        frames = 15,
        fps = 60,
        rows = 3,
        columns = 5,
        front = "http://www.roblox.com/asset/?id=7943227207",
        back = "http://www.roblox.com/asset/?id=7945726042",
        size = Vector3.new(12, 12, 0),
        color = Color3.new(1, 1, 1),
        part = game.ReplicatedStorage["Client Assets"].Misc.slash
    }
};
v9["Shock Barrage"] = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Hit = {
        Element = "Lightning",
        HitAnimations = "Default",
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13159475338,
                Volume = 1.5
            }
        }
    },
    Finisher = {
        Element = "Lightning",
        HitAnimations = "Default",
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13159474987,
                Volume = 2
            }
        }
    },
    ClashHit = {
        Element = "Lightning",
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
        Element = "Lightning",
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v9["Flare Ring"] = {
    Active = true,
    Damage = 15,
    Cooldown = 15,
    BurnHits = 5,
    Element = "Fire",
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Ragdoll = {
        Time = 1.5
    },
    BurnHit = {
        Damage = 5,
        Element = "Fire",
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 20, 20),
            Debug = false,
            Offset = CFrame.identity
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(20, 20, 20),
        Debug = false,
        Offset = CFrame.new(0, 0, -10)
    },
    Block = {
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Time = 0.2,
        Velocity = Vector3.new(0, 40, 0)
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 10324390027,
            Volume = 3
        }
    }
};
v9["Combustive Heatwave"] = {
    Active = true,
    Damage = 20,
    Element = "Fire",
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.6,
        Priority = EnumsModule.Stun.Medium
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        BlockBreak = true,
        PerfectBlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Time = 0.2
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "DawnBurn"
        } },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 8965811167,
            Volume = 3
        }
    }
};
v9["Air Bomb"] = {
    Active = true,
    Damage = 15,
    Cooldown = 15,
    Element = "Wind",
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(35, 35, 35),
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    },
    Meter = {
        RequiredLevel = 1
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 10344753534,
            Volume = 3
        }
    }
};
v9["Air Bullets"] = {
    Active = true,
    Damage = 2,
    Cooldown = 15,
    Distance = 5,
    BulletCount = 15,
    Element = "Wind",
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    HitRemotes = { v3 },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 10344753534,
            Volume = 3
        }
    }
};
v9["Ice Breath"] = {
    Active = true,
    Damage = 2,
    Cooldown = 15,
    BreathHits = 12,
    Element = "Water",
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 15),
        Debug = false,
        Offset = CFrame.new(0, 0, -7.5)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    ParticleName = "WRIceBreath",
                    LookAt = "Attacker",
                    AutoSerialize = true
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 10324392366,
            Volume = 3
        }
    }
};
v9["Lung Exhaustion"] = {
    Active = true,
    Damage = 25,
    Element = "Wind",
    Cooldown = 19.5,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 2,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitAnimations = { 10046328617 },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    ParticleName = "LungExhaustion",
                    LookAt = "Attacker",
                    AutoSerialize = true
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 10193054534,
            Volume = 3
        }
    }
};
v9["Blood Oxidation"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    TickDamage = {
        Damage = 5,
        Element = "Wind",
        Priority = EnumsModule.Intangible.Move + 1,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    FinalBlow = {
        Damage = 17.5,
        Element = "Wind",
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move + 1,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.2
        },
        Ragdoll = {
            Time = 1
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        ParticleName = "BloodOxHit",
                        LookAt = "Attacker",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10324404248,
                Volume = 3
            }
        }
    }
};
v9["Lightning Strike"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = 60,
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    },
    Attempt = {
        Distance = 20,
        Duration = 0.8,
        Damage = 1,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move + 1,
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8.5, 8.5, 9),
            Tolerance = 3,
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        }
    },
    ["Aerial Attack"] = {
        Damage = 5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move + 1,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        ParticleName = "WRBlackHiteffect",
                        LookAt = "Attacker",
                        AutoSerialize = true
                    } }
            } }
    },
    Lightning = {
        Damage = 60,
        Priority = EnumsModule.Intangible.Move + 1,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Ragdoll = {
            Time = 2.25
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Speed = 50,
                Time = 0.2
            } }
    }
};
v9["Devils Rainbow"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = 120,
    Meter = {
        RequiredAmount = 50
    },
    RainbowHitbox = {
        CheckPVPSafe = true,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    }
};
v9["Cloud Suit"] = {
    Active = true,
    Cooldown = 45,
    Duration = 20,
    SuitHealth = 75,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    }
};
v9["Heavy Weather"] = {
    Active = true,
    Duration = 120,
    Actionable = {
        Active = true,

        Check = function(p10, p11) -- Line: 762, Name: Check
            return not p10:GetAttribute("HeavyWeather");
        end
    },
    Cooldown = {
        Time = 60,
        Manual = true
    },
    Meter = {
        RequiredAmount = 75
    }
};
v9["Thousand Volt Plexus"] = {
    Actionable = {
        Active = true,
        Summoned = true
    },
    Active = true,
    Cooldown = 15,
    ["Solar Plexus Hit"] = {
        Damage = 5,
        Element = "Lightning",
        HitAnimations = "Default",
        Stun = {
            Time = 0.5,
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
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = true
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 8963473542,
                Volume = 3
            }
        }
    },
    ["Lightning Explosion"] = {
        Damage = 25,
        Element = "Lightning",
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.2
        },
        Ragdoll = {
            Time = 0.75
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Debug = false,
            Offset = CFrame.new(0, 0, -7.5)
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = v4
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 8963473542,
                Volume = 3
            }
        }
    }
};
v9["Winds of Destruction"] = {
    Actionable = {
        Active = true,
        Summoned = true
    },
    Active = true,
    Damage = 1,
    Cooldown = 20,
    ChargeLevels = 3,
    Element = "Wind",
    Meter = {
        Amount = 0,
        RequiredAmount = 30
    },
    Block = {
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Debug = false,
        Offset = CFrame.new()
    },
    ["Cloud Projectile"] = {
        Damage = 15,
        Distance = 10,
        Element = "Wind",
        Piercing = true,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8963473542,
                Volume = 3
            }
        }
    },
    HitAnimations = "Default",
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 8963473542,
            Volume = 3
        }
    }
};
v9["Wind Counter"] = {
    Active = true,
    Damage = 30,
    Cooldown = 20,
    Element = "Wind",
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        Amount = 0,
        RequiredAmount = 30
    },
    Stun = {
        Time = 0.8,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Velocity = Vector3.new(0, 50, 0),
        Time = 0.5
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(25, 15, 25),
        Debug = false,
        Offset = CFrame.new()
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 10344748829,
            Volume = 3
        }
    }
};
v9["Frog Rain"] = {
    Active = true,
    Damage = 5,
    Cooldown = 25,
    FrogHits = 7,
    Element = "Water",
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        StandOff = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Block = {
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(40, 40, 40),
        Debug = false,
        Offset = CFrame.new()
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    ParticleName = "WRWindeffect",
                    LookAt = "Attacker",
                    AutoSerialize = true
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 6347848620,
            Volume = 3
        }
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Passive = {
                Visible = true,
                Priority = 5
            },
            Universal = {
                Visible = true,
                Priority = 4
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
            },
            HeavyWeather = {
                Visible = false,
                Priority = 3
            }
        },
        MovesInfo = {
            ["Elemental Combinations"] = {
                State = "Passive",
                Description = "These can only activate when in heavy weather\nWater + Wind = Stuns the target and target deals less damage.\nWater + Lightning = Electrocute and target has increased cooldowns.\nFire + Lightning = Block break and target takes increased damage.\nFire + Wind = Deal burn damage and reduced healing.",
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
            ["Triple Air Cleave"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "(Air) Use your stands arm to summon three air slices in front of you, damaging anyone caught within them."
            },
            ["Shock Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "(Lightning) Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike."
            },
            ["Flare Ring"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "(Fire) Quickly summon your stand which releases a fiery explosion, causing a wide radius on the ground to get set on fire."
            },
            ["Combustive Heatwave"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "(Fire) Swiftly perform a heavy punch causing the target to get set on fire while also knocking them back in the process."
            },
            ["Ice Breath"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "(Water) You exhale cold air for a few seconds, causing your target to get slowed down.",
                LevelRequirement = 30,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Lung Exhaustion"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "(Air) Perform a swift low blow to the Lung causing the stored air to get released, leaving the target incapacitated for a few seconds.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Air Bomb"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                Description = "(Air) Swiftly dash back while releasing an air bomb, causing anyone in the radius to get pulled in once it explodes.",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Air Bullets"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "(Air) Quickly unleash a volley of bullets made out of Air at your target",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Blood Oxidation"] = {
                DefaultKeybind = "B",
                State = "StandOff",
                Description = "(Air) You grab your target with immense pressure, causing them to bleed before punching them in the gut.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Lightning Strike"] = {
                DefaultKeybind = "B",
                State = "StandOn",
                Description = "(Lightning) Quickly dash forward to grab your target to unleash a fierce beatdown, before smiting them with a giant lightning bolt.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Devils Rainbow"] = {
                DefaultKeybind = "B",
                State = "HeavyWeather",
                Description = "Summon multiple rainbows that follow you around, causing anyone caught in the rainbow to turn into a snail for a few seconds.",
                LevelRequirement = 80,
                Cost = {
                    AscensionRank = 10,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Thousand Volt Plexus"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "(Lightning) Release electricity out of your stands arm, causing the target to get electrocuted and ultimately knocked back with a second electrical strike.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Winds of Destruction"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "(Air) Charge up an air sphere before ultimately releasing it up front, piercing anyone it makes contact with. Holding the move down releases a bigger air sphere covering a larger radius.",
                LevelRequirement = 70,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Frog Rain"] = {
                DefaultKeybind = "U",
                State = "StandOff",
                Description = "(Water) Cause a strange phenomenon which sends down poisonous frogs from the sky, dealing damage to those that get touched by the frogs.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Wind Counter"] = {
                DefaultKeybind = "V",
                State = "Universal",
                Description = "(Air) Quickly strike a pose which lets you counter any incoming attack by sending your target high in the air.",
                LevelRequirement = 65,
                Cost = {
                    AscensionRank = 3,
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Cloud Suit"] = {
                DefaultKeybind = "Z",
                State = "Universal",
                Description = "Cover yourself in a suit made out of clouds, boosting your jump height as well as reducing the damage of any incoming attack.",
                LevelRequirement = 90,
                Cost = {
                    AscensionRank = 5,
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Heavy Weather"] = {
                DefaultKeybind = "J",
                State = "Universal",
                Description = "Enter a state which gives you the power of various different elements. Combining these gives you unique outcomes and debuffs to your targets.",
                LevelRequirement = 105,
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
        Action3 = {
            SummonedForwardDash = 10451361960,
            SummonedBackwardDash = 10451359576,
            SummonedLeftDash = 10451363828,
            SummonedRightDash = 10451365211
        },
        Action = {
            ["LMB-1"] = 8990260713,
            ["LMB-2"] = 9481245541,
            ["LMB-3"] = 9481223928,
            ["LMB-4"] = 9481253071,
            ["Triple Air Cleave"] = 10203308028,
            BarrageStartup = 11064727600,
            Barrage = 11064717857,
            BarrageFinisher = 11064723359,
            BarrageClashEnd = 10839831781,
            ["Combustive Heatwave"] = 8963181689,
            ["Flare Ring"] = 10274186243,
            ["Lightning Strike Startup"] = 8990112524,
            ["Lightning Strike Hit"] = 8991485074,
            ["Lightning Strike Victim"] = 8991482812,
            ["Lightning Strike Camera"] = 8991499930,
            ["Devils Rainbow"] = 9492396219,
            ["Jet Airplane"] = 9492411353,
            ["Cloud Suit"] = 9492540658,
            ["Heavy Weather"] = 9492525212,
            ["Heavy Weather Clouds"] = 10368167035,
            ["Default Clouds"] = 10368210454,
            ["Thousand Volt Plexus"] = 10023924348,
            ["Ice Breath"] = 10274178015,
            ["Lung Exhaustion"] = 10046319500,
            ["Lung Victim"] = 10046328617,
            ["WOD Uncharged"] = 10062966645,
            ["WOD Startup"] = 10062947046,
            ["WOD Charging"] = 10062954336,
            ["WOD Finisher"] = 10064922298,
            ["Frog Transition"] = 6350085587,
            ["Counter Startup"] = 10129780091,
            ["Counter Loop"] = 10129784508,
            ["Oxidation Startup"] = 10158381439,
            ["Blood Oxidation"] = 10158384930,
            ["Oxidation Victim"] = 10158471514,
            ["Air Bomb"] = 10235539523,
            ["Air Bullets Startup"] = 10173994074,
            ["Air Bullets Loop"] = 10173996202,
            PoseStart = 10367157472,
            PoseLoop = 10367160860
        },
        Movement = {
            Run = 7037969480,
            Walk = 6707573199,
            SummonedRun = 7037969480,
            SummonedWalk = 6707573199
        },
        Idle = {
            SummonedIdle = 8933510017,
            Idle = 8933602062
        }
    },
    Stats = v9,
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = "rbxassetid://10217315340",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["PoseMusic-2"] = {
            SoundId = "rbxassetid://10529320733",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["PoseMusic-3"] = {
            SoundId = "rbxassetid://80612369163829",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["PoseMusic-4"] = {
            SoundId = 116949249706092,
            Volume = 2.5,
            PlaybackSpeed = 1.6528925619834711,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(103.79173553719008, 600000)
        },
        SummonSound = {
            SoundId = "rbxassetid://10344744091",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://10344744588",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://13159281428",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://13159475746",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://13159290286",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StainsOfTime = {
            SoundId = "rbxassetid://9893964327",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        FrogRain = {
            SoundId = "rbxassetid://10324397195",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FrogRainQuote = {
            SoundId = "rbxassetid://13186678973",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LS-Voiceline"] = {
            SoundId = "rbxassetid://13159584962",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LS-SFX"] = {
            SoundId = "rbxassetid://10088743724",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LS-StartupVoice"] = {
            SoundId = "rbxassetid://13159470459",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LS-StartupSFX"] = {
            SoundId = "rbxassetid://10088744453",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://10189727407",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://10189727854",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://10189728400",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://10189729098",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://13159284304",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://13159285165",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://13159285934",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://13159286676",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeterUp2 = {
            SoundId = 13159708682,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13159709274,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://13159284304",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://13159285165",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://13159285934",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://13159286676",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LungExhaustion = {
            SoundId = "rbxassetid://10193055437",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LungExhaustion-Voiceline"] = {
            SoundId = "rbxassetid://13186722376",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        AirBullet = {
            SoundId = "rbxassetid://10193061651",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["AirBullet-Voiceline"] = {
            SoundId = "rbxassetid://13159560382",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["AirBullet-Summon"] = {
            SoundId = "rbxassetid://10193060924",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["AirBullet-Shoot"] = {
            SoundId = "rbxassetid://10193063058",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WindCounter = {
            SoundId = "rbxassetid://10202413654",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WOD-Voiceline"] = {
            SoundId = "rbxassetid://13186761367",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WOD-Charging"] = {
            SoundId = "rbxassetid://10202415173",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WOD-Shoot"] = {
            SoundId = "rbxassetid://10202416839",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WOD-Shoot-Voiceline"] = {
            SoundId = "rbxassetid://13186759883",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WOD-Tap"] = {
            SoundId = "rbxassetid://10354552143",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WOD-TapShoot"] = {
            SoundId = "rbxassetid://10354551355",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["CloudSuit-Voiceline"] = {
            SoundId = "rbxassetid://13186680583",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["CloudSuit-Equip"] = {
            SoundId = "rbxassetid://10202422421",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["CloudSuit-Unequip"] = {
            SoundId = "rbxassetid://10202423433",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["HeavyWeather-SFX"] = {
            SoundId = "rbxassetid://10235982618",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["HeavyWeather-Voiceline"] = {
            SoundId = "rbxassetid://13186751454",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["HeavyWeather-End"] = {
            SoundId = "rbxassetid://10235984194",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["HeavyWeather-Loop"] = {
            SoundId = "rbxassetid://10235985158",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["HeavyWeather-Music"] = {
            SoundId = "rbxassetid://10217315340",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["DevilsRainbow-SFX"] = {
            SoundId = "rbxassetid://10235999579",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["DevilsRainbow-Voiceline"] = {
            SoundId = "rbxassetid://13186759314",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["DevilsRainbow-RainbowSpawn"] = {
            SoundId = "rbxassetid://10235998367",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["DevilsRainbow-SnailHit"] = {
            SoundId = "rbxassetid://10235995617",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["DevilsRainbow-SnailEnd"] = {
            SoundId = "rbxassetid://10236000132",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Burn-Combination"] = {
            SoundId = "rbxassetid://10236015153",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Explode-Combination"] = {
            SoundId = "rbxassetid://10236016472",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Freeze-Combination"] = {
            SoundId = "rbxassetid://10249342744",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Shock-Combination"] = {
            SoundId = "rbxassetid://10249344017",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Wind-Element"] = {
            SoundId = "rbxassetid://10236018448",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["Fire-Element"] = {
            SoundId = "rbxassetid://10236019818",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["Lightning-Element"] = {
            SoundId = "rbxassetid://10236019206",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["Water-Element"] = {
            SoundId = "rbxassetid://10249343520",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        TripleAirCleave = {
            SoundId = "rbxassetid://10324384019",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FlareRing-SFX"] = {
            SoundId = "rbxassetid://10324389652",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FlareRing-Voiceline"] = {
            SoundId = "rbxassetid://13159473876",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FlareRing-Explosion"] = {
            SoundId = "rbxassetid://10324388084",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["IceBreath-SFX"] = {
            SoundId = "rbxassetid://10324391703",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["AirBomb-Voiceline"] = {
            SoundId = "rbxassetid://13159583272",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["BloodOxidation-GrabAttempt"] = {
            SoundId = "rbxassetid://10324403647",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["BloodOxidation-SFX"] = {
            SoundId = "rbxassetid://10324402476",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["BloodOxidation-Voiceline"] = {
            SoundId = "rbxassetid://13159471344",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WindCounter-SFX"] = {
            SoundId = "rbxassetid://10344749427",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["WindCounter-Voiceline"] = {
            SoundId = "rbxassetid://13159611708",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GDashBeginning = {
            SoundId = 10088744453,
            Volume = 1.5
        },
        GSequence = {
            SoundId = 10088743724,
            Volume = 1.5
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
                    SoundId = "rbxassetid://13159556893",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Get away from me. I\'ll kick you to death"
                        } }
                }, {
                    SoundId = "rbxassetid://13159557407",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You... are the worst form of evil. An evil that doesn\'t know it\'s evil!"
                        } }
                }, {
                    SoundId = "rbxassetid://13159558147",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Gehahaha! Now that\'s great! I\'ll get more from you. Let\'s go!"
                        } }
                }, {
                    SoundId = "rbxassetid://13159559025",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What\'s wrong? Done already?"
                        } }
                } }
        }
    },
    Metadata = {
        AbilityOutbound = function(p12) -- Line: 1986, Name: AbilityOutbound
            -- upvalues: u1 (ref), u2 (ref), Knit (copy)
            local Attacker = p12.Attacker;
            local Target = p12.Target;

            if not p12.State.Success then
                return;
            end;

            if typeof(Attacker) ~= "Instance" or typeof(Target) ~= "Instance" then
                return;
            end;

            if Attacker:GetAttribute("HeavyWeather") and u1 then
                if not u2 then
                    u2 = Knit.GetService("TagService");
                end;

                u1.ApplyElement({
                    Target = Target,
                    TargetTags = u2:GetContainer(Target),
                    Attacker = Attacker
                }, p12.Stats.Element);

                return true;
            end;
        end,

        PostRig = function(p13) -- Line: 2007, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p13.Player;
            local Character = p13.Character;
            local SkinName = p13.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v14 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v14.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v14;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};