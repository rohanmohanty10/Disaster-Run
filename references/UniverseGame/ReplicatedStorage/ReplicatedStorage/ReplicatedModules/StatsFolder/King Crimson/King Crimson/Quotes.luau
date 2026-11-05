  

 

return {
    Groups = {
        StandOff = {
            Visible = true
        },
        StandOn = {
            Visible = false
        }
    },
    Quotes = {
        StandOn = {
            {
                SoundId = "rbxassetid://11158806047",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Your ego\'s led you to believe that you can overcome me. Is that it?"
                    } }
            },
            {
                SoundId = "rbxassetid://11158809086",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = {
                    {
                        Quote = "I, %s, am emperor! Just as I always was!",

                        Transformer = function(p1, p2) -- Line: 31, Name: Transformer
                            return string.format(p1.Quote, p2.Character.Name);
                        end
                    }
                }
            },
            {
                SoundId = "rbxassetid://11158806549",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "It\'s the results that counts! The result is the only thing that lives in infamy!"
                    } }
            },
            {
                SoundId = "rbxassetid://11158807552",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Don\'t worry. I\'ll make this painless for you."
                    } }
            },
            {
                SoundId = "rbxassetid://11158808900",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "I\'m not even going to give you enough time to regret the fact that you\'re dead!"
                    } }
            }
        },
        StandOff = { {
                SoundId = "rbxassetid://11158816744",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "BRRINGRINGRING...RINGRINGRINGRING!"
                    } }
            }, {
                SoundId = "rbxassetid://11158817811",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Those who have seen what they mustn\'t... cannot be allowed to survive!"
                    } }
            }, {
                SoundId = "rbxassetid://11158818038",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "I\'ve made up my mind. I\'m definitely going to see through him next time."
                    } }
            }, {
                SoundId = "rbxassetid://11158818794",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Doppio... Oh, Doppio... My cute Doppio... Did you forget that I gave you a portion of my King Crimson\'s power? Now is the time to use it!"
                    } }
            } }
    },
    Disguise = {
        SoundId = "rbxassetid://9062202848",
        SoundVolume = 3,
        YieldSound = true,
        FullQuote = { {
                Quote = "This is a test.",
                ScaleTime = 0.5,
                EndLag = 0.5,
                EraseQuote = true
            }, {
                Quote = "I\'ve accepted this test to stand vicorious against my past.",
                ScaleTime = 3,
                EndLag = 0.5,
                EraseQuote = true
            }, {
                Quote = "A person grows once they are able to defeat their weaker self.",
                ScaleTime = 3
            } }
    }
};