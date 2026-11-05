  

 

return {
    Inherit = {
        AbilityName = "Crazy Diamond"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://15080427316",
                        Volume = 2
                    }
                }
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://15080428037",
                        Volume = 0.85
                    }
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = "rbxassetid://15080429463",
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.8
                }
            }
        },
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://15080428645",
            Volume = 1.5
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://15080428220"
        }
    }
};