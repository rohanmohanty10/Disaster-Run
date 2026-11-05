  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local v1 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            },
            StandOff = {
                Visible = true
            },
            StandOn = {
                Visible = false
            },
            HeavyWeather = {
                Visible = false
            }
        },
        Moves = {
            Q = "Summon",
            MouseButton1 = "Rush Attack",
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            E = "Triple Air Cleave / Shock Barrage",
            R = "Flare Ring / Combustive Heatwave / Thousand Volt Plexus",
            T = "Ice Breath / Air Bullets",
            Y = "Blood Oxidation / Lung Exhaustion",
            U = "Frog Rain",
            G = "Air Bomb / Winds of Destruction",
            H = "Lightning Strike",
            V = "Wind Counter",
            B = "Heavy Weather / Devils Rainbow",
            J = "Cloud Suit",
            P = "Pose"
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    Assets = ClientAssets["Weather Report"]
};
v1.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    Indicators = { {
            Group = "Universal",
            Name = "Summon",
            DisplayName = "Summon",
            CooldownName = "Summon",
            ActiveName = "Summon",
            InputText = "%s",
            Visible = true
        } },
    LeaveParts = { "StandHumanoidRootPart", "FAKE", "StandAura2" },
    SummonParticle = {
        ParticleName = "WRSummon",
        PartName = "SummonParticle"
    },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 222, 255)) }),
    Callbacks = {
        Summon = function(p2) -- Line: 85, Name: Summon
            p2.Animator:GetAnimation("Default Clouds"):Play();
        end,

        Unsummon = function(p3) -- Line: 90, Name: Unsummon
            p3.Animator:GetAnimation("Default Clouds"):Stop();
        end
    }
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Stats.Pose = {
    From = "Combat.Pose"
};
v1.Stats["Shock Barrage"] = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = { v1.Resources.BarrageHitSound }
    },
    Finisher = {
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = { v1.Resources.BarrageFinisherSound }
    },
    ClashHit = {},
    ClashFinisher = {},
    Callbacks = {
        OnHit = v1.Resources.ShockCallback
    }
}, BaseStatsModule.Stand_Barrage);
v1.Stats["Triple Air Cleave"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.65
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 16,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10324383011,
                Volume = 3
            }
        }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.7
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 10324383011,
                Volume = 3
            }
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
        part = ClientAssets.Misc.slash
    }
};
v1.Stats["Triple Air Cleave / Shock Barrage"] = {
    Indicators = { {
            Group = "StandOff",
            Name = "Triple Air Cleave",
            InputText = "%s",
            ActiveName = "Triple Air Cleave",
            CooldownName = "Triple Air Cleave",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Shock Barrage",
            ActiveName = "Shock Barrage",
            CooldownName = "Shock Barrage",
            InputText = "%s",
            Visible = true
        } }
};
v1.Stats["Flare Ring"] = {
    Active = true,
    Lifetime = 5,
    Tick = 0.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 35,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Velocity = Vector3.new(0, 40, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 10324390027,
                Volume = 3
            }
        }
    },
    Burn = {
        Damage = 5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.25
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15)
        }
    }
};
v1.Stats["Combustive Heatwave"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Time = 0.1
    },
    Block = {
        BlockBreak = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v1.Resources.HeavyHit },
    HitSounds = {
        Hit = {
            SoundId = 8965811167,
            Volume = 3
        }
    }
};
v1.Stats["Thousand Volt Plexus"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 16,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 8963473542,
                Volume = 3
            }
        }
    },
    Shock = {
        Damage = 25,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 7.5,
            Offset = CFrame.new(0, 0, -7.5)
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 8963473542,
                Volume = 3
            }
        }
    }
};
v1.Stats["Flare Ring / Combustive Heatwave / Thousand Volt Plexus"] = {
    Indicators = { {
            Group = "StandOff",
            Name = "Flare Ring",
            InputText = "%s",
            ActiveName = "Flare Ring",
            CooldownName = "Flare Ring",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Combustive Heatwave",
            ActiveName = "Combustive Heatwave",
            CooldownName = "Combustive Heatwave",
            InputText = "%s",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Thousand Volt Plexus",
            ActiveName = "Thousand Volt Plexus",
            CooldownName = "Thousand Volt Plexus",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },

    Invoke = function(p4) -- Line: 450, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p4.Input;
        local v5 = Knit.GetController("MoveInputController");
        local v6 = Knit.GetService("MoveInputService");
        local v7 = os.clock();
        local v8 = false;

        while v5.Inputs[Input] do
            if os.clock() - v7 >= 0.2 then
                v8 = true;
                break;
            end;

            task.wait();
        end;

        v6:FireInput(Input, v8);
    end
};
v1.Stats["Blood Oxidation"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Startup = {
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Hit = {
        Damage = 1,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V2", "__Legacy", "BloodOxHit" }
            } },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 10324404248,
                Volume = 3
            }
        }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 56,
            Velocity = Vector3.new(0, 18, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }
};
v1.Stats["Lung Exhaustion"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Stun = {
        Time = 1.75
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V2", "__Legacy", "LungExhaustion" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 10193054534,
            Volume = 3
        }
    },
    HitAnimations = { v1.Animations.Action["Lung Victim"] }
};
v1.Stats["Ice Breath"] = {
    Active = true,
    Damage = 2,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Stun = {
        Time = 0.1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6, 6, 15),
        Offset = CFrame.new(0, 0, -7.5)
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V2", "__Legacy", "WRIceBreath" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 10324392366,
            Volume = 3
        }
    }
};
v1.Stats["Air Bullets"] = {
    Active = true,
    Distance = 3,
    Damage = 2,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Stun = {
        Time = 0.1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitRemotes = { v1.Resources.LightHit },
    HitSounds = {
        Hit = {
            SoundId = 10344753534,
            Volume = 3
        }
    }
};
v1.Stats["Ice Breath / Air Bullets"] = {
    Indicators = { {
            Group = "StandOff",
            Name = "Ice Breath",
            InputText = "%s",
            ActiveName = "Ice Breath",
            CooldownName = "Ice Breath",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Air Bullets",
            ActiveName = "Air Bullets",
            CooldownName = "Air Bullets",
            InputText = "%s",
            Visible = true
        } }
};
v1.Stats["Blood Oxidation / Lung Exhaustion"] = {
    Indicators = { {
            Group = "StandOff",
            Name = "Blood Oxidation",
            InputText = "%s",
            ActiveName = "Blood Oxidation",
            CooldownName = "Blood Oxidation",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Lung Exhaustion",
            ActiveName = "Lung Exhaustion",
            CooldownName = "Lung Exhaustion",
            InputText = "%s",
            Visible = true
        } }
};

return v1;