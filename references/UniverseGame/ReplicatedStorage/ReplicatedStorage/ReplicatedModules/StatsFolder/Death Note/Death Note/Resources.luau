  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local ClientAssets = PathShortcuts.ClientAssets;

return {
    Hit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = ClientAssets.Universal.Universal_HitVFX,
                Color = Color3.fromRGB(255, 255, 255)
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
                Particle = ClientAssets.Universal.UniversalHeavyVFX,
                Color = Color3.fromRGB(255, 255, 255)
            }
        }
    }
};