  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Sakuya Fumo",
    StarterText = "Do you want to get strong enough to be able to manipulate time as you want?",

    Start = function() -- Line: 6, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Text = "Do you want to get strong enough to be able to manipulate time as you want?",
            Options = {
                {
                    Response = "YES",
                    Next = {
                        Callback = function() -- Line: 23, Name: Callback
                            -- upvalues: u1 (copy)
                            u1:CheckDialogue(script.Name):expect();

                            return nil;
                        end
                    }
                }
            }
        },
        step_2 = {
            Text = "🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡",
            Options = {}
        }
    }
};