  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
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

local function Fire(p2, p3, p4, p5) -- Line: 40
    -- upvalues: PathShortcuts (copy), Knit (copy)
    local Character = p4.Character;
    local _ = p4.RootPart;
    local AttackStats = p5.AttackStats;
    local v6 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    local v7 = Knit.GetService("ProjectileService");
    local v8 = v6.GetMetadata(Character);
    v7.Fire(Knit.ServerLibrary.ProjectileData.Shared.Bullet_Rework, v8.Position, v8.CFrame.LookVector, nil, Character, AttackStats);
end;

v1.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = {
        Damage = 5,
        Speed = 1,
        Sequence = {
            { 0, "Start" },
            { 5, Fire },
            { 25, "End" }
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    ["LMB-2"] = {
        Sequence = {
            { 0, "Start" },
            { 21, Fire },
            { 40, "End" }
        }
    },
    ["LMB-3"] = {
        Sequence = {
            { 0, "Start" },
            { 21, Fire },
            { 40, "End" }
        }
    },
    ["LMB-4"] = {
        Cooldown = 1,
        Sequence = {
            { 0, "Start" },
            { 21, Fire },
            { 40, "End" }
        }
    }
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};

return v1;