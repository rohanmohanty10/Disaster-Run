  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit).GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Reaper"
    },
    Sounds = {
        PoseMusic = {
            Looped = true,
            SoundId = 18419318984,
            Volume = 2.5
        }
    }
};