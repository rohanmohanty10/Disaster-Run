  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(Knit.Util.Trove);

return {
    Inherit = {
        AbilityName = "Anshen"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 117450913826101,
                        Volume = 2.4
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 117450913826101,
                        Volume = 2.4
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 117450913826101,
                        Volume = 2.4
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 118318593442191,
                        Volume = 3
                    }
                }
            }
        },
        ["Consecutive Slashes"] = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 138027410988880,
                        Volume = 2.4
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 84740294933046,
                        Volume = 3
                    }
                }
            }
        },
        ["Fierce Combo"] = {
            Pierce = {
                HitSounds = {
                    Hit = {
                        SoundId = 117450913826101,
                        Volume = 2.4
                    }
                }
            },
            Headbutt = {
                HitSounds = {
                    Hit = {
                        SoundId = 114271130928296,
                        Volume = 3
                    }
                }
            }
        },
        Justice = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 118318593442191,
                        Volume = 3
                    }
                }
            }
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 98, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    v2.PoseMusic = "PoseMusic" .. math.random(1, 2);

                    return v2;
                end
            }
        }
    },
    Sounds = {
        PoseMusic1 = {
            SoundId = 121384349067106,
            Looped = true,
            Volume = 2
        },
        PoseMusic2 = {
            SoundId = 76550803730782,
            Looped = true,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 97867948906884,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 72421088063362,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 124662920238835,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 108890078974483,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 86314708020952,
            Volume = 2
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 118539445006732,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 140607764507500,
            Volume = 2
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 82180477192328,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 136237937666048,
            Volume = 2
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 74189782547719,
            Volume = 2
        },
        Dash1 = {
            SoundId = 133212848762258,
            Volume = 2
        },
        Dash2 = {
            SoundId = 133212848762258,
            Volume = 2
        },
        ["Fierce Combo"] = {
            SoundId = 126327466840443,
            Volume = 2
        },
        ["Fierce Combo Voiceline"] = {
            SoundId = 81063679097774,
            Volume = 2
        },
        ["Energy Charge"] = {
            SoundId = 82189809094987,
            Volume = 2
        },
        ["Energy Charge Voiceline"] = {
            SoundId = 134628008571767,
            Volume = 2
        },
        ["Energy Charge Ambience"] = {
            SoundId = 120048227925148,
            Volume = 2,
            Looped = true
        },
        ["Consecutive Slashes"] = {
            SoundId = 97034481807455,
            Volume = 2
        },
        ["Consecutive Slashes Voiceline"] = {
            SoundId = 98137758040028,
            Volume = 2
        },
        ["Extended Slam"] = {
            SoundId = 116243663011867,
            Volume = 2
        },
        ["Extended Slam Voiceline"] = {
            SoundId = 94373355203400,
            Volume = 2
        },
        ["Extended Slam Ground"] = {
            SoundId = 126379711813063,
            Volume = 2
        },
        ["Energy Burst"] = {
            SoundId = 137551805336889,
            Volume = 2
        },
        ["Energy Burst Voiceline"] = {
            SoundId = 115641312301618,
            Volume = 1.7
        },
        ["Energy Burst Explosion"] = {
            SoundId = 86379689525615,
            Volume = 2
        },
        Justice = {
            SoundId = 137866461185150,
            Volume = 2
        },
        ["Justice Voiceline"] = {
            SoundId = 114579612336368,
            Volume = 2
        },
        ["Justice Finisher"] = {
            SoundId = 106495648907604,
            Volume = 2
        },
        ["Justice Finisher Voiceline"] = {
            SoundId = 107575647267868,
            Volume = 2
        },
        ["Horn Bash"] = {
            SoundId = 101354742361423,
            Volume = 2
        },
        ["Horn Bash Startup"] = {
            SoundId = 106237871921649,
            Volume = 2
        },
        ["Horn Bash Startup Voiceline"] = {
            SoundId = 125312504549220,
            Volume = 2
        },
        ["Horn Bash Voiceline"] = {
            SoundId = 110211389688615,
            Volume = 1.5
        },
        ["Lance Extension"] = {
            SoundId = 92880427947650,
            Volume = 2
        },
        ["Lance Extension Startup"] = {
            SoundId = 121598690130200,
            Volume = 2
        },
        ["Lance Extension Startup Voiceline"] = {
            SoundId = 105701778939857,
            Volume = 2
        },
        ["Lance Extension Voiceline"] = {
            SoundId = 74546223637551,
            Volume = 2.5
        },
        ["Cataclysm Smash"] = {
            SoundId = 85191787059257,
            Volume = 2
        },
        ["Cataclysm Smash Voiceline"] = {
            SoundId = 82696522223711,
            Volume = 2
        },
        ["Cataclysm Smash Lance"] = {
            SoundId = 111003027930391,
            Volume = 2
        },
        ["Cataclysm Smash Land"] = {
            SoundId = 72062008346293,
            Volume = 2
        },
        ["Flight Startup"] = {
            SoundId = 128556868376790,
            Volume = 2
        },
        ["Flight Startup Voiceline"] = {
            SoundId = 100836422953807,
            Volume = 2
        },
        ["Flight End"] = {
            SoundId = 85720089009416,
            Volume = 2
        },
        ["Flight End Voiceline"] = {
            SoundId = 99321923950070,
            Volume = 2
        },
        ["Flight Loop"] = {
            SoundId = 127025238802419,
            Looped = true,
            Volume = 2
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
                    SoundId = "rbxassetid://95533656604594",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Good, good"
                        } }
                },
                {
                    SoundId = "rbxassetid://76842206915427",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ueh..what is this??"
                        } }
                },
                {
                    SoundId = "rbxassetid://115180149097411",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Oh? Oh my?"
                        } }
                },
                {
                    SoundId = "rbxassetid://74143329983805",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My hat is flying off!"
                        } }
                },
                {
                    SoundId = "rbxassetid://101024756859977",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Uu...how troublesome"
                        } }
                },
                {
                    SoundId = "rbxassetid://95506508730404",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "One, two, three customers..."
                        } }
                },
                {
                    SoundId = "rbxassetid://140495848899180",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Would you like to have tea with me? Hehehe"
                        } }
                },
                {
                    SoundId = "rbxassetid://95423344304773",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Is there something you need from me, the head funeral director? Oh, didn\'t you know? I\'m Hu Tao, the 77th funeral director of Ojodo!"
                        } }
                }
            }
        }
    }
};