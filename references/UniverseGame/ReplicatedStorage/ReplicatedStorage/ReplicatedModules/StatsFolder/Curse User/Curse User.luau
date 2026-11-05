  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.StatsHandler);
local _ = PathShortcuts.ClientAssets;
local v1 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
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
            ["Yen Coin"] = {
                DefaultKeybind = "E",
                Equipped = true
            },
            Twister = {
                DefaultKeybind = "R",
                Equipped = true
            },
            ["Shock Stab"] = {
                DefaultKeybind = "T",
                Equipped = true
            },
            ["Ice Breath"] = {
                DefaultKeybind = "Y",
                Equipped = true
            },
            ["Perfume Femur Magna"] = {
                DefaultKeybind = "G",
                Equipped = true
            },
            ["Shadow Burst"] = {
                DefaultKeybind = "V",
                Equipped = true
            },
            ["Root Stab"] = {
                DefaultKeybind = "Q",
                Equipped = true
            }
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    QuoteInfo = require(script.Quotes),
    Sounds = {}
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
v1.Stats["Yen Coin"] = {
    From = "Killer Queen.Yen Coin",
    Bypass = true,
    Actionable = {
        Summoned = false
    }
};
v1.Stats.Twister = {
    From = "Kuro Claws.Twister"
};
v1.Stats["Shock Stab"] = {
    From = "Locke.Shock Stab"
};
v1.Stats["Perfume Femur Magna"] = {
    From = "Mero.Perfume Femur Magna"
};
v1.Stats["Ice Breath"] = {
    From = "Weather Report.Ice Breath"
};
v1.Stats["Shadow Burst"] = {
    From = "Xeno.Shadow Burst"
};
v1.Stats["Root Stab"] = {
    From = "Gold Experience Requiem.Root Stab"
};

return v1;