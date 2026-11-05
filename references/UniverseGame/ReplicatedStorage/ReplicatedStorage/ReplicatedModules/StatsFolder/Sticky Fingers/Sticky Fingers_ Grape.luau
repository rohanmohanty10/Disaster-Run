  

 

game:GetService("ReplicatedStorage");

return {
    Inherit = {
        AbilityName = "Sticky Fingers"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 88, 227)), ColorSequenceKeypoint.new(1, Color3.fromRGB(156, 120, 247)) })
        }
    }
};