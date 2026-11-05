  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 5
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);

return {
    Inherit = {
        AbilityName = "Standless"
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = "rbxassetid://7118372897",
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://7118373341",
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://7118373677",
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://7118374016",
            Volume = 1
        },
        BiteAttempt = {
            SoundId = "rbxassetid://7119151931",
            Volume = 1
        },
        BiteSFX = {
            SoundId = "rbxassetid://7119152970",
            Volume = 1
        },
        BiteVoice = {
            SoundId = "rbxassetid://7119153561",
            Volume = 1
        },
        DropKickHit = {
            SoundId = "rbxassetid://7118360234",
            Volume = 1
        },
        DropKickSFX = {
            SoundId = "rbxassetid://7118359806",
            Volume = 1
        },
        DropKickVoice = {
            SoundId = "rbxassetid://7118359449",
            Volume = 1
        },
        KickComboVoice = {
            SoundId = "rbxassetid://7119096563",
            Volume = 1
        },
        TossVoice = {
            SoundId = "rbxassetid://7117751172",
            Volume = 1
        },
        CrashSFX = {
            SoundId = "rbxassetid://7118660974",
            Volume = 1
        },
        CounterActivated = {
            SoundId = "rbxassetid://13582569418",
            Volume = 1
        },
        CounterCrash = {
            SoundId = 7118786611,
            Volume = 1
        },
        CounterSFX = {
            SoundId = "rbxassetid://7118785624",
            Volume = 1
        },
        CounterVoice = {
            SoundId = "rbxassetid://7118786365",
            Volume = 1
        },
        PoseMusic = {
            SoundId = 18492205429,
            Looped = true
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
                    SoundId = "rbxassetid://7117631162",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re an eyesore."
                        } }
                },
                {
                    SoundId = "rbxassetid://15518545395",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hey. Stand up."
                        } }
                },
                {
                    SoundId = "rbxassetid://7117632768",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re wasting my time."
                        } }
                },
                {
                    SoundId = "rbxassetid://18485233003",
                    SoundVolume = 1.3,
                    PlaybackSpeed = 1.25,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = {
                        {
                            Timing = 5,
                            EndLag = 0.5,
                            Quote = "..."
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.5,
                            Quote = "I\'ve been foolish, and you\'ve been childish. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.5,
                            Quote = "You fell down, you got hurt chasing sweeter dreams. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "Never could, hide the truth in your eyes. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 3,
                            Quote = "That\'s how I knew, that smile was a lie. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "\"I love you\" is something you never say. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "Couldn\'t get it out, always just pulled it away. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.5,
                            Quote = "So then why?, won\'t you tell me why? "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 3.3,
                            Quote = "You could find the words, to say goodbye. ",
                            EraseQuote = true
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "I\'m such a mess. I\'m no good at this. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "I\'m in love, still in love, still in love with you. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "Hard as I try, I can\'t even drink this pain away. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2.3,
                            Quote = "Memories of you, twisting my view. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1,
                            Quote = "I\'ve been a fool. ",
                            EraseQuote = true
                        },
                        {
                            Timing = 5,
                            EndLag = 0.5,
                            Quote = "..."
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "I\'ve been a fool, honestly such a fool. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2,
                            Quote = "I should not have placed all my faith and trust in you. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.3,
                            Quote = "I was strong, but now I stand alone, "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 3,
                            Quote = "in the dark and melancholic night I\'ve known. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.3,
                            Quote = "Left in solitude as these three years pass me by, "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.3,
                            Quote = "the cityscapes have changed, but I\'ve stayed the same. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.3,
                            Quote = "But even so, even so I still lack, "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2.5,
                            Quote = "that feeling of change, stuck in the past. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2.5,
                            Quote = "You are not what I thought, you\'re not a good man. "
                        },
                        {
                            Timing = 0.07,
                            EndLag = 1.5,
                            Quote = "I take off the ring that we matched and hide it away from me. "
                        },
                        {
                            Timing = 0.07,
                            EndLag = 1.5,
                            Quote = "It\'s what you deserve, I am done and now I feel relief. "
                        },
                        {
                            Timing = 0.06,
                            EndLag = 1.5,
                            Quote = "Even though I wait, "
                        },
                        {
                            Timing = 0.06,
                            EndLag = 1.5,
                            Quote = "carrying this weight. "
                        },
                        {
                            Timing = 0.05,
                            EndLag = 1.5,
                            Quote = "I\'m still a fool. ",
                            EraseQuote = true
                        },
                        {
                            Timing = 7,
                            EndLag = 1,
                            Quote = "..."
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.7,
                            Quote = "I\'m such a mess, I\'m lost, I\'m no good at this. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.5,
                            Quote = "I\'m in love, still in love, still in love with you. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 1.3,
                            Quote = "No matter how much I drink, it won\'t fade. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 2.3,
                            Quote = "Memories of you, twisting my view, I\'ve been a fool. "
                        },
                        {
                            Timing = 0.1,
                            EndLag = 3,
                            Quote = "You are not what I thought, you\'re not a good man. "
                        },
                        {
                            Timing = 0.07,
                            EndLag = 2.3,
                            Quote = "I take off the ring that we matched and hide it away from me. "
                        },
                        {
                            Timing = 0.07,
                            EndLag = 2,
                            Quote = "It\'s what you deserve, I am done and now I feel relief. "
                        },
                        {
                            Timing = 0.06,
                            EndLag = 1.5,
                            Quote = "Even though I wait, "
                        },
                        {
                            Timing = 0.06,
                            EndLag = 1.5,
                            Quote = "carrying this weight. "
                        },
                        {
                            Timing = 0.05,
                            EndLag = 20,
                            Quote = "I\'m still a fool."
                        }
                    }
                }
            }
        }
    }
};