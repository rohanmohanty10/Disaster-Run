  

 

return {
    Groups = {
        Universal = {
            Visible = true
        }
    },
    Quotes = {
        Universal = {
            {
                SoundId = "rbxassetid://103119975941283",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "OK, OK."
                    } }
            },
            {
                SoundId = "rbxassetid://129778959312399",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Immortality, ageless, I will rule this world!"
                    } }
            },
            {
                SoundId = "rbxassetid://84565760467248",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Excellent, I have new strength! I feel great!"
                    } }
            },
            {
                SoundId = "rbxassetid://14969464216",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = {
                    {
                        Quote = "I, %s, have no need for you anymore.",

                        Transformer = function(p1, p2) -- Line: 51, Name: Transformer
                            return string.format(p1.Quote, p2.Character.Name);
                        end
                    }
                }
            },
            {
                SoundId = "rbxassetid://14969465343",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "How weak! You think you can beat ME, you idiot?"
                    } }
            },
            {
                SoundId = "rbxassetid://14969464091",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = {
                    {
                        Quote = "Can a monkey like you keep up? Compared to me, %s, you are but a mere monkey!",

                        Transformer = function(p3, p4) -- Line: 76, Name: Transformer
                            return string.format(p3.Quote, p4.Character.Name);
                        end
                    }
                }
            }
        }
    }
};