  

 

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
            SoundId = 137579355597587,
            Volume = 1,
            PlaybackSpeed = 9.615384615384615
        },
        LMB1 = {
            SoundId = 139057920614766,
            Volume = 1
        },
        ["LMB1-Voiceline"] = {
            SoundId = 86710043296122,
            Volume = 1
        },
        LMB2 = {
            SoundId = 119364829152750,
            Volume = 2
        },
        ["LMB2-Voiceline"] = {
            SoundId = 124849198038281,
            Volume = 1
        },
        LMB3 = {
            SoundId = 132408288169332,
            Volume = 2
        },
        ["LMB3-Voiceline"] = {
            SoundId = 114927304770131,
            Volume = 1
        },
        LMB4 = {
            SoundId = 137410165168171,
            Volume = 1
        },
        ["LMB4-Voiceline"] = {
            SoundId = 100544956415830,
            Volume = 1
        },
        ["In a Jiff SFX"] = {
            SoundId = 131792117749255,
            Volume = 1
        },
        ["In a Jiff Voiceline"] = {
            SoundId = 95192692980567,
            Volume = 1
        },
        ["Incalculable Speed Voiceline"] = {
            SoundId = 114391779876897,
            Volume = 1
        },
        ["Incalculable Speed SFX"] = {
            SoundId = 89728206894970,
            Volume = 1
        },
        ["Homerun Voiceline"] = {
            SoundId = 91435314641223,
            Volume = 1
        },
        ["Homerun SFX"] = {
            SoundId = 127158596440981,
            Volume = 1
        },
        ["Deep Dive User Voiceline"] = {
            SoundId = 89678975860960,
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
            SoundId = 121063200996565,
            Volume = 0
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
            SoundId = 134164137043240,
            Volume = 1
        },
        ["Fastest Man Alive Outside SFX"] = {
            SoundId = 101259343978222,
            Volume = 1
        },
        ["Yummers Voiceline"] = {
            SoundId = 140118422110485,
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
            SoundId = 137579355597587,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 9.615384615384615
            }
        },
        ["Awakening Music 2"] = {
            SoundId = 137579355597587,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 9.615384615384615
            }
        },
        Phase = {
            SoundId = 8185672261,
            Volume = 1
        },
        ["Compound High Startup Voiceline"] = {
            SoundId = 130391983685482,
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
            SoundId = 112796666191578,
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
            SoundId = 71184478821289,
            Volume = 1
        },
        ["Grab Attempt SFX"] = {
            SoundId = 93146800247178,
            Volume = 1
        },
        ["Grab Attempt Voiceline"] = {
            SoundId = 113735193211561,
            Volume = 1
        },
        ["Grab SFX"] = {
            SoundId = 107553385827388,
            Volume = 1
        },
        ["Grab Voiceline"] = {
            SoundId = 97962721501888,
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
    Animations = {
        Action = {
            PoseTransition = 108015018868066,
            PoseIdle = 109116654018355,
            AwakenPoseTransition = 108015018868066,
            AwakenPose = 109116654018355
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
                    SoundId = 86925516620464,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hey I thought I saw some dumb goons hangin\' around.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = 117604970479614,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m faster than a speeding bullet! or does that violate the big guy\'s trademark?",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = 116451660658064,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Woohoo!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = 100756468762412,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Dude! that was totally uncalled for!",
                            ScaleTime = 1
                        } }
                } }
        }
    }
};