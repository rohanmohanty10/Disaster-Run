  

 

local v1 = {};
local v2 = game:GetService("ReplicatedStorage")["Client Assets"];
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
v1.Summon = {
    From = "Combat.Summon",
    Indicators = { {
            Group = "Universal",
            Name = "Summon",
            DisplayName = "Summon",
            CooldownName = "Summon",
            ActiveName = "Summon",
            InputText = "%s",
            Visible = true
        } },
    LeaveParts = { "StandHumanoidRootPart", "arm" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
        Stun = {
            Time = 0.425,
            Priority = Enums.Stun.Medium
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
                        Particle = v2["Killer Queen"].LightHit
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    },
    ["LMB-4"] = {
        Cooldown = 0.75,
        Damage = 25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
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
                        Particle = v2["Killer Queen"].HeavyHit
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626763879,
                Volume = 3
            }
        }
    }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.EMoves = {
    From = "Combat.Barrage",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Active = true,
    Indicators = { {
            Group = "StandOn",
            Name = "Barrage",
            CooldownName = "E-Barrage",
            ActiveName = "EMoves",
            Visible = true
        }, {
            Group = "StandOff",
            Name = "Absurd Strength",
            CooldownName = "E-Absurd Strength",
            ActiveName = "EMoves",
            Visible = true
        } },
    Hit = {
        Frequency = 6,
        Damage = 1.5,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Debug = true,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.65,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {},
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect V2",
                    "__Legacy",
                    {
                        AutoSerialize = true,
                        Particle = v2["Killer Queen"].LightHit
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    Finisher = {
        Frequency = 360,
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Debug = true,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            BlockBreak = true
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
                        Particle = v2["Killer Queen"].HeavyHit
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    },
    ClashHit = {
        Frequency = 6,
        Damage = 1,
        Priority = Enums.Intangible.Clash,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Debug = true,
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.1,
            Priority = Enums.Stun.Medium
        },
        Block = {},
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
        Frequency = 360,
        Damage = 15,
        Priority = Enums.Intangible.Clash,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Debug = true,
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.15
        },
        Block = {
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    },
    ["Absurd Strength"] = {
        Cooldown = {
            Time = 1,
            AfterMove = true,
            Name = "Absurd Strength"
        }
    }
};
v1.RMoves = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Active = true,
    Indicators = { {
            Group = "StandOn",
            Name = "Curse Poke",
            CooldownName = "R-Curse Poke",
            ActiveName = "RMoves",
            Visible = true
        }, {
            Group = "StandOff",
            Name = "Dormant Chant",
            CooldownName = "R-Dormant Chant",
            ActiveName = "RMoves",
            Visible = true
        } },
    ["Curse Poke"] = {
        Cooldown = {
            Name = "R-Curse Poke",
            DisplayName = "Curse Poke",
            Time = 3
        }
    },
    ["Dormant Chant"] = {
        Cooldown = {
            Name = "R-Dormant Chant",
            DisplayName = "Dormant Chant",
            Time = 12
        }
    }
};
v1["Sinful Puncture"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Sinful Puncture",
            CooldownName = "T-Sinful Puncture",
            ActiveName = "TMoves",
            Visible = true
        } },
    Cooldown = {
        Name = "T-Sinful Puncture",
        DisplayName = "Sinful Puncture",
        Time = 3
    }
};
v1.YMoves = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Active = true,
    Indicators = { {
            Group = "StandOn",
            Name = "Cursed Orb",
            CooldownName = "Y-Cursed Orb",
            ActiveName = "YMoves",
            Visible = true
        }, {
            Group = "StandOff",
            Name = "Fit Of Rage",
            CooldownName = "Y-Fit Of Rage",
            ActiveName = "YMoves",
            Visible = true
        } },
    ["Cursed Orb"] = {
        Cooldown = {
            Name = "Y-Cursed Orb",
            DisplayName = "Cursed Orb",
            Time = 3
        }
    },
    ["Fit Of Rage"] = {
        Cooldown = {
            Name = "Y-Fit Of Rage",
            DisplayName = "Fit Of Rage",
            Time = 12
        }
    }
};
v1["Shaded Induction"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Shaded Induction",
            CooldownName = "G-Shaded Induction",
            ActiveName = "GMoves",
            Visible = true
        } },
    Cooldown = {
        Name = "G-Shaded Induction",
        DisplayName = "Shaded Induction",
        Time = 3
    }
};
v1["Shadowy Ire"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Shadowy Ire",
            CooldownName = "H-Shadowy Ire",
            ActiveName = "HMoves",
            Visible = true
        } },
    Cooldown = {
        Name = "H-Shadowy Ire",
        DisplayName = "Shadowy Ire",
        Time = 3
    }
};
v1["Cursed Arrow"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Cursed Arrow",
            CooldownName = "V-Cursed Arrow",
            ActiveName = "VMoves",
            Visible = true
        } },
    Cooldown = {
        Name = "V-Cursed Arrow",
        DisplayName = "Cursed Arrow",
        Time = 3
    }
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
            } }
    },
    Throw = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1.Pose = {
    From = "Combat.Pose"
};

return {
    Stats = v1
};