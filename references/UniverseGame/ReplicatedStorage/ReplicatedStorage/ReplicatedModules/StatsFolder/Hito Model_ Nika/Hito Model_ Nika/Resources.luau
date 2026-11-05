  

 

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
    Gear5Hit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Gear5/Hit",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    StarGunWhirl = {
        Hit = {
            SoundId = 18896291566,
            Volume = 2
        }
    },
    StarGunPunch = {
        Hit = {
            SoundId = 18896292811,
            Volume = 2
        }
    },
    HawkPistol = {
        Hit = {
            SoundId = 77835788423768,
            Volume = 2
        }
    },
    HawkHit = {
        Hit = {
            SoundId = 140031794517616,
            Volume = 2
        }
    }
};