 

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
    ["NPC"] = "Lily",
    ["Talk1"] = {
        ["Text"] = "Im the gun seller at this town<AnimateYield=.45>, if your intrested in my guns please buy one!<AnimateYield=2>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2