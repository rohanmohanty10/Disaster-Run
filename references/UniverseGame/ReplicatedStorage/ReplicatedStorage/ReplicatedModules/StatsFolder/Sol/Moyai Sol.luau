  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = {
        AbilityName = "Sol"
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://10614899351",
                    SoundVolume = 5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "🗿"
                        } }
                } }
        }
    }
};