  

 

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
    Sounds = {
        ["LMB-1"] = {
            SoundId = 132407504006064,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 84254806621550,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 76647950334447,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 98918680259332,
            Volume = 1
        },
        ["LMB-1 Voiceline"] = {
            SoundId = 71641074680203,
            Volume = 1
        },
        ["LMB-2 Voiceline"] = {
            SoundId = 110486995604972,
            Volume = 1
        },
        ["LMB-3 Voiceline"] = {
            SoundId = 108205234128835,
            Volume = 1
        },
        ["LMB-4 Voiceline"] = {
            SoundId = 98683324927620,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 140023788760284,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 103295793208356,
            Volume = 1
        },
        ["Cursed Descent"] = {
            SoundId = 112893706280317,
            Volume = 1
        },
        ["Cursed Descent Voiceline"] = {
            SoundId = 74360700609366,
            Volume = 1
        },
        ["Cursed Descent Impact"] = {
            SoundId = 119244406540136,
            Volume = 1
        },
        ["Accursed Laceration"] = {
            SoundId = 93662023560388,
            Volume = 1
        },
        Slam = {
            SoundId = 119244406540136,
            Volume = 1
        },
        ["Soul Severance"] = {
            SoundId = 107718237621227,
            Volume = 1
        },
        ["Soul Severance Voiceline"] = {
            SoundId = 106635636192480,
            Volume = 1
        },
        Shadowstrike = {
            SoundId = 89593914292611,
            Volume = 1
        },
        ["Shadowstrike Voiceline"] = {
            SoundId = 116107047673595,
            Volume = 1
        },
        ["Phantom Finisher"] = {
            SoundId = 132278072590797,
            Volume = 1
        },
        ["Phantom Finisher Success"] = {
            SoundId = 110074302301748,
            Volume = 1
        },
        ["Phantom Finisher Success Voiceline"] = {
            SoundId = 98948567690811,
            Volume = 1
        },
        ["Achilles Strike"] = {
            SoundId = 73013255193502,
            Volume = 1
        },
        ["Achilles Strike Voiceline"] = {
            SoundId = 73000668326319,
            Volume = 1
        },
        Flash = {
            SoundId = 130502740953779,
            Volume = 1
        },
        ["Death-Voiceline"] = {
            SoundId = 83096594670859,
            Volume = 1
        },
        Awakening = {
            SoundId = 119703986929432,
            Volume = 1
        },
        AwakeningVoice = {
            SoundId = 133290936549501,
            Volume = 1
        },
        AwakeningAmbience = {
            SoundId = 120935753621403,
            Volume = 0.4,
            Looped = true
        },
        Command = {
            SoundId = 117604703226971,
            Volume = 1
        },
        CommandVoice = {
            SoundId = 96696913601335,
            Volume = 1
        },
        CommandSuccess = {
            SoundId = 116910265446199,
            Volume = 1
        },
        CommandSuccessVoice = {
            SoundId = 99240391539001,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 137171207931048,
            Volume = 1,
            Looped = true
        },
        ArcadeGrab = {
            SoundId = 116625124804742,
            Volume = 1
        },
        ArcadeGrabbed = {
            SoundId = 82555952229018,
            Volume = 1
        },
        ["Cursed Command Victim"] = {
            SoundId = 119098028070095,
            Volume = 1
        }
    },
    Stats = {
        Grab = {
            VoicelinePrefix = "Arcade"
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 77501184836738,
                        Volume = 0.5
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 82488929909710,
                        Volume = 0.5
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 74346063265252,
                        Volume = 0.5
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 101606933229818,
                        Volume = 1
                    }
                }
            }
        },
        ["Accursed Laceration"] = {
            HitSounds = {
                Hit = {
                    SoundId = 77501184836738,
                    Volume = 0.5
                }
            }
        },
        ["Achilles Strike"] = {
            Projectile = {
                HitSounds = {
                    Hit = {
                        SoundId = 77501184836738,
                        Volume = 0.5
                    }
                }
            }
        },
        Shadowstrike = {
            HitSounds = {
                Hit = {
                    SoundId = 77501184836738,
                    Volume = 0.5
                }
            },
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 77501184836738,
                        Volume = 0.3
                    }
                }
            }
        },
        ["Cursed Command"] = {
            Attempt = {
                HitSounds = {
                    Hit = {
                        SoundId = 119098028070095,
                        Volume = 0
                    }
                }
            },
            Kick = {
                HitSounds = {
                    Hit = {
                        SoundId = 119098028070095,
                        Volume = 1
                    }
                }
            }
        },
        ["Cursed Descent"] = {
            HitSounds = {
                Hit = {
                    SoundId = 77501184836738,
                    Volume = 0.5
                }
            }
        },
        ["Soul Severance"] = {
            HitSounds = {
                Hit = {
                    SoundId = 77501184836738,
                    Volume = 0.5
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
            Universal = {
                {
                    SoundId = "rbxassetid://88885716323637",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My bad~!"
                        } }
                },
                {
                    SoundId = "rbxassetid://96605148937882",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*giggle*"
                        } }
                },
                {
                    SoundId = "rbxassetid://111153529039781",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Æ"
                        } }
                },
                {
                    SoundId = "rbxassetid://107349007737891",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Die!"
                        } }
                },
                {
                    SoundId = "rbxassetid://131899734398942",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*laughter*"
                        } }
                },
                {
                    SoundId = "rbxassetid://82157403973107",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Can you withstand my attack this time?"
                        } }
                },
                {
                    SoundId = "rbxassetid://71622940317320",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "ohghghahh"
                        } }
                },
                {
                    SoundId = "rbxassetid://130330795016167",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "MM?"
                        } }
                },
                {
                    SoundId = "rbxassetid://124859400465977",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I will never lose!"
                        } }
                },
                {
                    SoundId = "rbxassetid://94258237067357",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Rusheaaa!"
                        } }
                },
                {
                    SoundId = "rbxassetid://112622093431315",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The stand of Anubis."
                        } }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 136120354233802,
            ["LMB-2"] = 111699923155939,
            ["LMB-3"] = 95154648768535,
            ["LMB-4"] = 115829311270465,
            ["Cursed Descent"] = 73524919013308,
            ["Accursed Laceration"] = 135595009947040,
            ["Accursed Laceration Finish"] = 111776474240903,
            ["Soul Severance"] = 117663264085986,
            ["Achilles Strike"] = 136932149652382,
            Shadowstrike = 87075466388275,
            ["Phantom Finisher"] = 74977909461363,
            ["Phantom Finisher Success"] = 97173206485305,
            Flash = 119239603016595,
            CommandAttempt = 77698283612286,
            CommandUser = 108018006399578,
            PoseIdle = 92289275997014,
            PoseTransition = 122364783260470,
            Awakening = 131779767695397
        },
        Movement = {
            Walk = 139767143772533,
            Run = 77360707937473
        },
        Idle = {
            Idle = 119401866828732
        }
    }
};