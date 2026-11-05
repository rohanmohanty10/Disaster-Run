  

 

return {
    Inherit = {
        AbilityName = "D4C"
    },
    Stats = {
        Summon = {
            LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(89, 89, 89)), ColorSequenceKeypoint.new(1, Color3.fromRGB(113, 113, 113)) })
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 137824454520518,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = ""
        },
        ["Desummon-SFX"] = {
            SoundId = 114137080149005,
            Volume = 2
        },
        StandPoseMusic = {
            SoundId = 85783858700376,
            Volume = 2,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.325
                }
            }
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://131283218497492",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Do you like scary movies?"
                        } }
                }, {
                    SoundId = "rbxassetid://129994233073100",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Movies don\'t make psychos. They make psychos more creative!"
                        } }
                }, {
                    SoundId = "rbxassetid://129081355591565",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re dead already. You just don\'t know it."
                        } }
                } }
        }
    }
};