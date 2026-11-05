  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.GetService("EffectService");
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(29, 49, 62)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 181, 125)) })
        },
        Pose = {
            BPM = 174,
            PrimaryColor = Color3.new(0.360784, 1, 0.466667),
            SecondaryColor = Color3.new(0, 0, 0)
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 10393622964,
            Volume = 2
        },
        SummonEffects = {
            SoundId = 13117040200,
            Volume = 2
        },
        Desummon = {
            SoundId = 13117040323,
            Volume = 2
        }
    },
    Animations = {
        Action = {
            PoseTransition = 13397585331,
            PoseIdle = 13397584290,
            StandOffPoseTransition = 13397583351,
            StandOffPoseIdle = 13397582750
        }
    }
};