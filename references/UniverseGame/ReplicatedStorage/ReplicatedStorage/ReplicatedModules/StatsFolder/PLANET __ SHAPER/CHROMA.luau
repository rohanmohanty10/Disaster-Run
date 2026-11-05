  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets;
local _ = Knit.CollectionService;
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(61, 62, 62)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 218, 218)) })
        },
        Pose = {
            BPM = 174,
            PrimaryColor = Color3.new(1, 1, 1),
            SecondaryColor = Color3.new(0, 0, 0)
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 12365905856,
            Volume = 2
        }
    }
};