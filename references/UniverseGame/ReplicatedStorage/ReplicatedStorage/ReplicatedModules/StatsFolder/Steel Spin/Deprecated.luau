  

 

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
local v2 = {
    {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V2",
            "__Legacy",
            {
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = ClientAssets["Crazy Diamond"].BarrageEffect
            }
        }
    }
};
local v3 = {
    {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V2",
            "__Legacy",
            {
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect
            }
        }
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 29, 36, "Attack" }, { 38, "End" } },
        Stun = {
            Time = 0.625
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = ClientAssets["C-Moon"].Effects.Hit
        },
        HitSounds = {
            Hit = {
                SoundId = 11039099000,
                Volume = 1.5
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "LesserInversion",
                Damage = 3
            } }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 26, 36, "Attack" }, { 38, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 11039098388,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 33, 37, "Attack" }, { 38, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 11039098761,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.45,
        Sequence = { { 0, "Start" }, { 40, 50, "Attack" }, { 55, "End" } },
        Stun = {
            Time = 0.3
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
                SoundId = 11039098093,
                Volume = 1.5
            }
        },
        StatusEffects = {}
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 28, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
            } },
        HitData = {
            Effect = ClientAssets["C-Moon"].Effects.Hit
        },
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
            { 0, function(u4, p5, p6) -- Line: 208
                    -- upvalues: ClientAssets (copy)
                    u4.UserData.Attachment = ClientAssets.Whitesnake.CrossEffects.Attachment:Clone();
                    u4.UserData.Attachment.Parent = p6.Character["Left Arm"];
                    u4.UserData.Attachment.StartupShine:Emit(1);
                    u4.UserData.Attachment.StartupTwinkle:Emit(1);
                    task.delay(0.05, function() -- Line: 215
                        -- upvalues: u4 (copy)
                        u4.UserData.Attachment.Twinkle1:Emit(3);
                        u4.UserData.Attachment.Twinkle2:Emit(3);
                        u4.UserData.Attachment.Swirls:Emit(3);
                    end);
                    task.delay(0.15, function() -- Line: 221
                        -- upvalues: u4 (copy)
                        u4.UserData.Attachment.ParticleEmitter:Emit(8);
                    end);
                    task.delay(0.6, function() -- Line: 225
                        -- upvalues: u4 (copy)
                        u4.UserData.Attachment:Destroy();
                    end);
                end },
            { 36, 42, "Attack" },
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
        StateChecker = function(p7, p8) -- Line: 252, Name: StateChecker
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
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            InputText = "%s",
            Visible = true
        } },
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
v1.QMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Steel Ball Formation",
            ActiveName = "QMoves",
            CooldownName = "Q",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "Q",
        Time = 12
    }
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
            Group = "Universal",
            Name = "Iron Spurs",
            ActiveName = "EMoves",
            CooldownName = "E",
            InputText = "%s",
            Visible = true
        } },
    IronSpurs = {
        Damage = 22.5,
        HitAnimations = "Default",
        Cooldown = {
            Name = "E",
            Time = 8
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 9),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        },
        Block = {},
        Stun = {
            Time = 0.78,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 11845591898,
                Volume = 1.5
            }
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
            Group = "Universal",
            Name = "Iron Fist",
            ActiveName = "RMoves",
            CooldownName = "R",
            InputText = "%s",
            Visible = true
        } },
    IronFist = {
        Damage = 30,
        HitAnimations = "Default",
        Cooldown = {
            Name = "R",
            Time = 12
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 9),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        },
        Block = {
            BlockBreak = true
        },
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Ragdoll = {
            Time = 0.5
        },
        HitRemotes = v3,
        HitSounds = {
            Hit = {
                SoundId = 11845593780,
                Volume = 1.5
            }
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
            Group = "Universal",
            Name = "Steel Ball Throw",
            ActiveName = "TMoves",
            CooldownName = "T",
            InputText = "%s",
            Visible = true
        } },
    SteelBallThrow = {
        Damage = 22.5,
        HitAnimations = "Default",
        Cooldown = {
            Name = "T",
            Time = 5
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(4, 4, 4),
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {},
        Stun = {
            Time = 0.78,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 11845591898,
                Volume = 1.5
            }
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
            Group = "Universal",
            Name = "Effective Range",
            ActiveName = "YMoves",
            CooldownName = "Y",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "Y",
        Time = 5
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
            Name = "Pacification",
            ActiveName = "GMoves",
            CooldownName = "G",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "G",
        Time = 10
    }
};
v1.HMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Pressure Manipulation",
            ActiveName = "HMoves",
            CooldownName = "H",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "H",
        Time = 16
    }
};
v1.BMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Rectangular Pitching Stance",
            ActiveName = "BMoves",
            CooldownName = "B",
            InputText = "%s",
            Visible = true
        } },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 3
    },
    Cooldown = {
        Name = "B",
        Time = 30
    }
};
v1.FMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Steel Hardened Skin",
            ActiveName = "FMoves",
            CooldownName = "F",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "F",
        Time = 16
    }
};
v1.ZMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Horseback Whistle",
            ActiveName = "ZMoves",
            CooldownName = "Z",
            InputText = "%s+",
            Visible = true
        } },
    Cooldown = {
        Name = "Z",
        Time = 16
    }
};

return {
    Stats = v1
};