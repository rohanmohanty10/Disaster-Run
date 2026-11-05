  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.GetService("EffectService");
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "δ: FOR THE DELTA"
    },
    Sounds = {
        PoseMusic = {
            SoundId = "rbxassetid://123424896159339",
            PlaybackSpeed = 1.2345679012345678,
            Volume = 0
        }
    }
};