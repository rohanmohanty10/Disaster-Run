 

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
    ["QuestName"] = "Help viva",
    ["QuestDesc"] = "beat viva",
    ["lvlReq"] = 140,
    ["NPC"] = "Viva"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Malcolm",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 700,
        ["Peli"] = 500
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Malcolm and his gang have over taken the island above...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you go take care of them??",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help viva", "takequest")
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