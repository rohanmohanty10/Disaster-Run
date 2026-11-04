 

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
    ["NPC"] = "Rave",
    ["QuestName"] = "Deliver letter to Dave",
    ["QuestDesc"] = "Deliver letter",
    ["Save"] = true
}
local v3 = {
    ["Type"] = "Deliver",
    ["MobName"] = "Rave\'s Letter",
    ["Ammount"] = 1
}
local v4 = {
    ["EXP"] = 20,
    ["Peli"] = 27,
    ["Items"] = {
        ["SP Reset Essence"] = 1
    }
}
v3.Rewards = v4
v3.EndNPC = "Dave"
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey can you deliver this letter to my friend?",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 24 ]]
        questHandle("Deliver letter to Dave", "takequest")
    end
}
v2.Talk2 = {
    ["Text"] = "Ok my friend is at shells town, located in the direction im facing. Good luck!<AnimateYield=.45>",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = true
}
v2.lvlReq = 20
return v2