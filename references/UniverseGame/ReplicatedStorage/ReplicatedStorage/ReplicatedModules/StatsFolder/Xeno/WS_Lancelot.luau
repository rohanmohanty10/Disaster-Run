  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Xeno"
    },
    Animations = {
        Idle = {
            SummonedIdle = 18970337092,
            Idle = 18970337092
        }
    },
    Stats = {
        Summon = {
            SummonV2 = true,
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 30, 71)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 41, 94)) })
        }
    },
    Sounds = {
        ["StandOn-Grab-Voiceline"] = {
            SoundId = 100193855883509,
            Volume = 1.5
        },
        ["StandOff-Grab-Voiceline"] = {
            SoundId = 114375777678063,
            Volume = 1.5
        },
        ["Grab-Hit-Voiceline"] = {
            SoundId = 114375777678063,
            Volume = 0
        },
        ["ShadowWheel-Voiceline"] = {
            SoundId = 83602696576030,
            Volume = 1.5
        },
        ["Sigils-Voiceline"] = {
            SoundId = 106926977442148,
            Volume = 1.5
        },
        ["ShadowBurst-Voiceline"] = {
            SoundId = 137555082520106,
            Volume = 1.5
        },
        ["Enchain-Voiceline"] = {
            SoundId = 106348790431872,
            Volume = 1.5
        },
        ["UnseenEdge-Voiceline"] = {
            SoundId = 76895989919272,
            Volume = 1.5
        },
        ["UnseenEdge-Activate-Voiceline"] = {
            SoundId = 136466902471243,
            Volume = 1.5
        },
        ["SpectralPlay-Startup-Voiceline"] = {
            SoundId = 74018405800703,
            Volume = 1.5
        },
        ["SpectralPlay-End-Voiceline"] = {
            SoundId = 117374532386331,
            Volume = 1.5
        },
        ["CrossBlow-Voiceline"] = {
            SoundId = 134738729644313,
            Volume = 1.5
        },
        ["CriticalStrike-Voiceline"] = {
            SoundId = 133365896581881,
            Volume = 1.5
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 104791442677160,
            Volume = 1.5
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 86949424297978,
            Volume = 1.5
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 123441711001721,
            Volume = 1.5
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 95431440344158,
            Volume = 1.5
        },
        ["StandOff-LMB-1-Voiceline"] = {
            SoundId = 115405610727033,
            Volume = 1.5
        },
        ["StandOff-LMB-2-Voiceline"] = {
            SoundId = 127501852413079,
            Volume = 1.5
        },
        ["StandOff-LMB-3-Voiceline"] = {
            SoundId = 115536258934332,
            Volume = 1.5
        },
        ["StandOff-LMB-4-Voiceline"] = {
            SoundId = 73411079140070,
            Volume = 1.5
        },
        ["Summon-Voiceline"] = {
            SoundId = 70506459269545,
            Volume = 1.5
        },
        ["Desummon-Voiceline"] = {
            SoundId = 110997250866767,
            Volume = 1.5
        },
        ["BurstBarrage-Voiceline"] = {
            SoundId = 116541553918962,
            Volume = 1.5
        },
        ["PhantomPierce-Voiceline"] = {
            SoundId = 98453876202245,
            Volume = 1.5
        },
        ["PhantomPrison-StartupVoiceline"] = {
            SoundId = 120657866928139,
            Volume = 1.5
        },
        ["PhantomPrison-EndVoiceline"] = {
            SoundId = 123933812108483,
            Volume = 1.5
        },
        MeterUp2 = {
            SoundId = 98371932346430,
            Volume = 1.5,
            PlaybackSpeed = 4
        },
        MeterUp4 = {
            SoundId = 116629036745023,
            Volume = 1.5,
            PlaybackSpeed = 4
        },
        ["StandOn-Death-Voiceline"] = {
            SoundId = 118496997025072,
            Volume = 1.5
        },
        ["StandOff-Death-Voiceline"] = {
            SoundId = 78574161167076,
            Volume = 1.5
        },
        PoseMusic = {
            Looped = true,
            SoundId = 87935037125655,
            PlaybackSpeed = 2.272727272727273,
            Volume = 1.5
        }
    },
    QuoteInfo = {
        Groups = {
            StandOn = {
                Visible = false,
                Priority = 2
            },
            StandOff = {
                Visible = true,
                Priority = 1
            }
        },
        Quotes = {
            StandOff = { {
                    SoundId = "rbxassetid://94085522894647",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It was a formidable opponent. But I was not going to lose."
                        } }
                }, {
                    SoundId = "rbxassetid://77315893867154",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Like the glimmer from the surface of water...burn bright and dazzling, my sacred sword! Arondight Overload!"
                        } }
                }, {
                    SoundId = "rbxassetid://138527111181887",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Lancelot is here. Let\'s go!"
                        } }
                } },
            StandOn = { {
                    SoundId = "rbxassetid://86418179343723",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Birth……day..."
                        } }
                }, {
                    SoundId = "rbxassetid://75214755622466",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "AAAAAAAAAAAAAA"
                        } }
                } }
        }
    }
};