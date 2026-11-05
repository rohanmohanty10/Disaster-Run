  

 

return {
    Inherit = {
        AbilityName = "D4C: Love Train"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 5, 95)), ColorSequenceKeypoint.new(1, Color3.fromRGB(98, 0, 179)) })
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 10216139352,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1
                }
            }
        },
        LovetrainMusic = {
            SoundId = "rbxassetid://10216139352",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1
                }
            }
        }
    }
};