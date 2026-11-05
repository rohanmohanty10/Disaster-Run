  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);

return {
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    Hit = {
        Name = "Output",
        Arguments = {
            "FX",
            "Shadow_Hit",
            {
                Attacker = "__Attacker",
                Target = "__Target",
                LookAt = "Attacker",
                Particle = PathShortcuts.ClientAssets.Universal.BloodVFX
            }
        }
    },
    ExplosionHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/ExplosionHit",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    HitSounds = {
        LooseCannon = {
            SoundId = 97243675831815,
            Volume = 2
        },
        StrikerBombs = {
            SoundId = 112423779926177,
            Volume = 0.75
        },
        StrikerBombsMode = {
            SoundId = 80241737467800,
            Volume = 2
        },
        Crossbow = {
            SoundId = 93969770700143,
            Volume = 2
        },
        CrossbowMode = {
            SoundId = 135995616491556,
            Volume = 2
        },
        LMBS = {
            SoundId = 129810738988168,
            Volume = 2
        },
        LegSlicer = {
            SoundId = 94738703936495,
            Volume = 2
        },
        SwordCombo = {
            SoundId = 127662166028860,
            Volume = 2
        },
        SwordChargeMode = {
            SoundId = 112368641073339,
            Volume = 2
        }
    }
};