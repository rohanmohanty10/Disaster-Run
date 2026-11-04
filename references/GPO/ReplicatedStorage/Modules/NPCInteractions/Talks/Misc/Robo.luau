 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v3 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Robo",
    ["Talk1"] = {
        ["Text"] = "Would you like to set your spawn point to this island?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "<Color=Green>Spawn point successfully set!",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["excu"] = function(p2) --[[ Name: excu, Line 20 ]]
            game.ReplicatedStorage.Events.SetSpawn:FireServer(nil, p2)
        end,
        ["endtext"] = true
    },
    ["marineIsland"] = {
        ["Text"] = "<Color=Red>You cant set your spawn here because your a marine.<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["notamarine"] = {
        ["Text"] = "<Color=Red>You cant set your spawn here because your a pirate.<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v3