 

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
    ["NPC"] = "Marine Captain",
    ["Talk1"] = {
        ["Text"] = "Are you here to resign form the marines?",
        ["go"] = "yes",
        ["stop"] = "OMG NEVER",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Alright best of luck!.<AnimateYield=.45>",
        ["go"] = "yes!!",
        ["stop"] = "Bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = true,
        ["excu"] = function(_) --[[ Name: excu, Line 21 ]]
            game.ReplicatedStorage.Events.Team:FireServer("LeaveMarine")
        end
    },
    ["notMarine"] = {
        ["Text"] = "<Color=Red>...",
        ["go"] = "yes",
        ["stop"] = "OMG NEVER",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
return v2