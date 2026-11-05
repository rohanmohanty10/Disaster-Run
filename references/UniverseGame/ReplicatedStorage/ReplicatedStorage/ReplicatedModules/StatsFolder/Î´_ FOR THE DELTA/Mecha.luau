  

 

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
            SoundId = 83321697406855,
            Volume = 3
        }
    }
};