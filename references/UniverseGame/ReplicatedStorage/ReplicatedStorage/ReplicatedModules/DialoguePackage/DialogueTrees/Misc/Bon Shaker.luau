  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

local function RootStepTransformer(p3, p4) -- Line: 13
    -- upvalues: u1 (copy)
    local v5 = u1:CheckRequirement("ItemCountCheck", "ITEM_4"):expect();
    u1:CheckRequirement("ItemCountCheck", "ITEM_39"):expect();

    if type(v5) ~= "number" or v5 <= 0 then
        p4.Options = nil;
    end;
end;

return {
    Title = "Bon Shaker",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("Reaper Quest"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "RESTORES ARE DECLINED FOR NOW",
            Transformer = RootStepTransformer,
            Options = {
                {
                    Response = "Do you have any idea what this corrupted soul does?",
                    Next = {
                        Mutable = true,
                        Text = "How interesting, if you collect the remaining materials I believe we can restore an ancient weapon to its full power again",
                        Options = {
                            {
                                Response = "So what do I need to collect?",
                                Next = {
                                    Mutable = true,
                                    Text = "First, we need to reap souls of the weak (defeat npcs) using a cursed ability (STWR, SPR, Umbra, Cid Kagenou, Reaper, Shinigami, Ichigo, Aizen, or Anubis) to enhance this corrupted soul",
                                    Options = {
                                        {
                                            Response = "Got it",
                                            Next = nil,

                                            Callback = function() -- Line: 45, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue("Reaper Quest"):expect();
                                            end
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                {
                    Response = "How do I reap souls again?",
                    Next = {
                        Text = "Defeat NPCS using a cursed ability (STWR, SPR, Umbra, Cid Kagenou, Reaper, Shinigami, Ichigo, Aizen, or Anubis)"
                    }
                }
            }
        },
        step_2 = {
            Mutable = true,
            Text = "RESTORES ARE DECLINED FOR NOW",
            Transformer = RootStepTransformer,
            Options = { {
                    Response = "How do I reap souls again?",
                    Next = {
                        Text = "Defeat NPCS using a cursed ability (STWR, SPR, Umbra, Cid Kagenou, Reaper, Shinigami, Ichigo, Aizen, or Anubis)"
                    }
                } }
        },
        step_3 = {
            Mutable = true,
            Text = "RESTORES ARE DECLINED FOR NOW",
            Transformer = RootStepTransformer,
            Options = {
                {
                    Response = "I have finished reaping souls",
                    Next = {
                        Mutable = true,
                        Text = "Excellent work, now bring me a (Requiem Arrow) so I can imbue it with the corrupted soul, you can obtain the (Requiem Arrow) from defeating Diavolo",
                        Options = {
                            {
                                Response = "Very well",
                                Next = nil,

                                Callback = function() -- Line: 90, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Reaper Quest"):expect();
                                end
                            }
                        }
                    }
                }
            }
        },
        step_4 = {
            Mutable = true,
            Text = "RESTORES ARE DECLINED FOR NOW",
            Transformer = RootStepTransformer,
            Options = {
                {
                    Response = "I have brought the requiem arrow",

                    Callback = function(p6, p7) -- Line: 107, Name: Callback
                        -- upvalues: u1 (copy)
                        local v8 = u1:CheckRequirement("ItemCountCheck", "ITEM_39"):expect();

                        if type(v8) ~= "number" or v8 <= 0 then
                            p7.Next = {
                                Text = "Don\'t play around with me kid, I don\'t see it in your Item Inventory"
                            };

                            return;
                        end;

                        if u1:CheckDialogue("Reaper Quest"):expect() == "CAPACITY" then
                            p7.Next = {
                                Text = "Your inventory seems to be full... Clear out your inventory before I imbue the arrow."
                            };

                            return;
                        end;

                        p7.Next = {
                            Text = "Alright I have imbued the arrow with the corrupted soul. Your final step is to summon the previous Reaper and defeat it to gain its power, good luck."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};