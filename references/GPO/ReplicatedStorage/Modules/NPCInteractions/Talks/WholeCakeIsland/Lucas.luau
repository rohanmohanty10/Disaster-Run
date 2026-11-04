 

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
    ["QuestName"] = "End Big Mama",
    ["QuestDesc"] = "Clear Big Cake Tower and defeat Big Mama.",
    ["customQuestPosition"] = Vector3.new(-7639.619, 143.008, 10307.612),
    ["NPC"] = "Lucas",
    ["lvlReq"] = 635
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Big Mama",
    ["Ammount"] = 1
}
local v4 = {
    ["EXP"] = 25000,
    ["Peli"] = 3000,
    ["Items"] = {
        ["Whole Cake Civilian Outfit 3"] = 1
    }
}
v3.Rewards = v4
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "You made it. This portal leads directly to Big Mama\'s chamber.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Once you step through, there\'s no turning back. She won\'t let you escape.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Big Mama has ruled this tower long enough. Are you ready to end her reign?",
    ["go"] = "I\'m ready.",
    ["stop"] = "Not yet.",
    ["stoptext"] = "Take your time.",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 40 ]]
        questHandle("End Big Mama", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Then go. Step through the portal and bring her down.<AnimateYield=1>",
    ["go"] = "Let\'s finish this.",
    ["stop"] = "Back out.",
    ["stoptext"] = "...",
    ["endtext"] = true
}
return v2