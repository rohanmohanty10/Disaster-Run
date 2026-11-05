  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets;

return {
    Blood = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit",
                LookAt = "Attacker"
            } }
    },
    LMB1 = {
        SoundId = 127133844363468,
        Volume = 2
    },
    LMB2 = {
        SoundId = 119100891045547,
        Volume = 2
    },
    ConescutiveSlashes1 = {
        SoundId = 79798046190905,
        Volume = 2
    },
    ConescutiveSlashes2 = {
        SoundId = 105856594215238,
        Volume = 2
    },
    FierceCombo1 = {
        SoundId = 120564409653331,
        Volume = 2
    },
    FierceCombo2 = {
        SoundId = 74300445786142,
        Volume = 2
    }
};