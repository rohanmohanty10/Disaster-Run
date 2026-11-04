 

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
    ["QuestName"] = "Help zhen",
    ["QuestDesc"] = "beat zhen",
    ["lvlReq"] = 110,
    ["NPC"] = "Zhen"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Castle Guard",
    ["Ammount"] = 5,
    ["Rewards"] = {
        ["EXP"] = 700,
        ["Peli"] = 200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "I\'ve been trying to get into the castle but i keep getting stopped by the guards...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you help me take down some guards so i can get in and start eating??",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help zhen", "takequest")
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