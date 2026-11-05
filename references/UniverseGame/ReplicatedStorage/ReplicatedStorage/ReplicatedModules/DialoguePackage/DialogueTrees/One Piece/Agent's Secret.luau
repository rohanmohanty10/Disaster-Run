  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("SubPowerService");
local u3 = Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "Agent Bon",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: u3 (copy)
        return `step_{u3:GetCurrentStep("Agent\'s Secret"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "You seem worthy enough for my tasks, mind doing something for me? I\'ll reward you, don\'t worry.",
            Options = {
                {
                    Response = "Yeah.",
                    Next = {
                        Text = "Alright, come back to me once you\'ve completed the tasks.",
                        Options = {
                            {
                                Response = "Gotcha.",

                                Callback = function(p4, p5, p6) -- Line: 30, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Agent\'s Secret"):expect();
                                    p5.Next = {
                                        Text = "Alright, good luck."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                },
                {
                    Response = "Nah, you seem sketchy.",
                    Next = {
                        Text = "I just have infinite aura."
                    }
                }
            }
        },
        step_2 = {
            Text = "Have you done my task?"
        },
        step_3 = {
            Mutable = true,
            Text = "Awesome, I grant you the abilities of a mysterious haki, \'Busoshoku\'. You aren\'t as strong yet, but I recommend that you progress further & you\'ll be just as strong as me. I recommend you see Rayleigh if you wanna know more about these abilities. Anyways, my job is done, I wish you the very best.",

            Transformer = function(p7, p8) -- Line: 54, Name: Transformer
                -- upvalues: u2 (copy)
                if u2:GetUnlockedHakis():expect().Busoshoku then
                    p8.Text = "You already possess Busoshoku Haki. Come to me with an ability you haven\'t awakened haki on yet.";
                    p8.Options = nil;
                end;
            end,

            Options = {
                {
                    Response = "Thanks.",

                    Callback = function(p9, p10, p11) -- Line: 65, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Agent\'s Secret"):expect();
                        p10.Next = nil;
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};