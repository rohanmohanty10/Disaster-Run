 

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
    ["NPC"] = "Santa",
    ["Talk1"] = {
        ["Text"] = "Load up my sleigh with gingerbread giftboxes so we can get going!!",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["ready"] = {
        ["Text"] = "Alright, we can go now!!!!!!!!!!!!!!!!!! HOP ON?",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
return v2