  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local v1 = {
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "Oh... ",
                Interval = 0.05,
                Dialogue = { "Oh...", "Back so soon?" },
                Expression = { 2, 5 }
            }, {
                Quote = " Back so soon?",
                Timing = 0.07
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "...huh?",
                Interval = 0.05,
                ScaleTime = 1.5,
                Dialogue = { "...huh?" },
                Expression = { 2 }
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "You know what we must do. ",
                Interval = 0.05,
                Timing = 0.1,
                Dialogue = { "You know what we must do." },
                Expression = { 3 }
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "Are you ready? ",
                Interval = 0.05,
                Timing = 0.05,
                Dialogue = { "Are you ready?", "If not, I understand.", "I\'m not ready either." },
                Expression = { 6, 6, 1 }
            }, {
                Quote = "If not, I understand. ",
                ScaleTime = 1.2,
                Timing = 0.1
            }, {
                Quote = "I\'m not ready either.",
                ScaleTime = 1.2,
                Timing = 0.1
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "Ready?",
                Interval = 0.05,
                Timing = 0.1,
                ScaleTime = 1.2,
                Dialogue = { "Ready?" },
                Expression = { 9 }
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "Human. ",
                Interval = 0.05,
                Dialogue = { "Human.", "It was nice to meet you.", "Goodbye." },
                Expression = { 4, 7, 8 }
            }, {
                Quote = "It was nice to meet you. ",
                Timing = 0.06
            }, {
                Quote = "Goodbye.",
                Timing = 0.06
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "Now, now. ",
                Interval = 0.05,
                Dialogue = { "Now, now.", "There is no need to fight.", "Why not settle this...", "Over a nice cup of tea?" },
                Expression = { 4, 4, 4, 7 }
            }, {
                Quote = "There is no need to fight. ",
                Timing = 0.075
            }, {
                Quote = "Why not settle this... ",
                Timing = 0.075
            }, {
                Quote = "Over a nice cup of tea?",
                Timing = 0.075
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "This is my duty.",
                Interval = 0.05,
                Timing = 0.1,
                Dialogue = { "This is my duty." },
                Expression = { 8 }
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "Straight up... brewing it. ",
                Interval = 0.05,
                Dialogue = { "Straight up... brewing it.", "And by \"it\"?", "Hohoho...", "I mean my tea." },
                Expression = { 3, 6, 4, 10 }
            }, {
                Quote = "And by \"it\"? ",
                Timing = 0.075
            }, {
                Quote = "Hohoho... ",
                Timing = 0.075
            }, {
                Quote = "I mean my tea.",
                Timing = 0.075
            } }
    }
};

local function QuoteCallback(p2, p3) -- Line: 194
    -- upvalues: EffectsHandler (copy)
    if not p3 then
        return;
    end;

    local v4 = p3.FullQuote[1];
    local v5 = {
        Character = "Asgore",
        PrefixIgnore = true,
        Expression = v4.Expression,
        Dialogue = v4.Dialogue,
        Interval = v4.Interval,
        Voice = v4.Voice or true
    };
    local LocalPlayer = game:GetService("Players").LocalPlayer;

    if game:GetService("Players"):GetPlayerFromCharacter(p2) ~= LocalPlayer then
        local Settings = LocalPlayer:FindFirstChild("Settings");

        if Settings and (Settings:FindFirstChild("QuoteScreenEffects") and not Settings:FindFirstChild("QuoteScreenEffects").Value) then
            return;
        end;
    end;

    EffectsHandler.CallEffect("Q_RADIAL", {
        Origin = p2.HumanoidRootPart.CFrame,
        Distance = p2:GetAttribute("InCombat") and 20 or 55,
        Effect = {
            {
                Effect = "Undertale Dialogue",
                Arguments = { v5 }
            }
        }
    });
end;

for _, v in v1 do
    v.ClientCallback = QuoteCallback;
end;

return {
    Inherit = {
        AbilityName = "Asgore"
    },
    Animations = {
        Action = {
            ["LMB-1"] = 13743401768,
            ["LMB-2"] = 13743403015,
            ["LMB-3"] = 13743404828,
            ["LMB-4"] = 13743406645,
            ["Indomitable Resolve"] = 13743408140,
            ["Sovereign Reckoning"] = 13743409569,
            Swiftdraw = 13743410601,
            ["Final Stance"] = 13743412047,
            ["Flaring Pierce"] = 13743415975,
            ["Flaring Pierce Success"] = 13743416995,
            ["Flaring Pierce Target"] = 13743418317,
            ["Royal Grasp"] = 13743419489,
            ["Royal Grasp Success"] = 13743420393,
            ["Royal Grasp Target"] = 13743421690,
            ["Ruler Retribution"] = 13743422798,
            ["Blazing Fury"] = 13743424257,
            PoseTransition = 13743425963,
            PoseIdle = 13743427285,
            ["Monarch Resonance"] = 13743428355
        },
        Movement = {
            Walk = 13743446770,
            Run = 13743447842
        },
        Idle = {
            Idle = 13743448991
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 13643907899,
            Volume = 3,
            PlaybackRegionsEnabled = true,
            LoopRegion = NumberRange.new(17.25, 171.3)
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = v1
        }
    }
};