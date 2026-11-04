 

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
    ["QuestName"] = "Help max",
    ["QuestDesc"] = "beat monkey king",
    ["lvlReq"] = 65,
    ["NPC"] = "Max"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Gorilla King",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 800,
        ["Peli"] = 400
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "The gorilla king and his monkeys have taken over..",
    ["go"] = "what can i do",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "can u go slay gorila king for reward??",
    ["go"] = "yes i go beat monkey",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help max", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "watch out for the chest pound!!",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2