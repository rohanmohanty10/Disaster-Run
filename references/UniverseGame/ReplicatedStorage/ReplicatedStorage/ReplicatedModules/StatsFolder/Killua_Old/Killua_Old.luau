  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local _ = workspace.CurrentCamera;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local v1 = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v2 = {};

local function BuffCheck(p3) -- Line: 28
    -- upvalues: Knit (copy)
    return not (Knit.CollectionService:HasTag(p3, "Otherworldly Aura") or Knit.CollectionService:HasTag(p3, "Godspeed"));
end;

v2["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 12, "Attack" }, { 19, "End" } },
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
                        Particle = v1.Killua.Global.Light
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 6706979361,
                Volume = 3
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.35
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Block = {
    From = "Combat.Block"
};
v2.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Pose = {
    From = "Combat.Pose"
};
v2.Grab = {
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
v2["The Snake Awakens"] = {
    Frequency = 6,
    Active = true,
    Damage = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 8,
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5.5,
        Time = 0.05
    },
    Stun = {
        Time = 0.7
    },
    HitSounds = {
        Hit = {
            SoundId = 7415351889,
            Volume = 1
        }
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "_Emit Particles",
                {
                    Character = "__Attacker",
                    Target = "__Target",
                    LookAt = "__Attacker",
                    Object = v1.Killua.Global.Light
                }
            }
        }
    }
};
v2["Otherworldly Aura"] = {
    Length = 25,
    Active = true,
    Properties = {
        Armor = true
    },
    Actionable = {
        Active = true,
        Check = BuffCheck
    },
    Meter = {
        RequiredLevel = 2
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v2.Godspeed = {
    Length = 25,
    Active = true,
    Actionable = {
        Active = true,
        Check = BuffCheck
    },
    Meter = {
        RequiredLevel = 2
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v2["No Mercy"] = {
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Block = {
        BlockBreak = true
    },
    Damage = 7,
    Stun = {
        Time = 0.5
    },
    HitAnimations = "Default",
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8.5, 8.5, 8.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HeavyEffect", "__Legacy" }
        } },
    Lightning = {
        Damage = 4,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.5
        }
    },
    Godspeed = {
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(5, 5, 28),
            Offset = CFrame.new(0, 0, -14)
        }
    }
};
v2.Thunderbolt = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10.5, 10.5, 32.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -16.25)
    },
    Damage = 25,
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 1
    },
    HitAnimations = "Default",
    Air = {
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Size = 15,
            Debug = false
        }
    },
    Tick = {
        Damage = 0.35,
        Block = {
            PerfectBlockable = false
        }
    },

    Invoke = function(p4) -- Line: 348, Name: Invoke
        -- upvalues: Players (copy), Knit (copy)
        local _ = p4.Input;
        local Character = Players.LocalPlayer.Character;
        Character:WaitForChild("Humanoid");
        Knit.GetService("MoveInputService"):FireInput(p4.RawInput, Character.Humanoid.FloorMaterial ~= Enum.Material.Air);
    end
};
v2["Instant Death"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8.5, 8.5, 8.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Damage = 20,
    Stun = {
        Time = 0.75
    },
    HitAnimations = "Default",
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HeavyEffect", "__Legacy" }
        } },
    Godspeed = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(5, 5, 28),
            Debug = false,
            Offset = CFrame.new(0, 0, -14)
        }
    },
    Heart = {
        Damage = 30,
        Priority = Enums.Intangible.Move
    }
};
v2["Speed of Lightning"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p5) -- Line: 419, Name: Check
            return p5:WaitForChild("Humanoid").MoveDirection.Magnitude > 0;
        end
    },
    Cooldown = {
        Time = 4,
        AfterMove = true
    }
};
v2.Onslaught = {
    Properties = {
        Armor = true
    },
    Frequency = 3,
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.25, 6.25, 50),
        Debug = false,
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -25)
    },
    Damage = 10,
    Stun = {
        Time = 0.75
    },
    HitAnimations = "Default",
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HeavyEffect", "__Legacy" }
        } },
    Hit = {
        Damage = 3,
        Priority = Enums.Intangible.Move
    },
    Finisher = {
        Damage = 22,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 60,
            Time = 0.15,
            Velocity = Vector3.new(0, 25, 0)
        }
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
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
            ["Otherworldly Aura"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Enter a heightened state of concentration, temporarily unlocking the full potential of an assassin. Damage is increased or a short period of time."
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
            ["The Snake Awakens"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Whip your arms around with intense speed and fluidity, rapidly cleaving those who come into contact."
            },
            ["No Mercy"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Perform a short dash forwards, winding up electricity within both palms to strike and push targets away."
            },
            Thunderbolt = {
                DefaultKeybind = "T",
                Description = "Projects a bolt of lightning from your hand at a distance. If casted in midair, you leap higher to shoot directly below with a bolt of lightning.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Godspeed = {
                DefaultKeybind = "B",
                Description = "Activate your primary Nen ability to allow the use of ugomatic reaction to external stimuli, drastically heightening your speed and jumping capabilities. In this state, No Mercy, Instant Death, Thunderbolt, and Speed of Lightning increase greatly in both range and speed.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Instant Death"] = {
                DefaultKeybind = "G",
                Description = "Provided with a dash forwards and adjustment of your hand to easily pierce the skin, rip out the heart of anyone caught in range with ease. ",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Onslaught = {
                DefaultKeybind = "H",
                Description = "Charging up your Nen and allowing the temporary use of Godspeed, dash forward in an instant to strike targets with immeasurable speed and power. ",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Speed of Lightning"] = {
                DefaultKeybind = "V",
                Description = "Perform the second application of Godspeed and retain conscious control of your movements, covering short distances in times comparable to teleportation. ",
                LevelRequirement = 45,
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
            ["LMB-1"] = 11541565034,
            ["LMB-2"] = 11541567300,
            ["LMB-3"] = 11541568928,
            ["LMB-4"] = 11541571234,
            NoMercyKick = 7284000061,
            NoMercyLightningPalm = 7284003850,
            AirLightning = 7284004774,
            GroundLightning = 7284006262,
            ["The Snake Awakens"] = 7293096473,
            InstantDeath = 7293594684,
            GrabHeart = 7293596879,
            OnslaughtWindup = 7406016749,
            OnslaughtDash = 7406045618,
            OnslaughtBD = 7406314237,
            OnslaughtVictim = 7406302666,
            Godspeed = 7415474339,
            TeleportLightning = 7415921371,
            PoseIdle = 8055488849,
            PoseTransition = 8055486767
        },
        Movement = {
            Run = 7294685851,
            Walk = 7294686634
        },
        Idle = {
            Idle = 7294684954
        }
    },
    Stats = v2,
    Sounds = {
        SpeedOfLightning = {
            SoundId = "rbxassetid://4086012327",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NarukamiVC = {
            SoundId = "rbxassetid://7411176385",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        THEME = {
            SoundId = "rbxassetid://10393998754",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        THEME1 = {
            SoundId = "rbxassetid://10394009339",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Narukami = {
            SoundId = "rbxassetid://7411173764",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NarukamiAir = {
            SoundId = "rbxassetid://7411178043",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NarukamiAirWind = {
            SoundId = "rbxassetid://7411175784",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NarukamiWind = {
            SoundId = "rbxassetid://7411170674",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        OnslaughtWindUp = {
            SoundId = "rbxassetid://7410924742",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        OnslaughtVC = {
            SoundId = "rbxassetid://7410906265",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GodSweeps = {
            SoundId = "rbxassetid://7410910080",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SLAMMED = {
            SoundId = "rbxassetid://7410915468",
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GODSPEED = {
            SoundId = "rbxassetid://7410910777",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CloneSFX = {
            SoundId = "rbxassetid://7413202487",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeartRip = {
            SoundId = "rbxassetid://7414285895",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningPalm = {
            SoundId = "rbxassetid://7414289494",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderClap = {
            SoundId = "rbxassetid://7414261784",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GodspeedSFX = {
            SoundId = "rbxassetid://7414923627",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        OtherwordlyAura = {
            SoundId = "rbxassetid://7415302151",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        OtherwordlyAuraVC = {
            SoundId = "rbxassetid://7415301365",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ElectricHits = {
            SoundId = "rbxassetid://7415527034",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Snake = {
            SoundId = "rbxassetid://7415914468",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GODSPEEDVC = {
            SoundId = "rbxassetid://7418995640",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NoMercyKick = {
            SoundId = "rbxassetid://7419165996",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DashSFX = {
            SoundId = "rbxassetid://7419159380",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningPalmVC = {
            SoundId = "rbxassetid://7419163741",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LIGHTNINGPALM = {
            SoundId = "rbxassetid://7419281489",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://10393894222",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
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
                    SoundId = "rbxassetid://7418957007",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Is acting cocky your strategy here?"
                        } }
                }, {
                    SoundId = "rbxassetid://7418954326",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "There, I win."
                        } }
                }, {
                    SoundId = "rbxassetid://7418955843",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Move, and I will kill you. Make a sound and I will kill you."
                        } }
                } }
        }
    }
};