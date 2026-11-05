  

 

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
            ["Flash Combo"] = {
                DefaultKeybind = "E",
                Equipped = true
            },
            ["Twofold Kick"] = {
                DefaultKeybind = "R",
                Equipped = true
            },
            ["Rapid Blows"] = {
                DefaultKeybind = "T",
                Equipped = true
            },
            ["Axe Kick"] = {
                DefaultKeybind = "G",
                Equipped = true
            }
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    QuoteInfo = require(script.Quotes),
    Sounds = {
        FlashCombo = {
            SoundId = 15587937646,
            Volume = 2
        },
        TwofoldKick = {
            SoundId = 15105163133,
            Volume = 2
        },
        AxeKick = {
            SoundId = 17503293901,
            Volume = 2
        },
        AxeKickHit = {
            SoundId = 17503293527,
            Volume = 2
        }
    }
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
v1.Stats["Flash Combo"] = {
    From = "The Strongest.Flash Combo"
};
v1.Stats["Twofold Kick"] = {
    From = "The Strongest.Twofold Kick (Base)"
};
v1.Stats["Rapid Blows"] = {
    From = "The Vessel.Rapid Blows"
};
v1.Stats["Axe Kick"] = {
    From = "King of Curses.Axe Kick (Ground)",
    Active = true,
    Actionable = {
        Active = true
    }
};

return v1;