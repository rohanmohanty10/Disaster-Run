  

 

local v1 = {
    Moveset = {
        MovesInfo = {
            Contender = {
                DefaultKeybind = "Z+",
                Description = "Trusty revolver, fires a single powerful bullet.",
                Unlocked = true
            },
            Culler = {
                DefaultKeybind = "X+",
                Description = "Shotgun, fires a spread of bullets, powerful at close range.",
                Unlocked = true
            },
            Sealer = {
                DefaultKeybind = "T+",
                Description = "Submachine gun, fires a barrage of weaker bullets, easier to hit.",
                Unlocked = true
            },
            Flintlock = {
                DefaultKeybind = "Y+",
                Description = "Dash forward while aiming and then shoot with this pistol.",
                Unlocked = true
            }
        }
    },
    Stats = {},
    Animations = {
        Action4 = {
            Contender = 14526232408,
            Sealer = 14526249986,
            SealerFire = 14526252012,
            Culler = 14526228926,
            Flintlock = 17233461329
        }
    },
    Sounds = {
        FlintlockShoot = {
            SoundId = "rbxassetid://18892185372",
            Volume = 1
        },
        FlintlockStartup = {
            SoundId = "rbxassetid://18892183925",
            Volume = 1
        },
        GunStartup = {
            SoundId = "rbxassetid://84904569122068",
            Volume = 2
        },
        SealerShoot = {
            SoundId = "rbxassetid://77246399557431",
            Volume = 1.3
        },
        CullerShoot = {
            SoundId = "rbxassetid://71172880496614",
            Volume = 2
        },
        ContenderShoot = {
            SoundId = "rbxassetid://77522002318662",
            Volume = 2
        }
    }
};
v1.Stats.Culler = {
    Damage = 5,
    BulletCount = 12,
    Active = true,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.25
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 11,
        AfterMove = true
    }
};
v1.Stats.Sealer = {
    Damage = 2,
    RateOfFire = 7,
    Magazine = 30,
    Active = true,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.25
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    }
};
v1.Stats.Contender = {
    Damage = 45,
    Active = true,
    Actionable = {
        Active = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Stun = {
        Time = 0.45
    },
    Ragdoll = {
        Time = 0.35
    },
    Cooldown = {
        Time = 9.5,
        AfterMove = true
    }
};
v1.Stats.Flintlock = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 9.5,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(15, 15, 40),
        Offset = CFrame.new(0, 0, -20)
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 2
    },
    Knockback = {
        Speed = 50,
        Velocity = Vector3.new(0, 14, 0),
        Time = 0.12
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 18892184427,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/YasoppAssist/BulletHitVFX",
                    AutoSerialize = true,
                    LookAt = "Attacker",
                    AbilityName = "Gryphon",
                    HueShift = false
                } }
        } }
};

return v1;