  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local ClientAssets = PathShortcuts.ClientAssets;

return {
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    SoundInfo = {
        LMB = {
            Hit = {
                SoundId = 18179078077,
                Volume = 1
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
                Offset = CFrame.Angles(0, 3.141592653589793, 0),
                Color = Color3.fromRGB(255, 255, 255)
            }
        }
    },
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
                Particle = ClientAssets.Universal.Universal_HitVFX,
                Color = Color3.fromRGB(255, 255, 255)
            }
        }
    },
    ObladiHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = ClientAssets.Assets.Abilities["Wonder Of U"].Particles.ObladiInsectHit,
                Color = Color3.fromRGB(0, 0, 0)
            }
        }
    },
    BlackHit = {
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
                Color = Color3.fromRGB(0, 0, 0)
            }
        }
    }
};