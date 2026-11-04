 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 1,
    ["NPC"] = "Jay",
    ["Talk1"] = {
        ["Text"] = "Buy my shovel if you want to get rich quick!!!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2