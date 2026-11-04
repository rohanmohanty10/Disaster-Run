 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Helen",
    ["QuestName"] = "Deliver to Ego",
    ["QuestDesc"] = "Deliver carrot",
    ["Save"] = true
}
local v3 = {
    ["Type"] = "Deliver",
    ["MobName"] = "Carrot Bucket",
    ["Ammount"] = 1
}
local v4 = {
    ["EXP"] = 150,
    ["Peli"] = 50,
    ["Items"] = {
        ["SP Reset Essence"] = 1
    }
}
v3.Rewards = v4
v3.EndNPC = "Ego"
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey can you deliver these carrots to my friend at Zou?",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 24 ]]
        questHandle("Deliver to Ego", "takequest")
    end
}
v2.Talk2 = {
    ["Text"] = "Ok thanks!!1<AnimateYield=.45>",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = true
}
v2.lvlReq = 30
return v2