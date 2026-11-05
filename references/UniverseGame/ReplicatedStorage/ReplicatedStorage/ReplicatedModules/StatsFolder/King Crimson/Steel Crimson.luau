  

 

local v1 = game:GetService("ReplicatedStorage")["Client Assets"];
local v2 = {
    Name = "Output",
    Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
};
local v3 = {
    HitRemotes = { v2 },
    HitData = {
        Effect = v1["Star Platinum"]["Estival Platinum"].Effects.Hit
    }
};
local v4 = {
    HitRemotes = { v2 },
    HitData = {
        Effect = v1["Star Platinum"]["Estival Platinum"].Effects.Heavy,
        Offset = CFrame.Angles(0, 3.141592653589793, 0)
    }
};

return {
    Inherit = {
        AbilityName = "King Crimson"
    },
    Stats = {
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
            CleavingStrikes = {
                Hit = v3,
                Finisher = v4
            }
        },
        RMoves = {
            Chop = v3,
            Impale = {
                Attempt = v4
            },
            GroundSlam = v4
        },
        TMoves = {
            DownwardStrike = {
                DirectHit = v3
            },
            SuddenBlow = {
                Attack = v4
            }
        },
        GMoves = {
            FierceGrab = {
                Grab = v3,
                Throw = v4
            }
        }
    }
};