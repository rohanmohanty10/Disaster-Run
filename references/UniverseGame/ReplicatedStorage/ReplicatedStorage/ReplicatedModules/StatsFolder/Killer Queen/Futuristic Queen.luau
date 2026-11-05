  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Killer Queen"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 16, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.PoseMusic = "StandOn-PoseMusic";

                        return v2;
                    end;

                    v2.PoseMusic = "StandOff-PoseMusic" .. math.random(1, 2);

                    return v2;
                end
            }
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 122572686155960,
            Volume = 2
        },
        ["Desummon-Voiceline"] = {
            SoundId = 78423228079145,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 76593683924754,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 76593683924754,
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 73086336082131,
            Volume = 2
        },
        ["Arm Slice Voiceline"] = {
            SoundId = 135554309993114,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 74735348234120,
            Volume = 2
        },
        ["Face Slam Startup Voiceline"] = {
            SoundId = 97104453434064,
            Volume = 2
        },
        ["Face Slam"] = {
            SoundId = 108168778614425,
            Volume = 1
        },
        ["Face Slam Music"] = {
            SoundId = 108832701707238,
            Volume = 1
        },
        ["Face Slam Voiceline"] = {
            SoundId = 95674559389432,
            Volume = 2
        },
        ["Global Detonation Voiceline"] = {
            SoundId = 120427787294595,
            Volume = 2
        },
        ["Limb Burst Voiceline"] = {
            SoundId = 135584932573371,
            Volume = 2
        },
        ["Plant Bomb Startup Voiceline"] = {
            SoundId = 136234276306100,
            Volume = 2
        },
        ["Power Display Startup Voiceline"] = {
            SoundId = 85493851978937,
            Volume = 2
        },
        ["Power Display Voiceline"] = {
            SoundId = 105357408592410,
            Volume = 2
        },
        ["Quadruple Bomb Counter Startup Voiceline"] = {
            SoundId = 101981947202703,
            Volume = 2
        },
        ["Quadruple Bomb Counter Voiceline"] = {
            SoundId = 74146192426087,
            Volume = 2
        },
        ["Quick Plant Startup Voiceline"] = {
            SoundId = 82168530715714,
            Volume = 2
        },
        ["Quick Plant Voiceline"] = {
            SoundId = 107766774393137,
            Volume = 2
        },
        ["Sheer Heart Attack Voiceline"] = {
            SoundId = 107930947795793,
            Volume = 2
        },
        ["Surface Detonation Voiceline"] = {
            SoundId = 129213766148111,
            Volume = 2
        },
        ["Withdraw Change Voiceline"] = {
            SoundId = 129037780920537,
            Volume = 2
        },
        ["StandOn-PoseMusic"] = {
            SoundId = 94218305387455,
            Volume = 2,
            Looped = true
        },
        ["StandOff-PoseMusic1"] = {
            SoundId = 109721402719435,
            Volume = 2,
            Looped = true
        },
        ["StandOff-PoseMusic2"] = {
            SoundId = 116835872390330,
            Volume = 2,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 10842905304,
            Volume = 0
        },
        ["LMB-2"] = {
            SoundId = 10842905185,
            Volume = 0
        },
        ["LMB-3"] = {
            SoundId = 10842905241,
            Volume = 0
        },
        ["LMB-4"] = {
            SoundId = 10842905370,
            Volume = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = 10842905304,
            Volume = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = 10842905185,
            Volume = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = 10842905241,
            Volume = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10842905370,
            Volume = 0
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
                    SoundId = "rbxassetid://107355075987589",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = {
                        {
                            Quote = "You can call me Yoshikage Kira. I\'m currently 33 years old. Not that you\'d care, but I reside in northeast Morioh\'s villa district. Also, I\'ve yet to marry. In order to make a living, I work for Kame Yu department stores. After a long day\'s work, I return home no later than 8 PM. I\'m always in bed by 11 PM, and I make it a point to get no less than eight hours of sleep each night. Before bed, I drink a warm glass of milk. It\'s always coupled with twenty minutes of stretching to decompress from the long work day. Sweet dreams are the usual result of this. I then awake as refreshed and recharged as a newborn child, ready to take on the day\'s challenges. And after my last checkup, I was given a clean bill of health. For as long as I can remember, I\'ve done everything in my power to live a productive life that allows me to pursue a lasting inner peace. This may be a foreign concept, but I choose not to concern myself with winning or losing, life\'s troubles, or enemies who bring sleepless nights. That is how I cope with this backwards life we find ourselves living. It\'s what brings me happiness in a world fraught with hardship and misery. Of course, if I were ever to engage in combat, I would win the battle without question."
                        }
                    }
                },
                {
                    SoundId = "rbxassetid://107343668263703",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll sleep soundly tonight. I can already feel it."
                        } }
                },
                {
                    SoundId = "rbxassetid://82600994788841",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m fairly certain I can see the trees behind you through your gaping wounds."
                        } }
                },
                {
                    SoundId = "rbxassetid://78950172845689",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "By the way, you wouldn\'t happen to have any tissues on hand would you? A hankercheif would also do."
                        } }
                },
                {
                    SoundId = "rbxassetid://129386947243491",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What a day. I had to compensate a cafe, then I had a run in with some thugs...thruthfully I feel like I\'ve been taken for a ride."
                        } }
                },
                {
                    SoundId = "rbxassetid://116810686732138",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "They say a stuffy nose is a sure path to slow cognition."
                        } }
                },
                {
                    SoundId = "rbxassetid://126351599886664",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Not too long ago I was groveling on the ground just like you. In one minute, I will vaporize you with Deadly Queen. Until then, why don\'t you learn from \"your\'s truly\" and put up with the pain."
                        } }
                }
            }
        }
    }
};