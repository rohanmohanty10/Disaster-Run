 

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
    ["QuestName"] = "Free the Captive",
    ["QuestDesc"] = "Defeat the Juice Empress and free the prisoner.",
    ["NPC"] = "Gwen",
    ["customQuestPosition"] = Vector3.new(-7639.619, 143.008, 10307.612),
    ["lvlReq"] = 625
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Juice Empress",
    ["Ammount"] = 1
}
local v4 = {
    ["EXP"] = 6500,
    ["Peli"] = 3000,
    ["Items"] = {
        ["Whole Cake Civilian Outfit 1"] = 1
    }
}
v3.Rewards = v4
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "You... you shouldn\'t be here. The Juice Empress rules the floor above us.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "She guards the Treasure Room, and my friend is being held there as a trophy.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Please... if you defeat the Juice Empress, you can free him. Will you help me?",
    ["go"] = "I\'ll save him.",
    ["stop"] = "I can\'t.",
    ["stoptext"] = "I understand...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 40 ]]
        questHandle("Free the Captive", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Be careful. She won\'t let anyone reach the Treasure Room alive.<AnimateYield=1>",
    ["go"] = "I won\'t fail.",
    ["stop"] = "Back out.",
    ["stoptext"] = "...",
    ["endtext"] = true
}
return v2