  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
Knit.GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Cid Kagenou"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 17, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    v2.PoseMusic = "PoseMusic1";

                    return v2;
                end
            }
        }
    },
    Sounds = {
        ["Highest Startup Voiceline"] = {
            SoundId = 137497780906156,
            Volume = 1
        },
        ["Highest Voiceline"] = {
            SoundId = 70748621361301,
            Volume = 1
        },
        ["Imminent Blink Voiceline"] = {
            SoundId = 16655094176308,
            Volume = 1
        },
        ["Atomic: Sword Voiceline"] = {
            SoundId = 100025510975469,
            Volume = 1
        },
        ["Shadow\'s Retribution Startup Voiceline"] = {
            SoundId = 102143437955697,
            Volume = 1
        },
        ["Shadow\'s Retribution Voiceline"] = {
            SoundId = 131739450725378,
            Volume = 1
        },
        ["Silhouette Slashes Voiceline"] = {
            SoundId = 117397927780435,
            Volume = 1
        },
        ["Dark Blade Voiceline"] = {
            SoundId = 18687950592,
            Volume = 1
        },
        ["Atomic: Recovery Voiceline"] = {
            Volume = 1,
            SoundId = 84695937373753
        },
        ["Umbral Smash Voiceline"] = {
            SoundId = 1,
            Volume = 1
        },
        ["I Am Atomic Voiceline"] = {
            Volume = 1,
            SoundId = 75281711838697
        },
        ["Overdrive Voiceline"] = {
            SoundId = 122040356373974,
            Volume = 1
        },
        PoseMusic1 = {
            SoundId = 114986313480690,
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
            Universal = { {
                    SoundId = 94231513529496,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "But now, I am a super elite agent."
                        } }
                }, {
                    SoundId = 135708827169233,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Tonight, the world will know my name!"
                        } }
                }, {
                    SoundId = 100821908841852,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I am only here... to retrieve something very precious to me."
                        } }
                }, {
                    SoundId = 76886562639503,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The fate of a beast is to crawl along the ground."
                        } }
                } }
        }
    }
};