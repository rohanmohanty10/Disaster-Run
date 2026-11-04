 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Marquan",
    ["Talk1"] = {
        ["Text"] = "Im the boat seller at this island.<AnimateYield=.45> Are you intrested in what i have to sell?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Here you go take a look...",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
return v2