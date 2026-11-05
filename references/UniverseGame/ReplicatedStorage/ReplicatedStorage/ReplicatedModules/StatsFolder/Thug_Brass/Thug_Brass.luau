  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
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
            X = "Grab"
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
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 20, 24, "Attack" }, { 35, "End" } },
        HitRemotes = { v1.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 20, 24, "Attack" }, { 35, "End" } }
    },
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 20, 24, "Attack" }, { 35, "End" } },
        HitRemotes = { v1.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Stats.Grab = {
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
    Startup = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Release = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 56,
            Velocity = Vector3.new(0, 16, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }
};

return v1;