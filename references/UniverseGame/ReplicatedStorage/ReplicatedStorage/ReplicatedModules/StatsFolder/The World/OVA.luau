  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The World"
    },
    Stats = {
        Summon = {
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 190, 118)), ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 83, 62)) })
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 18419679781,
            Volume = 2.5
        },
        ["Summon-Voiceline"] = {
            SoundId = 8775903581,
            Volume = 2
        },
        ["Summon-SFX"] = {
            SoundId = 8775900180,
            Volume = 2
        },
        ["Timestop End Voiceline"] = {
            SoundId = "rbxassetid://18419538588",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop SFX"] = {
            SoundId = "rbxassetid://18419538366",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = "rbxassetid://18419539427",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = "rbxassetid://18419539188",
            Volume = 5.5,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = "rbxassetid://18419539914",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Impale Voiceline"] = {
            SoundId = "rbxassetid://18419541877",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Strong Punch Voiceline"] = {
            SoundId = "rbxassetid://18419539657",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = "rbxassetid://18419540805",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["StopSign-Voice"] = {
            SoundId = "rbxassetid://18419540152",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = "rbxassetid://18419848932",
            Volume = 2.5
        },
        ["RoadRoller-SFX"] = {
            SoundId = "rbxassetid://18419538119",
            Volume = 2.5
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = "rbxassetid://18419538920",
            Volume = 3
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://18419541122",
            Volume = 3
        },
        Barrage = {
            SoundId = 8775871201,
            Volume = 2.5
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = "rbxassetid://18419540451",
            Volume = 2
        },
        ["Sudden Strike Voiceline"] = {
            SoundId = 8775908300,
            Volume = 3
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = "rbxassetid://18419541714",
            Volume = 3
        },
        ["Bloodsuck Voiceline"] = {
            SoundId = "rbxassetid://18419541450",
            Volume = 3
        },
        ["LMB-1"] = {
            SoundId = "",
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = "",
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = "",
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = "",
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 11499912913,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 11499913422,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 11499913311,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 11499913144,
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
            Universal = { {
                    SoundId = "rbxassetid://9062245296",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t you think, this a frightening sight to behold?"
                        } }
                }, {
                    SoundId = "rbxassetid://9062247608",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I, DIO, will score victorious against the Joestars, under any circumstance."
                        } }
                }, {
                    SoundId = "rbxassetid://8775890638",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*menacing laughter*"
                        } }
                } }
        }
    }
};