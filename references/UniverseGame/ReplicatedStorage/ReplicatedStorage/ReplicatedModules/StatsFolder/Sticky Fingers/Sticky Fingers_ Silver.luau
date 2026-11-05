  

 

game:GetService("ReplicatedStorage");

return {
    Inherit = {
        AbilityName = "Sticky Fingers"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(183, 187, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 91, 106)) })
        }
    }
};