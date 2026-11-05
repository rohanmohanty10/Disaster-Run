  

 

return {
    Inherit = {
        AbilityName = "Star Platinum: The World"
    },
    Animations = {
        Action = {
            PoseIdle = 108802202017416,
            PoseTransition = 97815966220121,
            ["Bearing Shot"] = 124563048680304,
            Timestop = 123836872293602,
            ["Forced Tackle"] = 82940155593377
        }
    },
    Stats = {
        Summon = {
            VoicelineRange = 2,
            SyncVoiceline = true,
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(164, 120, 190)), ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 86, 86)) }),
            IgnoreParts = { "Stand Torso", "Stand Head", "Stand Left Arm", "Stand Right Arm", "Stand Left Leg", "Stand Right Leg", "StandHumanoidRootPart" }
        },
        ["Bearing Shot"] = {
            HitSounds = {
                Hit = {
                    SoundId = "rbxassetid://78265629002829",
                    Volume = 3
                }
            }
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            },
            Resolve = {
                Visible = false
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://109695298220129",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I was one step... too late."
                        } }
                }, {
                    SoundId = "rbxassetid://132928814069598",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It\'s not enough... 5 seconds is just not enough!"
                        } }
                }, {
                    SoundId = "rbxassetid://99186492529576",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Just now, that was my stand, Star Platinum."
                        } }
                } },
            Resolve = { {
                    SoundId = "",
                    SoundVolume = 2,
                    Visible = true,
                    FullQuote = { {
                            Quote = "No one could stay calm...",
                            EraseQuote = true
                        }, {
                            Quote = "After seeing something like that!"
                        } }
                } }
        }
    },
    Sounds = {
        MeterUp2 = {
            SoundId = 136814669796211,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 131713708210202,
            Volume = 2
        },
        ["Summon-Voiceline-1"] = {
            SoundId = 132250259489991,
            Volume = 2
        },
        ["Summon-Voiceline-2"] = {
            SoundId = 124358179760269,
            Volume = 2
        },
        ["Summon-SFX-1"] = {
            SoundId = 122782945865969,
            Volume = 2
        },
        ["Summon-SFX-2"] = {
            SoundId = 84851739029945,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 103195991891216,
            Volume = 1.25
        },
        ["Bearing Shot Voiceline"] = {
            SoundId = 133571867497482,
            Volume = 2
        },
        ["Bearing Shot"] = {
            SoundId = 81037494497918,
            Volume = 2
        },
        ["Timestop Voiceline"] = {
            SoundId = 85265961160615,
            Volume = 2
        },
        ["Timestop Startup"] = {
            SoundId = 73855080998572,
            Volume = 2
        },
        ["Timestop End Voiceline"] = {
            SoundId = 130247947707759,
            Volume = 2
        },
        ["Unrelenting Assault Voiceline"] = {
            SoundId = 89385378063767,
            Volume = 2
        }
    }
};