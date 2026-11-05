  

 

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 26, 62)), ColorSequenceKeypoint.new(1, Color3.fromRGB(146, 86, 181)) })
        },
        Pose = {
            BPM = 174,
            PrimaryColor = Color3.new(0.772549, 0.619608, 1),
            SecondaryColor = Color3.new(0.0705882, 0.0509804, 0.0862745)
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 10405459319,
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
    }
};