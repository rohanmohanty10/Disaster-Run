  

 

game:GetService("ReplicatedStorage");

return {
    Inherit = {
        AbilityName = "Sticky Fingers"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 96, 203)), ColorSequenceKeypoint.new(1, Color3.fromRGB(224, 141, 247)) })
        }
    }
};