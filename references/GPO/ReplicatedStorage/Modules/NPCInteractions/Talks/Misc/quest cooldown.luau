 

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
        ["Text"] = "<Color=Red>Seems like you just finished a quest, rest a bit and come back later!<Color=/><AnimateYield=.45>",
        ["go"] = "Ok i will come back later",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
return v2