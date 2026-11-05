  

 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local _ = game.GameId == 1782832995;
local v1 = ReplicatedStorage["Client Assets"];
({
    Name = "Output"
}).Arguments = {
    "FX",
    "HitEffect V3",
    {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Scythe",
        AutoSerialize = true,
        LookAt = "Attacker",
        PathFolder = v1
    }
};
({
    Name = "Output"
}).Arguments = {
    "FX",
    "HitEffect V3",
    {
        Attacker = "__Attacker",
        Target = "__Target",
        AutoSerialize = true,
        LookAt = "Attacker",
        Particle = v1.Reaper.HitEffects.Light
    }
};

return {
    Stats = {},
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            },
            Base = {
                Visible = true
            },
            Saiyan = {
                Visible = false
            },
            ["Saiyan God"] = {
                Visible = false
            },
            ["Ultra Instinct"] = {
                Visible = false
            }
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            One = "Base",
            Two = "Super Saiyan",
            Three = "Super Saiyan God",
            Four = "Ultra Instinct",
            E = "EMoves",
            R = "RMoves",
            T = "TMoves",
            Y = "YMoves",
            G = "GMoves",
            B = "BMoves",
            H = "Senzu Bean",
            K = "Kaioken",
            V = "Instant Transmission",
            X = "Grab",
            C = "Quickstep",
            F = "Block",
            P = "Pose"
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10447330139,
            ["LMB-2"] = 10447335715,
            ["LMB-3"] = 10447337080,
            ["LMB-4"] = 10447338237,
            Kiai = 8995536447,
            ["Meteor Strike"] = 11468346868,
            ["Kamehameha Start"] = 9000242051,
            ["Kamehameha Loop"] = 9000243142,
            ["Kamehameha Fire"] = 9000243952,
            ["Kamehameha Max"] = 9000245195,
            Kamehameha = 8995538852,
            Transform = 10446762289,
            Jajanken = 8995545277,
            ["Instant Transmission"] = 8995547401,
            ["Explosive Wave"] = 8995549434,
            ["Senzu Bean"] = 8995553609,
            ["Destructo Disc"] = 8995557234,
            ["Solar Flare"] = 8995559419,
            ["Dragon Throw Attempt"] = 9000247100,
            ["Dragon Throw"] = 9000248965,
            ["Meteor Smash Attempt"] = 9000250472,
            ["Meteor Smash"] = 9000253195,
            ["Gut Punch"] = 9000272839,
            Transcendence = 9000274037,
            Barrage = 10455636567,
            ["Meteor Combination Attempt"] = 9083907352,
            ["Meteor Combination"] = 9083910504,
            ["Spirit Bomb Start"] = 9083935295,
            ["Spirit Bomb Loop"] = 9083929820,
            ["Spirit Bomb"] = 9083937924,
            Godbind = 9083940979,
            ["Grudgeless Strike"] = 9083945838,
            ["Super God Fist"] = 9083952828,
            ["Super God Shock Flash"] = 9083956238,
            ["Celestial Whirlwind Pose"] = 9083969948,
            ["Celestial Whirlwind"] = 9083973324,
            ["Instinct Pose"] = 9083978473,
            Instinct = 9083984834,
            ["Autonomous Fist"] = 9083993691,
            ["Unpolished Instinct"] = 9083996482
        },
        Movement = {
            Run = 10455589469,
            Walk = 10455591976
        },
        Idle = {
            Idle = 10455579066
        }
    },
    Sounds = {}
};