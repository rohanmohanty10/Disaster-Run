  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(Knit.Util.Trove);

return {
    Inherit = {
        AbilityName = "Ichigo Kurosaki"
    },
    Sounds = {
        ["LMB-1-Voiceline"] = {
            SoundId = 78285568170825,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 95847238581733,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 117450854082182,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 137563659819126,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 137242180319563,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 107972574560650,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 103873634072202,
            Volume = 1,
            Looped = true
        },
        BankaiPoseMusic = {
            SoundId = 103873634072202,
            Volume = 1,
            Looped = true
        },
        ["Sonido Blitz Startup Voiceline"] = {
            SoundId = 1,
            Volume = 1
        },
        ["Blade Combo Voiceline"] = {
            SoundId = 72408877157007,
            Volume = 1
        },
        ["Blade Combo Startup Voiceline"] = {
            SoundId = 86446730067011,
            Volume = 1
        },
        ["Vasto Lorde Transformation Voiceline"] = {
            SoundId = 79051902002301,
            Volume = 1
        },
        ["Zangetsu Voiceline"] = {
            SoundId = 101964251211332,
            Volume = 1
        },
        ["Destructive Barrage Voiceline 1"] = {
            SoundId = 101509522902108,
            Volume = 1
        },
        ["Destructive Barrage Voiceline 2"] = {
            SoundId = 74088323906400,
            Volume = 1
        },
        ["Blade Slam Voiceline 1"] = {
            SoundId = 107546838393440,
            Volume = 1
        },
        ["Blade Slam Voiceline 2"] = {
            SoundId = 104098359126570,
            Volume = 1
        },
        ["Spiritual Pressure Voiceline 1"] = {
            SoundId = 71238853446314,
            Volume = 1
        },
        ["Spiritual Pressure Voiceline 2"] = {
            SoundId = 105836381421774,
            Volume = 1
        },
        ["Heavy Attack Voiceline 1"] = {
            SoundId = 1367740631686,
            Volume = 1
        },
        ["Heavy Attack Voiceline 2"] = {
            SoundId = 80833899465372,
            Volume = 1
        },
        ["Hollowfy Voiceline 1"] = {
            SoundId = 116930075812914,
            Volume = 1
        },
        ["Hollowfy Voiceline 2"] = {
            SoundId = 134669672837311,
            Volume = 1
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://125623987433384",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What a loser..."
                        } }
                },
                {
                    SoundId = "rbxassetid://109091969286206",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "If you die I\'m in trouble..."
                        } }
                },
                {
                    SoundId = "rbxassetid://81911480125779",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Too easy!"
                        } }
                },
                {
                    SoundId = "rbxassetid://131129450017944",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Just forget it!"
                        } }
                },
                {
                    SoundId = "rbxassetid://123418545193189",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What!?"
                        } }
                },
                {
                    SoundId = "rbxassetid://108231778839563",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Whaddya know..."
                        } }
                },
                {
                    SoundId = "rbxassetid://86825091822202",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re really hopeless, aren\'t you?"
                        } }
                },
                {
                    SoundId = "rbxassetid://123953820339057",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Okay, you ready?"
                        } }
                },
                {
                    SoundId = "rbxassetid://84925972847843",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I AM Zangetsu."
                        } }
                },
                {
                    SoundId = "rbxassetid://116565027244695",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = {
                        {
                            Quote = "I must admit it never ceases to amaze me how BRAINLESS you can be. You\'ve lost your weapon, why are you just standing there?? Ichigo! What\'s the difference between a king and his horse? And I\'m not talking about obvious stuff like one\'s an animal and one\'s a person, or one has two legs and one has four...FORM, ABILITY, AND POWER! That\'s what\'s puzzling! If their form, ability, and power are exactly the same, why\'s it that one becomes the king and leads them into battle, while the other becomes the horse and carries the king?? So what\'s the characteristic that distinguishes these two beings???? There\'s only one answer: INSTINCT! In order for identical beings to get stronger and gain power, they need to develop a killer instinct...and that INSTINCT is mostly formed in battle! They must develop an insatiable hunger to ENGAGE in battle...they must LIVE to mercilessly crush, shred, and slice their enemies! This thirst for power is not an unnatural desire. In fact, it forms the very essence of our being...deep within our body lies the honed instinct to DOMINATE and SLAUGHTER our enemy! My friend you don\'t have that! You use your BRAIN to try and win a fight! You attempt to defeat your enemies with reason and logic! You don\'t tap into those pure base instincts that exist within your core, WAITING to be released! And the simple matter is it doesn\'t work: you\'re weak! I won\'t put up with that. Am I clear? I don\'t know about Zangetsu, but I refuse to play horse to a king who\'s weaker than me. Someone who\'s uncertainty and hesitation will end up getting us both cut to PIECES. If you aren\'t willing to assert your strength and retain the crown, then I\'ll destroy you...which means...I\'ll be king. "
                        }
                    }
                }
            }
        }
    }
};