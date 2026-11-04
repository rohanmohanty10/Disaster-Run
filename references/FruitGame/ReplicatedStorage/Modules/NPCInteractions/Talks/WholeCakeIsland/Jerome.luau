 

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
    ["QuestName"] = "Shatter the Mirror",
    ["QuestDesc"] = "Defeat the Mochi Emperor to free Jerome from the mirror room.",
    ["NPC"] = "Jerome",
    ["customQuestPosition"] = Vector3.new(-7639.619, 143.008, 10307.612),
    ["lvlReq"] = 625
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Mochi Emperor",
    ["Ammount"] = 1
}
local v4 = {
    ["EXP"] = 14000,
    ["Peli"] = 3500,
    ["Items"] = {
        ["Whole Cake Civilian Outfit 4"] = 1
    }
}
v3.Rewards = v4
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Help! I\226\128\153ve been trapped in this mirror room by the Mochi Emperor!",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "He\226\128\153s too powerful for me to escape on my own.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "If you defeat the Mochi Emperor, I can finally get out. Will you help me?",
    ["go"] = "I\226\128\153ll defeat him.",
    ["stop"] = "I can\226\128\153t.",
    ["stoptext"] = "I understand.",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 40 ]]
        questHandle("Shatter the Mirror", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Be careful. The Mochi Emperor\226\128\153s attacks can bend reality itself.<AnimateYield=1>",
    ["go"] = "Understood.",
    ["stop"] = "Back out.",
    ["stoptext"] = "...",
    ["endtext"] = true
}
return v2