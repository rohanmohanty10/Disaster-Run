 

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
    ["QuestName"] = "Help Dabo",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Dabo",
    ["lvlReq"] = 260
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Mini Bunny",
    ["Ammount"] = 10,
    ["Rewards"] = {
        ["EXP"] = 3000,
        ["Peli"] = 600
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "OMG ive been trying to defeat Blo the bunny but his mini bunnys are so annoying...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Wanna go exterminate them for me?",
    ["go"] = "yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Dabo", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "ok good luck!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2