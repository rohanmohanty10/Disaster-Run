 

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
    ["QuestName"] = "Help PJ",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "PJ",
    ["lvlReq"] = 425
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Crazy Wolf",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 6000,
        ["Peli"] = 1000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "This forest has always been peaceful until those crazy wolfs moved in.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "I herd that its because of the appearance of a stone monster?... But im not too sure...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Im a bit busy working for my mom right now, can you take care of the wolves for me?",
    ["go"] = "Yea",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help PJ", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright thanks buddy!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2