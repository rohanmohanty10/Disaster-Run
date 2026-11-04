 

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
    ["QuestName"] = "Help rae",
    ["QuestDesc"] = "beat burno",
    ["lvlReq"] = 140,
    ["NPC"] = "Rae"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Bruno",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 1000,
        ["Peli"] = 600
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Bruno has been here forever, hes always guarding the vine tree and i cant get up there to learn how to glide...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you go take care of him so i can get up the vine tree?",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help rae", "takequest")
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