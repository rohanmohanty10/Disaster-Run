  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(Knit.Util.Trove);
Knit.OnStart():await();
Knit.GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Anubis"
    },
    Animations = {
        Action = {
            PoseIdle = 17038256483,
            PoseTransition = 17038262681
        },
        Idle = {
            Idle = 17025627027
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 17026054466,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 17026054048,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 17026054701,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 17026054304,
            Volume = 1
        },
        ["Cursed Descent"] = {
            SoundId = 14338021613,
            Volume = 1
        },
        ["Accursed Laceration"] = {
            SoundId = 17026053653,
            Volume = 1
        },
        Slam = {
            SoundId = 14338029133,
            Volume = 1
        },
        ["Soul Severance"] = {
            SoundId = 17026053236,
            Volume = 1
        },
        Shadowstrike = {
            SoundId = 17026052842,
            Volume = 1
        },
        ["Phantom Finisher"] = {
            SoundId = 17026051012,
            Volume = 1
        },
        ["Phantom Finisher Success"] = {
            SoundId = 17026050659,
            Volume = 1
        },
        ["Achilles Strike"] = {
            SoundId = 15105832612,
            Volume = 1
        },
        Flash = {
            SoundId = 17026049427,
            Volume = 1
        },
        Awakening = {
            SoundId = 17026052107,
            Volume = 1
        },
        AwakeningVoice = {
            SoundId = 17038307455,
            Volume = 1
        },
        AwakeningAmbience = {
            SoundId = 17026051423,
            Volume = 1,
            Looped = true
        },
        Command = {
            SoundId = 17026049729,
            Volume = 1
        },
        CommandSuccess = {
            SoundId = 17026052380,
            Volume = 1
        },
        CommandSuccessVoice = {
            SoundId = 17038278446,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 17039571141,
            Volume = 1.3,
            Looped = true
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
                    SoundId = "rbxassetid://17038277301",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Prepare to have your ham spanked!"
                        } }
                }, {
                    SoundId = "rbxassetid://17038327728",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Time to put on my battle knowledge to the test!"
                        } }
                }, {
                    SoundId = "rbxassetid://17038278013",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Oh, I was just punching you because you\'re an evil dude. What\'s the probs?"
                        } }
                } }
        }
    }
};