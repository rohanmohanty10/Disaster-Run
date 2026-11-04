 

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
    ["QuestName"] = "Help Marine Scout Rae",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Marine Scout Rae",
    ["lvlReq"] = 350
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Zombie Knight",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 4000,
        ["Peli"] = 800
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<Color=Blue>Admiral Yon<Color=/> told me to scout ahead, and it seems we have ran into an issue.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "The ammount of zombie knights in the castle is too much for us to handle...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Would you mind assisting us in defeating those zombie knights?",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Marine Scout Rae", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright, just watch out, these knights all know how to use 1SS!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2