 

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
    ["NPC"] = "Bomi",
    ["Talk1"] = {
        ["Text"] = "I travel form island to island selling <Color=Blue>Eternal Poses<Color=/>, would you like to buy one for this island?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "<Color=Green>Ok here you go!",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 21 ]]
            game.ReplicatedStorage.Events.SetSpawn:FireServer("Pose")
        end
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>You dont have enough money to buy...<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["haveitem"] = {
        ["Text"] = "<Color=Red>You already own a eternal pose for this island.<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2