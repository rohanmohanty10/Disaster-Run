 

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
        ["Text"] = "<Color=Red>You dont meet the level requirements to do this quest!<Color=/><AnimateYield=.45>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "..",
        ["endtext"] = true
    }
}
return v2