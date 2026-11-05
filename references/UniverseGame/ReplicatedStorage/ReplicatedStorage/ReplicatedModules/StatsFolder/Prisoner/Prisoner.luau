  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
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
            }
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            L = "Breaker",
            E = "Burst Attack",
            R = "Energy Release"
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v1.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Knuckle Sandwich",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 24, 28, "Attack" }, { 31, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855456,
                Volume = 1.5
            }
        },
        HitRemotes = { v1.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 26, 29, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855533,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 22, 24, "Attack" }, { 30, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855248,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 26, 39, "Attack" }, { 40, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855137,
                Volume = 1.5
            }
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Breaker = {
    From = "Combat.Breaker"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Stats.Grab = {
    From = "Combat.Grab"
};
v1.Stats["Burst Attack"] = {
    Active = true,
    Damage = 2.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Knockback = {
        RelativePart = "Target",
        Speed = 20,
        Time = 0.1
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitSounds = {
        Hit = {
            SoundId = 15619855920,
            Volume = 1
        }
    },
    HitRemotes = { v1.Resources.HeavyHit }
};
v1.Stats["Energy Release"] = {
    Active = true,
    Damage = 60,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Stun = {
        Time = 3
    },
    Block = {
        BlockBreak = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Offset = CFrame.identity
    },
    HitSounds = {
        Hit = {
            SoundId = 15619855920,
            Volume = 1
        }
    },
    HitRemotes = { v1.Resources.HeavyHit }
};

return v1;