  

 

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
            C = "Quickstep"
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
        Speed = 1.85,
        Sequence = { { 0, "Start" }, { 38, 42, "Attack" }, { 72, "End" } },
        HitRemotes = { v1.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 44, 48, "Attack" }, { 83, "End" } }
    },
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = { { 0, "Start" }, { 29, 32, "Attack" }, { 74, "End" } },
        HitRemotes = { v1.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};

return v1;