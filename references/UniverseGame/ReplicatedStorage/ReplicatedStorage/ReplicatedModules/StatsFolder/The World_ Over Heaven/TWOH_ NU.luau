  

 

({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Global/Light",
        AutoSerialize = true,
        LookAt = "Attacker"
    } };

return {
    Inherit = {
        AbilityName = "The World: Over Heaven"
    },
    Stats = {
        ["Heavy Punch"] = {
            HitSounds = {
                Hit = {
                    SoundId = 6947964914,
                    Volume = 2
                }
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Global/Heavy",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } }
        }
    },
    Sounds = {
        KickVoice = {
            SoundId = 6952410161,
            Volume = 3
        },
        KickWindup = {
            SoundId = 6952409901,
            Volume = 2
        },
        ["Heavy Punch Voice"] = {
            SoundId = 6946568229,
            Volume = 2
        },
        ["Heavy Punch Woosh"] = {
            SoundId = 7290136592,
            Volume = 2
        },
        ["Fissure Woosh"] = {
            SoundId = 6946564744,
            Volume = 2
        },
        ["Fissure Voice"] = {
            SoundId = 6946565827,
            Volume = 2
        },
        ["Overwrite Infusion Woosh"] = {
            SoundId = 6943693575,
            Volume = 2
        },
        ["Overwrite Infusion Voice"] = {
            SoundId = 6943797850,
            Volume = 2
        },
        ["Rampage Force Hit"] = {
            SoundId = 6952367286,
            Volume = 2
        },
        ["Rampage Force Voice"] = {
            SoundId = 6952413863,
            Volume = 2
        },
        ["Reality Overwrite"] = {
            SoundId = 6956030388,
            Volume = 2
        },
        ["Reality Overwrite Voice"] = {
            SoundId = 6956056280,
            Volume = 2
        },
        Teleport = {
            SoundId = 6934988582,
            Volume = 2
        },
        ["Timestop Voice"] = {
            SoundId = 6946567723,
            Volume = 2
        },
        SummonSound = {
            SoundId = 6942187805,
            Volume = 2
        },
        SummonEffects = {
            SoundId = 6942186975,
            Volume = 2
        },
        Desummon = {
            SoundId = 6943345471,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 9073383548,
            Volume = 2,
            Looped = true
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 6942193924,
            ["LMB-2"] = 6942194844,
            ["LMB-3"] = 6942195599,
            ["LMB-4"] = 6942196256,
            ["Heavy Punch"] = 6944002089,
            Timestop = 6943779788,
            PoseTransition = 8060217789,
            PoseIdle = 8060216135
        },
        Movement = {
            SummonedWalk = 6877996750,
            SummonedRun = 7037969480,
            Walk = 6877996750,
            Run = 7037969480
        },
        Idle = {
            SummonedIdle = 6943969490,
            Idle = 6943911515
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
                    SoundId = "rbxassetid://6943346557",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My hands are that which create truth!"
                        } }
                }, {
                    SoundId = "rbxassetid://6943347162",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "We\'ll see whose truth reigns supreme!"
                        } }
                }, {
                    SoundId = "rbxassetid://6943346932",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll end your life myself."
                        } }
                } }
        }
    }
};