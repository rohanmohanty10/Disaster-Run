 

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
    ["QuestName"] = "Help jenny",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Jenny",
    ["lvlReq"] = 210
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Ryu",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 1500,
        ["Peli"] = 600
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Ryu is one of the best, if not the best swordsman on fishman island...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Would to like to challenge him? If you manage to win and prove your self worthy i can award you for your accomplishment.",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help jenny", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Ok good luck and stay on guard!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2