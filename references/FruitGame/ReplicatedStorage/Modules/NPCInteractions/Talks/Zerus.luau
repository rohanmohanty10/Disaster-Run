 

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
    ["QuestName"] = "Help Zerus",
    ["QuestDesc"] = "beat guard",
    ["lvlReq"] = 325,
    ["NPC"] = "Zerus"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Crab Minion",
    ["Ammount"] = 5,
    ["Rewards"] = {
        ["EXP"] = 700,
        ["Peli"] = 500
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Those mini crabs are guarding the cave down this path that im trying to get into, my friend is stuck in there with those crabs!!",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you take care of some mini crabs for me???",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help Zerus", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "ok good luck",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2