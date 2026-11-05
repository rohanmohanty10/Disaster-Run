  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit).GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Reaper"
    },
    Metadata = {
        CopyQuotes = false
    },
    Sounds = {
        PoseMusic = {
            Looped = true,
            SoundId = 6520284664,
            Volume = 3
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
                    SoundId = "rbxassetid://6929531363",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Give me a break."
                        } }
                }, {
                    SoundId = "rbxassetid://6929557529",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "...My scythe can harvest my opponents fighting spirit..... yeah that\'s a lie but you lost the battle the moment you lost focus"
                        } }
                }, {
                    SoundId = "rbxassetid://6929565502",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'ve got a weird make up... Don\'t ya.. I don\'t think your fit for harvesting too bad."
                        } }
                } }
        }
    }
};