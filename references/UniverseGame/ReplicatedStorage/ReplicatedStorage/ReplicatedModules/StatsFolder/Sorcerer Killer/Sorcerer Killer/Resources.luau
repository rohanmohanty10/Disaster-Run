  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets;

return {
    LightHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit/Physical",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    SkullHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit/Physical",
                AutoSerialize = true,
                LookAt = "Attacker",
                PartName = "Head"
            } }
    },
    BloodHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit/Blood",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    BleedHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit/Bleed",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    SplitSoulKatanaRushAttackSFX = {
        SoundId = 18948755795,
        Volume = 0.5
    },
    SplitSoulKatanaRushAttackKickSFX = {
        SoundId = 18948755555,
        Volume = 1
    },
    SplitSoulKatanaRushAttackFinisherSFX = {
        SoundId = 18948756343,
        Volume = 0.5
    },
    PlayfulCloudRushAttackSFX = {
        SoundId = 18948752729,
        Volume = 2
    },
    PlayfulCloudRushAttackFinisherSFX = {
        SoundId = 18948752996,
        Volume = 2
    },
    InvertedSpearRushAttackSFX = {
        SoundId = 18948754490,
        Volume = 2
    },
    InvertedSpearRushAttackFinisherSFX = {
        SoundId = 18948754707,
        Volume = 2
    },
    UnrelentingAssaultSFX = {
        SoundId = 18948747325,
        Volume = 2
    },
    UnwaveringFlurrySFX = {
        SoundId = 18948879546,
        Volume = 2
    },
    UnwaveringFlurryFinisherSFX = {
        SoundId = 18948751368,
        Volume = 2
    },
    RMBHit = {
        SoundId = 102128319228607,
        Volume = 2
    },
    RMBFinisher = {
        SoundId = 111197711401501,
        Volume = 2
    },
    ChainOfAThousandMilesSFX = {
        SoundId = 139181259674537,
        Volume = 2
    },
    ChainOfAThousandMilesFinisherSFX = {
        SoundId = 97177478928268,
        Volume = 2
    },
    ShrapnelStormSFX = {
        SoundId = 18948748173,
        Volume = 2
    },
    WhirlwindBreaker = {
        SoundId = 18948749184,
        Volume = 2
    }
};