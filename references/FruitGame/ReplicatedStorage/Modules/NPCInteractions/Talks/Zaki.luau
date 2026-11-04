 

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
    ["QuestName"] = "Help Zaki",
    ["QuestDesc"] = "beat guard",
    ["lvlReq"] = 325,
    ["NPC"] = "Zaki"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Civilian",
    ["Ammount"] = 10,
    ["Rewards"] = {
        ["EXP"] = 700,
        ["Peli"] = 500
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "This city is too peacefull, the guards are strong and the civlians fight back...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Do you want to commit a evil deed so i can see this city in choas?",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help Zaki", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "hehe light this city up!!",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2