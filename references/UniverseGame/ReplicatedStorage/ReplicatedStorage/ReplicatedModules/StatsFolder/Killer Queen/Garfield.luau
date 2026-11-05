  

 

return {
    Inherit = {
        AbilityName = "Killer Queen"
    },
    Animations = {
        Action = {
            PoseIdle = 13033741976
        },
        Idle = {
            Idle = 13033738940
        }
    },
    Stats = {
        Summon = {
            SummonV2 = true,
            AuraColour = ColorSequence.new(Color3.fromRGB(255, 170, 1)),
            Properties = {
                Brightness = 1
            }
        },
        Pose = {
            SkipTransition = true
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 10842835858,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = 6417693074,
            Volume = 4
        },
        ["Desummon-SFX"] = {
            SoundId = 10919876810,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 13034759703,
            Volume = 2,
            Looped = true
        }
    }
};