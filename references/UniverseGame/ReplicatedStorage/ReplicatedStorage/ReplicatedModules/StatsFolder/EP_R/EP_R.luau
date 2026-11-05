  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(Knit.Util.Trove);
local ClientAssets = PathShortcuts.ClientAssets;
require(PathShortcuts.GenericModule);
require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.AnimsModule);
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
            { 0, function(u2, p3) -- Line: 181
                    -- upvalues: ClientAssets (copy)
                    u2.UserData.Attachment = ClientAssets.Whitesnake.CrossEffects.Attachment:Clone();
                    u2.UserData.Attachment.Parent = p3.Character["Left Arm"];
                    u2.UserData.Attachment.StartupShine:Emit(1);
                    u2.UserData.Attachment.StartupTwinkle:Emit(1);
                    task.delay(0.05, function() -- Line: 188
                        -- upvalues: u2 (copy)
                        u2.UserData.Attachment.Twinkle1:Emit(3);
                        u2.UserData.Attachment.Twinkle2:Emit(3);
                        u2.UserData.Attachment.Swirls:Emit(3);
                    end);
                    task.delay(0.15, function() -- Line: 194
                        -- upvalues: u2 (copy)
                        u2.UserData.Attachment.ParticleEmitter:Emit(8);
                    end);
                    task.delay(0.6, function() -- Line: 198
                        -- upvalues: u2 (copy)
                        u2.UserData.Attachment:Destroy();
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
        StateChecker = function(p4, p5) -- Line: 225, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p4.Stats;

            if not Knit.CollectionService:HasTag(p4.Character, "Summoned") then
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
            Name = "Jagged Spurs",
            ActiveName = "QMoves",
            CooldownName = "Q",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "Q",
        DisplayName = "Jagged Spurs",
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
            Name = "Abrasive Whip",
            ActiveName = "EMoves",
            CooldownName = "E",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "E",
        DisplayName = "Abrasive Whip",
        Time = 8
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
            Name = "Cement Flooring",
            ActiveName = "RMoves",
            CooldownName = "R",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "R",
        DisplayName = "Cement Flooring",
        Time = 12
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
            Name = "Stickup",
            ActiveName = "TMoves",
            CooldownName = "T",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "T",
        DisplayName = "Stickup",
        Time = 15
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
            Name = "Single Fire",
            ActiveName = "YMoves",
            CooldownName = "Y",
            InputText = "%s",
            Visible = true
        }, {
            Group = "Universal",
            Name = "Stutter Fire",
            ActiveName = "YMoves",
            CooldownName = "YHeld",
            InputText = "%s+",
            Visible = true
        } },
    Cooldown = {
        Name = "Y",
        DisplayName = "Single Fire",
        Time = 5
    },
    HeldCooldown = {
        Name = "YHeld",
        DisplayName = "Stutter Fire",
        Time = 10
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
            Name = "Bullet Redirection",
            ActiveName = "GMoves",
            CooldownName = "G",
            InputText = "%s",
            Visible = true
        } },
    Meter = {
        RequiredLevel = 2
    },
    FailedCooldown = {
        Name = "G",
        DisplayName = "Bullet Redirection",
        Time = 1
    },
    Cooldown = {
        Name = "G",
        DisplayName = "Bullet Redirection",
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
            Name = "Yellow Belly",
            ActiveName = "HMoves",
            CooldownName = "H",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "H",
        DisplayName = "Yellow Belly",
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
            Name = "Relayed Mirror",
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
        DisplayName = "Relayed Mirror",
        Time = 30
    }
};
v1.VMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Womanizer",
            ActiveName = "VMoves",
            CooldownName = "V",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "V",
        DisplayName = "Womanizer",
        Time = 16
    }
};

return {
    Stats = v1
};