 

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
    ["QuestName"] = "Help Ronny",
    ["QuestDesc"] = "defeat bandit boss",
    ["NPC"] = "Ronny",
    ["lvlReq"] = 5
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Bandit Boss",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 80,
        ["Peli"] = 75
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "The bandit boss has been ordering his people to attack us...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you go defeat the bandit boss? He might drop his eyepatch!",
    ["go"] = "yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Ronny", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "ok good luck",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2