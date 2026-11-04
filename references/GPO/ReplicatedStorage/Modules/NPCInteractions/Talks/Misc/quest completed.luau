 

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
    ["Talk1"] = {
        ["Text"] = "You have already completed this quest!",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "..",
        ["endtext"] = true
    }
}
return v2