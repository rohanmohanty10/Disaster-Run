  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("SubPowerService");
local u3 = Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "BobBallin",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: u3 (copy)
        return `step_{u3:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "I be like the joker 🃏 🤡 😈 Society be hating 🏙️ 😠 ❌ But I js wanna be evil 🔥 🗣️ 📏",
            Options = {
                {
                    Response = "I\'m here for haoshoku haki",
                    Next = {
                        Text = "Perhaps... we can arrage something",
                        Options = {
                            {
                                Response = "gulps..",

                                Callback = function(p4, p5, p6) -- Line: 30, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Bob\'s Sacred Path"):expect();
                                    p5.Next = {
                                        Text = "Get to working then.. The quest wont complete itself"
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                },
                {
                    Response = "I\'m out of here.",
                    Next = {
                        Text = "not sigma"
                    }
                }
            }
        },
        step_2 = {
            Text = "I still dont see the sigma in you"
        },
        step_3 = {
            Mutable = true,
            Text = "welcome to the sigma society",

            Transformer = function(p7, p8) -- Line: 54, Name: Transformer
                -- upvalues: u2 (copy)
                if u2:GetUnlockedHakis():expect().Haoshoku then
                    p8.Text = "boy you already got hao on ts (this), go get another ability that has no hao and come back";
                    p8.Options = nil;
                end;
            end,

            Options = {
                {
                    Response = "*gulps*",

                    Callback = function(p9, p10, p11) -- Line: 65, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Bob\'s Sacred Path"):expect();
                        p10.Next = nil;
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};