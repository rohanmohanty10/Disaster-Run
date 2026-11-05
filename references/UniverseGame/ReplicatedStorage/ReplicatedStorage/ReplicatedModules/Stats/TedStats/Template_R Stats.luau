  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
v1.Summon = {
    From = "Combat.Summon",
    Indicators = { {
            Group = "Universal",
            Name = "Summon",
            InputText = "%s",
            Visible = true
        } },
    LeaveParts = { "StandHumanoidRootPart", "StandOffKatana" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 208, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 129, 2)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "RUSH // ATTACK",
            ActiveName = "Rush Attack",
            CooldownName = "Rush Attack",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 29, 36, "Attack" }, { 38, "End" } },
        Stun = {
            Time = 0.625,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect V2",
                    "__Legacy",
                    {
                        AutoSerialize = true,
                        Particle = ClientAssets["P//S_R"]["PS Hit"]
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.45,
        Sequence = { { 0, "Start" }, { 40, 50, "Attack" }, { 55, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect V2",
                    "__Legacy",
                    {
                        AutoSerialize = true,
                        LookAt = "Attacker",
                        Particle = ClientAssets["P//S_R"]["PS Heavy"]
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 11713885288,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.1,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
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
            Size = Vector3.new(6, 5.5, 6),
            Debug = true,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect V2",
                    "__Legacy",
                    {
                        AutoSerialize = true,
                        Particle = ClientAssets["P//S_R"]["PS Hit"]
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        }
    },
    ["StandOff-LMB-2"] = {
        Speed = 1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } }
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
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect V2",
                    "__Legacy",
                    {
                        AutoSerialize = true,
                        LookAt = "Attacker",
                        Particle = ClientAssets["P//S_R"]["PS Heavy"]
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 11713885288,
                Volume = 2
            }
        }
    },
    Callbacks = {
        StateChecker = function(p2, p3) -- Line: 243, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p2.Stats;

            if not Knit.CollectionService:HasTag(p2.Character, "Summoned") then
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
v1.EMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOff",
            Name = "Hand Of Fortune",
            InputText = "%s",
            CooldownName = "STANDOFF-E",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Body Carving",
            ActiveName = "EMoves",
            CooldownName = "STANDON-E",
            InputText = "%s",
            Visible = true
        } },
    BodyCarving = {
        Cooldown = {
            Name = "STANDON-E",
            Time = 9
        }
    },
    HandOfFortune = {
        Cooldown = {
            Name = "STANDOFF-E",
            Time = 9
        }
    }
};
v1.RMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOff",
            Name = "Throat Incision",
            ActiveName = "RMoves",
            InputText = "%s",
            CooldownName = "STANDOFF-R",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Spilling Of Blood",
            ActiveName = "RMoves",
            CooldownName = "STANDON-R",
            InputText = "%s",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Severing Chokehold",
            ActiveName = "RMoves",
            CooldownName = "STANDON-R-HELD",
            InputText = "%s+",
            Visible = true
        } },
    ThroatIncision = {
        Cooldown = {
            Name = "STANDOFF-R",
            Time = 3
        }
    },
    SpillingOfBlood = {
        Cooldown = {
            Name = "STANDON-R",
            Time = 3
        }
    },
    SeveringChokehold = {
        Cooldown = {
            Name = "STANDON-R-HELD",
            Time = 3
        }
    }
};
v1.TMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOff",
            Name = "Head Bomb",
            ActiveName = "TMoves",
            InputText = "%s",
            CooldownName = "STANDOFF-T",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Presidential Leverage",
            ActiveName = "TMoves",
            CooldownName = "STANDON-T",
            InputText = "%s",
            Visible = true
        } },
    HeadBomb = {
        Cooldown = {
            Name = "STANDOFF-T",
            Time = 3
        }
    },
    PresidentialLeverage = {
        Cooldown = {
            Name = "STANDON-T",
            Time = 3
        }
    }
};
v1.YMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOff",
            Name = "Chop Strike",
            ActiveName = "YMoves",
            InputText = "%s",
            CooldownName = "STANDOFF-Y",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "State Funeral",
            ActiveName = "YMoves",
            CooldownName = "STANDON-Y",
            InputText = "%s",
            Visible = true
        } },
    ChopStrike = {
        Cooldown = {
            Name = "STANDOFF-Y",
            Time = 3
        }
    },
    StateFuneral = {
        Cooldown = {
            Name = "STANDON-Y",
            Time = 3
        }
    }
};
v1.GMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Fanfire Disposal",
            ActiveName = "GMoves",
            InputText = "%s",
            CooldownName = "G",
            Visible = true
        }, {
            Group = "Universal",
            Name = "Precision Disposal",
            ActiveName = "GMoves",
            CooldownName = "G-HELD",
            InputText = "%s+",
            Visible = true
        } },
    FanfireDisposal = {
        Cooldown = {
            Name = "G",
            Time = 3
        }
    },
    PrecisionDisposal = {
        Cooldown = {
            Name = "G-HELD",
            Time = 3
        }
    }
};
v1.HMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Gut Gouge",
            ActiveName = "HMoves",
            CooldownName = "STANDON-H",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "STANDON-H",
        Time = 3
    }
};
v1.VMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Indicators = { {
            Group = "Universal",
            Name = "Love Train",
            ActiveName = "VMoves",
            CooldownName = "V",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "V",
        Time = 3
    }
};

return {
    Template_R = v1
};