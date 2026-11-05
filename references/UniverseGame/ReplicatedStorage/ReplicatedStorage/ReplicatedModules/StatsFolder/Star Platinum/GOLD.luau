  

 

return {
    Inherit = {
        AbilityName = "Star Platinum"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 241, 38)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 191, 0)) }),
            LeaveParts = { "StandHumanoidRootPart", "FakeHead" }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 9853773721,
            Volume = 2.5,
            Looped = true
        }
    }
};