  

 

game:GetService("ReplicatedStorage");

return {
    Inherit = {
        AbilityName = "Sticky Fingers"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(123, 227, 75)), ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 247, 122)) })
        }
    }
};