 

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
    ["QuestName"] = "Help bibby",
    ["QuestDesc"] = "beat bibby",
    ["lvlReq"] = 135,
    ["NPC"] = "Bibby"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Malcolm\'s Undermen",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 750,
        ["Peli"] = 400
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Malcolm\'s Undermen have been casuing trobule lately!!",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "They took cover with their boss on the island up the bridge, can you go take care of the undermen?",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help bibby", "takequest")
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