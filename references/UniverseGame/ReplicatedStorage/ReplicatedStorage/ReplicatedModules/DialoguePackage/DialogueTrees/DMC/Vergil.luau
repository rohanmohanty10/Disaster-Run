  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local UIHandler = require(ReplicatedStorage.ReplicatedModules.UIHandler);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Start = "start",
    Title = "Vergil",
    Nodes = {
        start = {
            Text = "Choose",
            Options = {
                {
                    Response = "DMC Shop",
                    Next = nil,

                    Callback = function() -- Line: 19, Name: Callback
                        -- upvalues: UIHandler (copy)
                        UIHandler:SetMenu("DMCShop");
                    end
                },
                {
                    Response = "Beowulf Quest",
                    Next = "beowulf_quest"
                },
                {
                    Response = "nah",
                    Next = nil
                }
            }
        },
        beowulf_quest = {
            Mutable = true,
            Text = "To start the quest, you will need to 1m UCoins and UShards",

            Transformer = function(p3, p4) -- Line: 38, Name: Transformer
                -- upvalues: u2 (copy)
                local v5 = u2:GetCurrentStep("Beowulf Quest"):expect();

                if v5 == 3 then
                    p4.Text = "I will now give you Beowulf, make sure your ability inventory has space";

                    return;
                end;

                if v5 == 2 then
                    p4.Text = "Talk to me again when you complete the quest";
                    p4.Options = nil;
                end;
            end,

            Options = {
                {
                    Response = "Of course.",

                    Callback = function(p6, p7) -- Line: 50, Name: Callback
                        -- upvalues: u1 (copy), u2 (copy)
                        local v8 = u1:CheckDialogue("Beowulf Quest"):expect();
                        local v9 = u2:GetCurrentStep("Beowulf Quest"):expect();

                        if v8 == true and v9 == 2 then
                            p7.Next = {
                                Text = "Quest has been given, talk to me again when you complete the quest"
                            };

                            return;
                        end;

                        if type(v8) == "string" then
                            p7.Next = {
                                Text = v8
                            };
                        end;
                    end
                }
            }
        }
    }
};