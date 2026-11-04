 

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
    ["QuestName"] = "Help musk",
    ["QuestDesc"] = "beat musk",
    ["lvlReq"] = 135,
    ["NPC"] = "Musk"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Head Guardian",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 800,
        ["Peli"] = 350
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "The head guardian is just too strong for me, ive been trying to fight him for a while but havent made any progress...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Will you be willing to take him down for me?",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help musk", "takequest")
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