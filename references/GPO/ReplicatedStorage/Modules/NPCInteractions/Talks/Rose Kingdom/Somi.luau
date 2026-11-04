 

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
    ["QuestName"] = "Help Somi",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Somi",
    ["lvlReq"] = 425
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Donmingo",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 20000,
        ["Peli"] = 2200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey there, looks like you\'ve finally made it all the way up here...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "If your wondering that this place is, its a mansion owned by Donmingo, the ruler of this island. He rules with power and fear, and is usally away from the island.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "I feel he will return soon, if he does can you defeat him and send him back?",
    ["go"] = "Yes i will try my best!",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Somi", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright, but becareful theres a reason why he can rule with power and fear!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2