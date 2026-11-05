  

 

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
            PrimaryColor = Color3.fromRGB(109, 136, 170),
            SecondaryColor = Color3.fromRGB(40, 40, 43)
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 10005342019,
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