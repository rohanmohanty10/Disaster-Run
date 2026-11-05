  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientAssets = require(ReplicatedStorage.ReplicatedModules.PathShortcuts).ClientAssets;

return {
    LightHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                AutoSerialize = true,
                Particle = ClientAssets.Assets.Abilities.Garou.Particles.HitFX
            }
        }
    },
    BarrageHit = {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V3",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                AutoSerialize = true,
                Particle = ClientAssets.Assets.Abilities.Garou.Particles.BarrageHit
            }
        }
    },
    LMBHits = { {
            SoundId = 79572656234128,
            Volume = 2
        }, {
            SoundId = 79572656234128,
            Volume = 2
        }, {
            SoundId = 79572656234128,
            Volume = 2
        }, {
            SoundId = 97081969735106,
            Volume = 2
        } },
    PressueWaveKickHitSound = {
        SoundId = 134462165357690,
        Volume = 2
    },
    ReverseCurrentHitSounds = { {
            SoundId = 127075940805115,
            Volume = 2
        }, {
            SoundId = 114084519346688,
            Volume = 2
        } }
};