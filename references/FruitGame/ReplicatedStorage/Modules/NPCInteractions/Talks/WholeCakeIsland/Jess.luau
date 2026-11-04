 

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
    ["QuestName"] = "Clear the Chess Guards",
    ["QuestDesc"] = "Defeat the Treasure Room soldiers to reach your friend.",
    ["customQuestPosition"] = Vector3.new(-7639.619, 143.008, 10307.612),
    ["NPC"] = "Jess",
    ["lvlReq"] = 540,
    ["floatingNPC"] = true
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Chess Soldier",
    ["Ammount"] = 20
}
local v4 = {
    ["EXP"] = 9000,
    ["Peli"] = 1500,
    ["Items"] = {
        ["Whole Cake Civilian Outfit 2"] = 1
    }
}
v3.Rewards = v4
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "The Treasure Room above is crawling with Chess Soldiers. They won\226\128\153t let anyone pass.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "My friend is being held there! I can\226\128\153t get to him while the guards are still active.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Please, you have to defeat some of those soldiers so I can reach my friend. Can you do it?",
    ["go"] = "I\226\128\153ll fight them.",
    ["stop"] = "I can\226\128\153t help.",
    ["stoptext"] = "I understand.",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 41 ]]
        questHandle("Clear the Chess Guards", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Be careful. They work in pairs and will overwhelm anyone unprepared.<AnimateYield=1>",
    ["go"] = "I\226\128\153ll handle it.",
    ["stop"] = "Back out.",
    ["stoptext"] = "...",
    ["endtext"] = true
}
return v2