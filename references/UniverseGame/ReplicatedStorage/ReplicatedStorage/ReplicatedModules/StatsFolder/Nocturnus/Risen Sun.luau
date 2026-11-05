  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];

return {
    Inherit = {
        AbilityName = "Nocturnus"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 245, 94)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 157, 47)) })
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 9839056887,
            Volume = 2,
            Looped = true
        }
    }
};