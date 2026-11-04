 

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
    ["NPC"] = "Leza",
    ["Talk1"] = {
        ["Text"] = "Touch the neon pillar to go back to the surface!<AnimateYield=1.5>",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
return v2