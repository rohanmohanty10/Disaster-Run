  

 

local v1 = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local v2 = {
    Name = "Output",
    Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
};
local v3 = {
    HitRemotes = { v2 },
    HitData = {
        Effect = v1["Star Platinum"]["Estival Platinum"].Effects.Hit
    },
    HitSounds = {
        Hit = {
            SoundId = 10454447593,
            Volume = 3
        }
    }
};
local v4 = {
    HitRemotes = { v2 },
    HitData = {
        Effect = v1["Star Platinum"]["Estival Platinum"].Effects.Heavy,
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 10458906256,
            Volume = 3
        }
    }
};

return {
    Inherit = {
        AbilityName = "Star Platinum"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 100, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 125, 255)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = v3,
            ["LMB-4"] = v4,
            ["StandOff-LMB-1"] = v3,
            ["StandOff-LMB-4"] = v4
        },
        EMoves = {
            Barrage = {
                Hit = v3,
                Finisher = v4
            },
            ["Grab Slam"] = v4
        },
        RMoves = {
            ["Star Breaker"] = v4,
            ["Lock Kick"] = v3
        },
        TMoves = {
            ["Star Finger"] = v3,
            ["Evil Spirit"] = v3
        },
        ["Ora Slam"] = v4,
        ["Destructive Combination"] = {
            Hit = v3,
            Throw = v4
        },
        ["Brute Force"] = {
            Hit = v3,
            Finisher = v4
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = "rbxassetid://10398476989",
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {}
        }
    }
};