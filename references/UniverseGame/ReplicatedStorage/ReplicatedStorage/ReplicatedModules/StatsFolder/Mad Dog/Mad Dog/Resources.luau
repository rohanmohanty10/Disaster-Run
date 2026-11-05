  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
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

    WeldTo = function(p1, p2, p3) -- Line: 35, Name: WeldTo
        p3.CFrame = p1;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p2;
        WeldConstraint.Part1 = p3;
        WeldConstraint.Parent = p3;

        return WeldConstraint;
    end,

    LMB4HitSFX = {
        Hit = {
            SoundId = 97250350836283,
            Volume = 1
        }
    },
    Bleed = {
        Name = "Bleed",
        Stats = {
            Damage = 2,
            Priority = Enums.Intangible.Move,
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BypassCounter = true
            }
        }
    }
};