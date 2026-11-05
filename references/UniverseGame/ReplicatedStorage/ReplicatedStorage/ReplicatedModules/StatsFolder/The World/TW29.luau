  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The World"
    },
    Animations = {
        Idle = {
            Idle = 9836884589
        }
    },
    Stats = {
        Summon = {
            SummonV2 = true,
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 235, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(108, 175, 211)) }),
            CustomTransparency = {
                ["Meshes/world29_NurbsPath (1)"] = {
                    SummonTransparency = 0.4
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 9837126335,
            Volume = 3,
            PlaybackSpeed = 0.669,
            Looped = true
        }
    }
};