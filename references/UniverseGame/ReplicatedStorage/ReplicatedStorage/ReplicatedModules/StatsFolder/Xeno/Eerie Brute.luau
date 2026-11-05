  

 

return {
    Inherit = {
        AbilityName = "Xeno"
    },
    Stats = {
        Summon = {
            SummonV2 = true,
            LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 66, 66)) })
        }
    }
};