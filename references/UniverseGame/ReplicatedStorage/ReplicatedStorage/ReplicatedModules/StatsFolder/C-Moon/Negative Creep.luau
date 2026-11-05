  

 

return {
    Inherit = {
        AbilityName = "C-Moon"
    },
    Stats = {
        Summon = {
            From = "Combat.Summon",
            LeaveParts = { "head 2", "StandHumanoidRootPart" },
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 106, 106)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        }
    },
    Sounds = {}
};