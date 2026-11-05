  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local v1 = {
    SoundId = 127403745774142,
    Volume = 2
};
local v2 = {
    Moveset = {
        MovesInfo = {
            SpeedForceRun = {
                DefaultKeybind = "J",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Speed Force [Run]"
                }
            },
            SpeedForceCounter = {
                DefaultKeybind = "B",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Speed Force [Counter]"
                }
            },
            SpeedForceLariat = {
                DefaultKeybind = "H",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Speed Force [Lariat]"
                }
            }
        }
    },
    Stats = {},
    Animations = {
        Action4 = {
            SpeedForceRun = 90554387007274,
            SpeedForceCounter = 76629760209193,
            SpeedForceLariat = 71447169475838
        }
    },
    Sounds = {
        SpeedForceRun = {
            SoundId = 86590549220679,
            Volume = 2
        },
        SpeedForceRunMusic_1 = {
            SoundId = 72712080875838,
            Volume = 2,
            PlaybackSpeed = 4
        },
        SpeedForceRunMusic_2 = {
            SoundId = 125901620816712,
            Volume = 2,
            PlaybackSpeed = 4
        },
        SpeedForceRunMusic_3 = {
            SoundId = 114275723366633,
            Volume = 2,
            PlaybackSpeed = 4
        },
        SpeedForceCounterStart = {
            SoundId = 115407834821306,
            Volume = 2
        },
        SpeedForceCounterMusic = {
            SoundId = 90128098801808,
            Volume = 2,
            PlaybackSpeed = 2
        },
        SpeedForceCounterTrigger = {
            SoundId = 88086334152420,
            Volume = 2
        },
        SpeedForceCounterFail = {
            SoundId = 98019005670133,
            Volume = 2
        },
        SpeedForceLariat = {
            SoundId = 118631822143846,
            Volume = 2
        }
    }
};
v2.Stats.SpeedForceRun = {
    Damage = 6.66,
    Active = true,
    RunSpeed = 80,
    FinalRunSpeed = 140,
    PvPTagScale = 0.85,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.75
    },
    Cooldown = {
        Time = 40,
        AfterMove = true
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Offset = CFrame.identity
    },
    Meter = {
        RequiredAmount = 75
    },
    Priority = Enums.Intangible.Ragdoll,
    Block = {
        Blockable = true,
        BlockBreak = false,
        PerfectBlockable = false,
        BypassCounter = true
    },
    HitSounds = {
        Hit = v1
    }
};
v2.Stats.SpeedForceCounter = {
    Active = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Stun = {
        Time = 1.65
    }
};
v2.Stats.SpeedForceLariat = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Hitbox = {
        Size = Vector3.new(8.5, 8.5, 35),
        Offset = CFrame.new(0, 0, -17.5)
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Ragdoll = {
        Time = 0.4
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3,
        Velocity = Vector3.new(0, 50, 0)
    },
    HitSounds = {
        Hit = v1
    }
};

return v2;