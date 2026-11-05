  

 

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
            R = "Heavy Attack",
            L = "Breaker"
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
            Visible = true
        } },
    MaxCombo = 3,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = { { 0, "Start" }, { 23, 26, "Attack" }, { 55, "End" } },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = { v1.Resources.LMBHit1 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 22, 25, "Attack" }, { 50, "End" } },
        HitSounds = { v1.Resources.LMBHit2 }
    },
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = { { 0, "Start" }, { 33, 35, "Attack" }, { 53, "End" } },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = { v1.Resources.LMBHit3 }
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
v1.Stats["Heavy Attack"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Attack = {
        Damage = 35,
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
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = { v1.Resources.HeavyHitSound }
    }
};

return v1;