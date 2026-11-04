 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 4,
    ["NPC"] = "Oliva",
    ["Talk1"] = {
        ["Text"] = "Would you like to switch back to <Color=Orange>Basic Melee<Color=/>?",
        ["go"] = "Yes",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "There you go have fun, throw hands!<AnimateYield=.45>",
        ["go"] = "I can go get you some!",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 23 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Melee")
        end
    }
}
return v2