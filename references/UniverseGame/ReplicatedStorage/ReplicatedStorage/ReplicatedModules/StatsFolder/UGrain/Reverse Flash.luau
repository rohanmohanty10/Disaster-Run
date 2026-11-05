  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.EnumsModule);
require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 20
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy), u3 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.StatsFolder["The Mercenaries"]["The Mercenaries"].Common);
end);

return {
    Inherit = {
        AbilityName = "UGrain"
    },
    Stats = {
        ["Deep Dive"] = {
            VoicelineVariants = 1
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 117591431525660,
            Volume = 1,
            PlaybackSpeed = 1
        },
        LMB1 = {
            SoundId = 139057920614766,
            Volume = 1
        },
        ["LMB1-Voiceline"] = {
            SoundId = 111743650567607,
            Volume = 0
        },
        LMB2 = {
            SoundId = 119364829152750,
            Volume = 2
        },
        ["LMB2-Voiceline"] = {
            SoundId = 83166183699292,
            Volume = 0
        },
        LMB3 = {
            SoundId = 132408288169332,
            Volume = 2
        },
        ["LMB3-Voiceline"] = {
            SoundId = 136422103201784,
            Volume = 0
        },
        LMB4 = {
            SoundId = 137410165168171,
            Volume = 1
        },
        ["LMB4-Voiceline"] = {
            SoundId = 138608386472034,
            Volume = 0
        },
        ["In a Jiff SFX"] = {
            SoundId = 131792117749255,
            Volume = 1
        },
        ["In a Jiff Voiceline"] = {
            SoundId = 106875658517408,
            Volume = 1
        },
        ["Incalculable Speed Voiceline"] = {
            SoundId = 88933279621127,
            Volume = 1
        },
        ["Incalculable Speed SFX"] = {
            SoundId = 89728206894970,
            Volume = 1
        },
        ["Homerun Voiceline"] = {
            SoundId = 97333890874528,
            Volume = 1
        },
        ["Homerun SFX"] = {
            SoundId = 127158596440981,
            Volume = 1
        },
        ["Deep Dive User Voiceline"] = {
            SoundId = 115577481173896,
            Volume = 1
        },
        ["Deep Dive User Indicator Loop"] = {
            SoundId = 114348317294054,
            Volume = 1
        },
        ["Deep Dive User Indicator Startup"] = {
            SoundId = 132130100863009,
            Volume = 1
        },
        ["Deep Dive SFX"] = {
            SoundId = 124206575832990,
            Volume = 1
        },
        ["Deep Dive Voiceline 1"] = {
            SoundId = 128809456344971,
            Volume = 1
        },
        ["Scorched Earth Voiceline"] = {
            SoundId = 136764530435922,
            Volume = 1
        },
        ["Scorched Earth SFX"] = {
            SoundId = 108156384391113,
            Volume = 1
        },
        ["Laser SFX"] = {
            SoundId = 137661760452248,
            Volume = 1,
            Looped = true
        },
        ["America\'s Finest Voiceline"] = {
            SoundId = 100462185168176,
            Volume = 1
        },
        ["America\'s Finest SFX"] = {
            SoundId = 103983395553300,
            Volume = 1
        },
        ["Fastest Man Alive Start Voiceline"] = {
            SoundId = 82528087750302,
            Volume = 1
        },
        ["Fastest Man Alive Start SFX"] = {
            SoundId = 128421548881133,
            Volume = 1
        },
        ["Fastest Man Alive Voiceline"] = {
            SoundId = 124900455309656,
            Volume = 0
        },
        ["Fastest Man Alive SFX"] = {
            SoundId = 74705355377190,
            Volume = 1
        },
        ["Fastest Man Alive Outside SFX"] = {
            SoundId = 101259343978222,
            Volume = 1
        },
        ["Yummers Voiceline"] = {
            SoundId = 105778284096250,
            Volume = 1
        },
        ["Yummers SFX"] = {
            SoundId = 100085456371656,
            Volume = 1
        },
        ["Awakening Trigger SFX"] = {
            SoundId = 88086650887299,
            Volume = 1
        },
        ["Awakening Aura SFX"] = {
            SoundId = 125073410849913,
            Volume = 1,
            Looped = true
        },
        ["Awakening Music 1"] = {
            SoundId = 117591431525660,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 1
            }
        },
        ["Awakening Music 2"] = {
            SoundId = 117591431525660,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 1
            }
        },
        Phase = {
            SoundId = 8185672261,
            Volume = 1
        },
        ["Compound High Startup Voiceline"] = {
            SoundId = 123691091733286,
            Volume = 1
        },
        ["Compound High Startup SFX"] = {
            SoundId = 71698684476483,
            Volume = 1
        },
        ["Compound High Loop SFX"] = {
            SoundId = 125859590420183,
            Volume = 1,
            Looped = true
        },
        ["Compound High End SFX"] = {
            SoundId = 118408357511067,
            Volume = 1
        },
        ["Compound High End Voiceline"] = {
            SoundId = 79998476198838,
            Volume = 1
        },
        ["I Cant Stop SFX"] = {
            SoundId = 90534564971725,
            Volume = 1
        },
        ["I Cant Stop SFX Awakened Variant"] = {
            SoundId = 116909537537994,
            Volume = 1
        },
        ["I Cant Stop Voiceline"] = {
            SoundId = 111709099003987,
            Volume = 1
        },
        ["Grab Attempt SFX"] = {
            SoundId = 93146800247178,
            Volume = 1
        },
        ["Grab Attempt Voiceline"] = {
            SoundId = 110306686612188,
            Volume = 1
        },
        ["Grab SFX"] = {
            SoundId = 107553385827388,
            Volume = 1
        },
        ["Grab Voiceline"] = {
            SoundId = 85747751422122,
            Volume = 1
        },
        BurstBlood1 = {
            SoundId = 6148096445,
            Volume = 3.75
        },
        BurstBlood2 = {
            SoundId = 7441118570,
            Volume = 3.75
        },
        BurstBlood3 = {
            SoundId = 7441118030,
            Volume = 3.75
        },
        BurstBlood4 = {
            SoundId = 7441119990,
            Volume = 3.75
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
                    SoundId = 130580286708200,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can fix things so you were never born"
                        } }
                },
                {
                    SoundId = 70581745759788,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The future I\'m from no longer exists"
                        } }
                },
                {
                    SoundId = 130847258908005,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I was there at the beggining Flash"
                        } }
                },
                {
                    SoundId = 136451715063240,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "If anyone\'s faster, I\'ll kill em"
                        } }
                },
                {
                    SoundId = 87788638974979,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "If it isn\'t FREAK of the week"
                        } }
                },
                {
                    SoundId = 113119639767780,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You stand between me and the future"
                        } }
                },
                {
                    SoundId = 119979956985250,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "How would you like being trapped in the past"
                        } }
                },
                {
                    SoundId = 92325816432129,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "In the future no one remembers you"
                        } }
                },
                {
                    SoundId = 94636350492270,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Reverse Flash fact: you\'re dead"
                        } }
                },
                {
                    SoundId = 139471363868764,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hate you...? I made you, Barry"
                        } }
                },
                {
                    SoundId = 104569750844157,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The name is Eobard Thawne"
                        } }
                },
                {
                    SoundId = 128965530929345,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "How\'s your mother Barry."
                        } }
                },
                {
                    SoundId = 96222915675087,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It was me Barry."
                        } }
                }
            }
        }
    }
};