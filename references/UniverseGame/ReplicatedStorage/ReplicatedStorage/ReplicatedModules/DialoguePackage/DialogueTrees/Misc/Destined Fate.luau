  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return {
    Title = "me am nub (alter ego)",

    GetStart = function() -- Line: 12, Name: GetStart
        -- upvalues: u3 (copy)
        return `step_{u3:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Steps = {
        step_1 = {
            Text = "Hoi~! You seem like a pretty strong person, mind helping me with these objectives?",
            Mutable = true,
            Options = { {
                    Text = "Yeah sure.",
                    Next = "step_2"
                }, {
                    Text = "Nah, I\'m good.",
                    Next = "step_Leave"
                } },

            Condition = function() -- Line: 34, Name: Condition
                -- upvalues: LocalPlayer (copy)
                if LocalPlayer.Data.Ability.Value ~= 90000 then
                    return false, "Hoi- uh.... ew..- what is that ability 😭😭😭, please come back when you have mighty gomu gomu no mi fruit, till then, sayonara~!";
                end;

                if LocalPlayer.Data.Ability:GetAttribute("AscensionRank") < 10 then
                    return false, "Hoi~! Oh! You don\'t seem ready yet! Come back when you\'re Ascension 10.";
                end;

                return true;
            end
        },
        step_2 = {
            Text = "Arigato! Let me know once you\'re ready!~",
            Mutable = true,
            Options = {
                {
                    Text = "I am ready.",

                    Next = function() -- Line: 51, Name: Next
                        -- upvalues: u2 (copy)
                        u2:CheckDialogue(script.Name):expect();

                        return "step_3";
                    end
                }
            }
        },
        step_3 = {
            Text = "Alright, good luck~!",
            Options = {
                {
                    Text = "Thanks.",

                    Next = function() -- Line: 64, Name: Next
                        -- upvalues: u2 (copy)
                        u2:CheckDialogue(script.Name):expect();

                        return nil;
                    end
                }
            }
        },
        step_Leave = {
            Text = ":("
        }
    },

    CheckStep = function() -- Line: 75, Name: CheckStep
        -- upvalues: u3 (copy)
        local v4 = u3:GetCurrentStep(script.Name):expect();

        return v4 == 2 and "step_Ready" or (v4 == 3 and "step_Done" or nil);
    end,

    step_Ready = {
        Text = "Have you completed my initial tasks~?"
    },
    step_Done = {
        Text = "Arigato~! I will give you this fruit, eat this & it will grant you some very special abilities, chao!."
    }
};