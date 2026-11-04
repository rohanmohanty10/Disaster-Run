 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 3,
    ["NPC"] = "Vina",
    ["Talk1"] = {
        ["Text"] = "This is the route to the skys...<AnimateYield=.45>",
        ["go"] = "Say me more!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Wait for the water stream to spawn then ride your ship on it, make sure your ship has enough speed before going on the stream!<AnimateYield=.45>",
        ["go"] = "Yes",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "If you fail to get on the island your ship is going to fall and sink!",
        ["go"] = "Yes i have.",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2