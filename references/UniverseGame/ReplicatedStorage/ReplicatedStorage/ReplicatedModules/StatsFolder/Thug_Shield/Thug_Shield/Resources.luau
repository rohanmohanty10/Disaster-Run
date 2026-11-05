  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local ClientAssets = PathShortcuts.ClientAssets;

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
                Particle = ClientAssets.Universal.Universal_HitVFX
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
                Particle = ClientAssets.Universal.UniversalHeavyVFX
            }
        }
    },
    LMBHit1 = {
        SoundId = 15549253225,
        Volume = 2
    },
    LMBHit2 = {
        SoundId = 15549253583,
        Volume = 2
    },
    LMBHit3 = {
        SoundId = 15549253474,
        Volume = 2
    },
    HeavyHitSound = {
        SoundId = 15549253676,
        Volume = 2
    }
};