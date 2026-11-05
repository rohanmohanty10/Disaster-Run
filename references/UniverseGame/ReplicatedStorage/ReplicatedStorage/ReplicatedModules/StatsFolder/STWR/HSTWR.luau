  

 

return {
    Inherit = {
        AbilityName = "STWR"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 60, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) })
        },
        ["LMB Combo"] = {
            HitData = {
                Color = Color3.fromRGB(255, 85, 0)
            }
        },
        HeavyPunch = {
            HitData = {
                Color = Color3.fromRGB(255, 85, 0)
            }
        },
        Barrage = {
            HitData = {
                Color = Color3.fromRGB(255, 85, 0)
            }
        }
    },
    Sounds = {
        ["LMB Combo"] = {
            SoundId = 5287671885
        },
        ["Arrow Shoot"] = {
            SoundId = 2553983089
        },
        ["Cursed Uppercut"] = {
            SoundId = 1238240873
        },
        ["Arrow Inversion"] = {
            SoundId = 2553983089
        },
        PoseMusic = {
            Looped = true,
            SoundId = 8573404642,
            PlaybackSpeed = 1,
            Volume = 2
        },
        Knives = {
            Looped = false,
            SoundId = 6663265333,
            Volume = 3
        }
    }
};