  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local v1 = {
    Stats = {}
};
v1.Stats["Light Flight"] = {
    Active = true,
    Damage = 10,
    Actionable = {
        Ragdolled = false,
        Stunned = false,
        Timestopped = false,

        Check = function(p2) -- Line: 26, Name: Check
            return true;
        end
    },
    Cooldown = {
        Time = 2,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 1,
        RemoveMeter = false
    },
    Stun = {
        Time = 1.25,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Hitbox = {
        Size = 11.5
    }
};
v1.Stats.Starman = {
    Duration = 30,
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p3) -- Line: 66, Name: Check
            return not p3:GetAttribute("TheStarman");
        end
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 100,
        RemoveMeter = true
    }
};
v1.Stats["Super Hammer"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = true
    },
    HammerAttempt = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 8, 10),
            Offset = CFrame.new(0, 0, -5)
        }
    },
    Hammer = {
        Damage = 1,
        Priority = EnumsModule.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 8, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Stun = {
            Time = 0.65
        },
        HitSounds = {
            Hit = {
                SoundId = 127344675792074,
                Volume = 1
            }
        }
    },
    HammerFinale = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 8, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.15,
            Velocity = Vector3.new(0, 100, 0)
        },
        Ragdoll = {
            Time = 2.5
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 1.5,
                Overrides = {
                    Lifetime = 5,
                    Rate = 0.5
                }
            } },
        HitSounds = {
            Hit = {
                SoundId = 168485325,
                Volume = 2
            }
        }
    }
};

return {
    Moveset = {
        MovesInfo = {
            ["Light Flight"] = {
                DefaultKeybind = "U",
                Unlocked = true,
                Description = "Bathe in light and fly towards the location of your cursor. The travel speed increases gradually with each bounce."
            },
            Starman = {
                DefaultKeybind = "K",
                Unlocked = true,
                Description = "Perform a stance and summon a star that swirls around you before entering your body, once completed briefly become invincible"
            },
            ["Super Hammer"] = {
                DefaultKeybind = "9",
                Unlocked = true,
                Description = ""
            }
        }
    },
    Stats = v1.Stats,
    Animations = {
        Action4 = {
            Starman = 140719648416610
        }
    },
    Sounds = {
        ["Light Flight Beam"] = {
            SoundId = 3700140391,
            Volume = 0.75,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 2.263),
            LoopRegion = NumberRange.new(1.418, 2.263)
        },
        ["Light Flight Bounce"] = {
            SoundId = 140290710765161,
            Volume = 4
        },
        ["Light Flight Charge"] = {
            SoundId = 3699982431,
            Volume = 1.85
        },
        ["Light Flight End"] = {
            SoundId = 6914558870,
            Volume = 2
        },
        ["Light Flight Fire"] = {
            SoundId = 3700069140,
            Volume = 2
        },
        ["Starman Music-1"] = {
            SoundId = 97281373277732,
            Looped = true,
            Volume = 3
        },
        ["Starman Music-2"] = {
            SoundId = 75668483241387,
            Looped = true,
            Volume = 3
        },
        ["Starman Music-3"] = {
            SoundId = 102032427228190,
            Looped = true,
            Volume = 3
        },
        ["Starman Aura"] = {
            SoundId = 92791483194017,
            Looped = true,
            RollOffMaxDistance = 75,
            Volume = 2
        },
        ["Flower Music-1"] = {
            SoundId = 116799497951473,
            Looped = true,
            Volume = 3
        },
        ["Flower Music-2"] = {
            SoundId = 100633214202615,
            Looped = true,
            Volume = 3
        },
        ["Flower Get Voiceline-1"] = {
            SoundId = 100186246943418,
            Volume = 4
        },
        ["Flower Get Voiceline-2"] = {
            SoundId = 101366115184343,
            Volume = 4
        },
        ["Starman Hit"] = {
            SoundId = 5236432875,
            Volume = 1.75
        },
        ["Starman Indicator"] = {
            SoundId = 6698633601,
            Volume = 2.5
        },
        ["Starman Obtained"] = {
            SoundId = 6718302537,
            Volume = 2.5
        },
        ["Starman Powerup"] = {
            SoundId = 162456532,
            Volume = 1.5
        },
        ["Starman End"] = {
            SoundId = 302855397,
            Volume = 2
        },
        ["Starman Start"] = {
            SoundId = 6110173017,
            Volume = 3
        },
        ["Mario Super Voiceline-1"] = {
            SoundId = 1239202098,
            Volume = 3
        },
        ["Mario Super Voiceline-2"] = {
            SoundId = 104051242951237,
            Volume = 3
        },
        ["Mario Super Voiceline-3"] = {
            SoundId = 128458289676697,
            Volume = 3
        },
        ["Mario Super Voiceline-4"] = {
            SoundId = 119764757022485,
            Volume = 3
        },
        ["Starman Get Voiceline-1"] = {
            SoundId = 120703177278722,
            Volume = 4
        },
        ["Starman Get Voiceline-2"] = {
            SoundId = 116914148858133,
            Volume = 4
        },
        ["Starman Get Voiceline-3"] = {
            SoundId = 78337454277766,
            Volume = 3
        },
        ["Starman Get Voiceline-4"] = {
            SoundId = 130717154975302,
            Volume = 3
        },
        ["Starman Get Voiceline-5"] = {
            SoundId = 81730067866191,
            Volume = 3
        },
        ["Starman Jump-Voiceline"] = {
            SoundId = 2606662486,
            Volume = 2
        },
        ["Super Hammer Music"] = {
            SoundId = 121398671946836,
            Volume = 3,
            Looped = true
        }
    }
};