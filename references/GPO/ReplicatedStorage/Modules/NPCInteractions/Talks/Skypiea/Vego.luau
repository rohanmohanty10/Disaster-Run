 

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
    ["QuestName"] = "Help vego",
    ["QuestDesc"] = "beat musk",
    ["lvlReq"] = 105,
    ["NPC"] = "Vego"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Sky District Bandit",
    ["Ammount"] = 5,
    ["Rewards"] = {
        ["EXP"] = 500,
        ["Peli"] = 200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "mgod The bandits have taken over this entire district, barly anyone resides here anymore...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Will ya go clean the area up for me?",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help vego", "takequest")
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