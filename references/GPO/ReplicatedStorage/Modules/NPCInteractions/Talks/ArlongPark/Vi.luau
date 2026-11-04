 

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
    ["QuestName"] = "Help Vi",
    ["QuestDesc"] = "Take Arlong",
    ["lvlReq"] = 80,
    ["NPC"] = "Vi"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Saw Shark",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["Peli"] = 600,
        ["EXP"] = 1500
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Saw Shark is the boss of the pirates on this island, they been causing lots of problems.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "If you can defeat Saw Shark i will give you rewards : )",
    ["go"] = "Yes i will",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Vi", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright, then good luck. <AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2