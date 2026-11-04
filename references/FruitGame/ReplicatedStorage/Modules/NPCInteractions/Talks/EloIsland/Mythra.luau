 

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
    ["QuestName"] = "Help Mythra",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Mythra",
    ["lvlReq"] = 285
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Blo The Bunny",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 7000,
        ["Peli"] = 2000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Blo the bunny is so big and chunky my attacks tickles him...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you go defeat him for me instead :)",
    ["go"] = "yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Mythra", "takequest")
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