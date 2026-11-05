  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local v1 = PathShortcuts.ClientAssets["Made In Heaven"];

return {
    LightHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = v1.Hit.Light
            }
        }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = v1.Hit.Heavy
            }
        }
    },
    BloodHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = v1.Hit.Blood
            }
        }
    },
    LMB1Hit = {
        SoundId = 13137414339,
        Volume = 2
    },
    LMB2Hit = {
        SoundId = 13137414531,
        Volume = 2
    },
    LMB3Hit = {
        SoundId = 13137415134,
        Volume = 2
    },
    LMB4Hit = {
        SoundId = 13137415281,
        Volume = 2
    }
};