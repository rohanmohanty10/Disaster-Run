  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
Core.GetClientService("LabService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
Core.GetClientService("LabService");
local u1 = Core.GetLegacyService("QuestLineService");
local u2 = Core.GetLegacyService("DialogueService");

return {
    Title = "Mysterious Figure",

    Start = function() -- Line: 12, Name: Start
        -- upvalues: u1 (copy)
        local v3 = u1:GetCurrentStep("LabMysteriousFigureQuest"):expect() or 0;

        return v3 == 2 and "in_quest" or (v3 == 3 and "quest_done" or "start");
    end,

    Nodes = {
        start = {
            Mutable = true,
            Text = "Hey. Mind doing me a favor?",

            Transformer = function(p4, p5) -- Line: 27, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                if LocalPlayer:GetAttribute("MystFigureQuestCD") then
                    p5.Text = "Sorry, I don\'t need your help right now.";
                    p5.Options = { {
                            Response = "Alright.",
                            Next = nil
                        } };
                end;
            end,

            Options = {
                {
                    Response = "Sure, what is it?",
                    Next = {
                        Mutable = true,
                        Text = "While I was taking a walk, a %s robbed me of an important object. Could you retrieve it for me? I will reward you.",

                        Transformer = function(p6, p7) -- Line: 44, Name: Transformer
                            -- upvalues: u2 (copy)
                            local _, v8 = u2:CheckDialogue("LabMysteriousFigureQuest"):expect();

                            if v8 and typeof(v8) == "string" then
                                p7.Text = string.format(p7.Text, v8);
                            end;
                        end,

                        Options = {
                            {
                                Response = "I\'ll do it.",

                                Callback = function() -- Line: 54, Name: Callback
                                    -- upvalues: u2 (copy)
                                    local _, _ = u2:CheckDialogue("LabMysteriousFigureQuest", true):expect();
                                end,

                                Next = {
                                    Text = "Thank you, good luck.",
                                    Options = { {
                                            Response = "I\'ll be back.",
                                            Next = nil
                                        } }
                                }
                            },
                            {
                                Response = "Sorry, I have no time.",
                                Next = nil
                            }
                        }
                    }
                }
            }
        },
        in_quest = {
            Text = "Please hurry up, I need that briefcase back.",
            Options = { {
                    Response = "I\'m on it.",
                    Next = nil
                } }
        },
        quest_done = {
            Mutable = true,
            Text = "Do you have the briefcase?",
            Options = {
                {
                    Response = "Yes. I have it here.",

                    Callback = function(p9, p10) -- Line: 91, Name: Callback
                        -- upvalues: u2 (copy)
                        if u2:CheckDialogue("LabMysteriousFigureQuest"):expect() == true then
                            p10.Next = {
                                Text = "Oh, thank you very much. Here\'s your reward.",
                                Options = { {
                                        Response = "Thank you.",
                                        Next = nil
                                    } }
                            };
                        end;
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};