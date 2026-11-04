 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 4,
    ["QuestName"] = "Help Niki",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Niki",
    ["lvlReq"] = 425
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Bellom",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 10000,
        ["Peli"] = 2200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "um... i scare....",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Do you see that guy over there with springs all over his body?... Hes been terrorizing this entire area...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Can you take care of him?",
    ["go"] = "ya",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Niki", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Ok and good luck!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2