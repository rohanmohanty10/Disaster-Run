  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("UserInputService");
local _ = workspace.CurrentCamera;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local _ = ReplicatedStorage["Client Assets"];
local Output = ReplicatedStorage.Remotes.Output;
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);

return {
    GOKU_R = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = {
                Endlag = 0.2,
                Speed = 1,
                Damage = 8,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 15, "Attack" }, { 21, "End" } },
                Stun = {
                    Time = 0.85,
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
                    Size = Vector3.new(5.3, 5.3, 6),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "LightHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7213363915,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-4"] = {
                Cooldown = 0.75,
                Damage = 25,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 15, "Attack" }, { 21, "End" } },
                Stun = {
                    Time = 0.3
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 10626763879,
                        Volume = 3
                    }
                }
            }
        },
        Base = {
            Form = "Base",
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Indicators = { {
                    Group = "StandOff",
                    Visible = true
                } },

            VisualEffects = function(p1) -- Line: 252, Name: VisualEffects
                -- upvalues: Output (copy)
                Output:FireClient(p1.Player, "FX", "FOVChangeSmart", 75, 70, 0.75, 0.1);
            end
        },
        ["Super Saiyan"] = {
            Form = "Super Saiyan",
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Indicators = { {
                    Group = "StandOff",
                    Visible = true
                } },

            VisualEffects = function(p2) -- Line: 282, Name: VisualEffects
                -- upvalues: Output (copy)
                Output:FireAllClients("FX", "CameraShake", "Bump");
                Output:FireAllClients("FX", "FOVChangeSmart", 80, 70, 0.75, 0.1);
                Output:FireAllClients("FX", "TemporalEffect", Color3.fromRGB(255, 247, 0), Color3.fromRGB(53, 174, 255), 0.3);
            end
        },
        ["Super Saiyan Blue"] = {
            Form = "Super Saiyan Blue",
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Indicators = { {
                    Group = "StandOff",
                    Visible = true
                } },

            VisualEffects = function(p3) -- Line: 312, Name: VisualEffects
                -- upvalues: Output (copy)
                Output:FireAllClients("FX", "CameraShake", "Bump");
                Output:FireAllClients("FX", "FOVChangeSmart", 80, 70, 0.75, 0.1);
                Output:FireAllClients("FX", "TemporalEffect", Color3.fromRGB(40, 25, 255), Color3.fromRGB(53, 174, 255), 0.3);
            end
        },
        ["Ultra Instinct"] = {
            Form = "Ultra Instinct",
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Indicators = { {
                    Group = "StandOff",
                    Visible = true
                } },

            VisualEffects = function(p4) -- Line: 342, Name: VisualEffects
                -- upvalues: Output (copy)
                Output:FireAllClients("FX", "CameraShake", "Bump");
                Output:FireAllClients("FX", "FOVChangeSmart", 80, 70, 0.75, 0.1);
                Output:FireAllClients("FX", "TemporalEffect", Color3.fromRGB(255, 255, 255), Color3.fromRGB(53, 174, 255), 0.3);
            end
        },
        EMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Kiai",
                    CooldownName = "E-Kiai",
                    ActiveName = "EMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan",
                    Name = "Gut Punch",
                    CooldownName = "E-Gut Punch",
                    ActiveName = "EMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan Blue",
                    Name = "Super God Shock Flash",
                    CooldownName = "E-Super God Shock Flash",
                    ActiveName = "EMoves",
                    Visible = true
                } },
            Kiai = {
                Damage = 25,
                Active = true,
                Stun = {
                    Time = 0.4
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(7.5, 7.5, 15),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -8)
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 75,
                    Time = 0.15
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            },
            ["Gut Punch"] = {
                Damage = 25,
                Active = true,
                Stun = {
                    Time = 0.65
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5, 5, 5),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -2.5)
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 1058693352,
                        Volume = 0.8
                    }
                }
            }
        },
        RMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Jajanken",
                    CooldownName = "R-Jajanken",
                    ActiveName = "RMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan",
                    Name = "Meteor Smash",
                    CooldownName = "R-Meteor Smash",
                    ActiveName = "RMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan Blue",
                    Name = "Super God Fist",
                    CooldownName = "R-Super God Fist",
                    ActiveName = "RMoves",
                    Visible = true
                } },
            Jajanken = {
                Damage = 25,
                Active = true,
                Stun = {
                    Time = 0.4
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5.3, 5.3, 6),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -4)
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 75,
                    Time = 0.15
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            }
        },
        TMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Explosive Wave",
                    CooldownName = "T-Explosive Wave",
                    ActiveName = "TMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan",
                    Name = "Dragon Throw",
                    CooldownName = "T-Dragon Throw",
                    ActiveName = "TMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan Blue",
                    Name = "Godbind",
                    CooldownName = "T-Godbind",
                    ActiveName = "TMoves",
                    Visible = true
                }, {
                    Group = "Ultra Instinct",
                    Name = "Autonomous Fist",
                    CooldownName = "T-Autonomous Fist",
                    ActiveName = "TMoves",
                    Visible = true
                } },
            ["Explosive Wave"] = {
                Damage = 25,
                Active = true,
                Stun = {
                    Time = 0.4
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(25, 25, 25),
                    Debug = true,
                    Offset = CFrame.new()
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 85,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 20, 0)
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            }
        },
        YMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Solar Flare",
                    CooldownName = "Y-Solar Flare",
                    ActiveName = "YMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan",
                    Name = "Barrage",
                    CooldownName = "Y-Barrage",
                    ActiveName = "YMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan Blue",
                    Name = "Grudgeless Strike",
                    CooldownName = "Y-Grudgeless Strike",
                    ActiveName = "YMoves",
                    Visible = true
                }, {
                    Group = "Ultra Instinct",
                    Name = "Unpolished Instinct",
                    CooldownName = "Y-Unpolished Instinct",
                    ActiveName = "YMoves",
                    Visible = true
                } },
            ["Solar Flare"] = {
                Damage = 25,
                Active = true,
                Stun = {
                    Time = 0.65
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(25, 25, 25),
                    Debug = true,
                    Offset = CFrame.new()
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            },
            Barrage = {
                Damage = 3,
                Stun = {
                    Time = 0.65
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Active = true,
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5, 5, 5),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -2.5)
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "LightHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7213363915,
                        Volume = 0.8
                    }
                },
                Finish = {
                    Damage = 15,
                    Stun = {
                        Time = 0.65
                    },
                    Hitbox = {
                        Type = "Region3",
                        RelativePart = "HumanoidRootPart",
                        Size = Vector3.new(5, 5, 5),
                        Debug = true,
                        Offset = CFrame.new(0, 0, -2.5)
                    },
                    HitRemotes = { {
                            Name = "Output",
                            Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                        } },
                    HitData = {
                        Type = "HeavyHit"
                    },
                    HitSounds = {
                        Hit = {
                            SoundId = 1058693352,
                            Volume = 0.8
                        }
                    }
                }
            },
            ["Grudgeless Strike"] = {
                Damage = 25,
                Duration = 0.8,
                Distance = 35,
                Active = true,
                Stun = {
                    Time = 0.65
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5, 5, 10),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -5)
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 150,
                    Time = 0.15
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            }
        },
        GMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Destructo Disc",
                    CooldownName = "G-Destructo Disc",
                    ActiveName = "GMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan",
                    Name = "Meteor Combination",
                    CooldownName = "G-Meteor Combination",
                    ActiveName = "GMoves",
                    Visible = true
                }, {
                    Group = "Super Saiyan Blue",
                    Name = "Universe 7 Spirit Bomb",
                    CooldownName = "G-Universe 7 Spirit Bomb",
                    ActiveName = "GMoves",
                    Visible = true
                }, {
                    Group = "Ultra Instinct",
                    Name = "Celestial Whirlwind",
                    CooldownName = "G-Celestial Whirlwind",
                    ActiveName = "GMoves",
                    Visible = true
                } },
            ["Meteor Combination"] = {
                Damage = 5,
                Stun = {
                    Time = 0.85
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Active = true,
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5, 5, 5),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -2)
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 1058693352,
                        Volume = 0.8
                    }
                },
                Hit = {
                    Damage = 5,
                    Priority = Enums.Intangible.Move,
                    Stun = {
                        Time = 1
                    },
                    HitRemotes = { {
                            Name = "Output",
                            Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                        } },
                    HitData = {
                        Type = "LightHit"
                    },
                    HitSounds = {
                        Hit = {
                            SoundId = 1058693352,
                            Volume = 0.8
                        }
                    }
                },
                Finish = {
                    Damage = 10,
                    Priority = Enums.Intangible.Move,
                    Stun = {
                        Time = 0.5
                    },
                    Knockback = {
                        RelativeTowards = "Target",
                        Speed = 1,
                        Time = 0.15,
                        Velocity = Vector3.new(0, -50, 0)
                    },
                    HitRemotes = { {
                            Name = "Output",
                            Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                        } },
                    HitData = {
                        Type = "HeavyHit"
                    },
                    HitSounds = {
                        Hit = {
                            SoundId = 7458769601,
                            Volume = 0.8
                        }
                    }
                }
            }
        },
        Kamehameha = {
            Damage = 5,
            Frequency = 7.5,
            Active = true,
            Stun = {
                Time = 0.25
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(7.5, 7.5, 40),
                Debug = true,
                Offset = CFrame.new(0, 0, -20)
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                } },
            HitData = {
                Type = "LightHit"
            },
            HitSounds = {
                Hit = {
                    SoundId = 7509595032,
                    Volume = 0.5
                }
            }
        }
    }
};