  

 

game:GetService("ReplicatedStorage");

return {
    Inherit = {
        AbilityName = "Sticky Fingers"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 40, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(23, 23, 24)) })
        }
    }
};