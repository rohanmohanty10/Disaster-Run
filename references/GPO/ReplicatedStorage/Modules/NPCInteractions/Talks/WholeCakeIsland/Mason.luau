 

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
    ["QuestName"] = "Clear the Forest",
    ["QuestDesc"] = "Defeat the homies in the forest so Jerome can return to his city.",
    ["NPC"] = "Mason",
    ["lvlReq"] = 600,
    ["bypassComplete"] = true,
    ["MiscQuest"] = true
}
local v3 = {
    ["Type"] = "Defeat"
}
local v4 = {}
local v5 = {
    ["Type"] = "Defeat",
    ["MiscType"] = "Banana Bunch",
    ["MobName"] = "Banana Chocolate Homie",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 1500,
        ["Peli"] = 1000
    }
}
v4[1] = v5
local v6 = {
    ["Type"] = "Defeat",
    ["MiscType"] = "Dark Grin",
    ["MobName"] = "Dark Smiley Homie",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 3000,
        ["Peli"] = 1000
    }
}
v4[2] = v6
local v7 = {
    ["Type"] = "Defeat",
    ["MiscType"] = "Rotten Apples",
    ["MobName"] = "Red Apple Homie",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 1500,
        ["Peli"] = 1000
    }
}
v4[3] = v7
local v8 = {
    ["Type"] = "Defeat",
    ["MiscType"] = "Sweet Destruction",
    ["MobName"] = "Strawberry Cake Homie",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 3000,
        ["Peli"] = 1000
    }
}
v4[4] = v8
v3.MultiQuest = v4
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Please, you have to help me. Big Mama\'s homies have taken over the forest.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "I\'ve been stranded at these docks for days. Every time I try to pass, they swarm me.",
    ["go"] = "...",
    ["stop"] = "Leave",
    ["stoptext"] = "Leave",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Clear some of them out for me. Thin their numbers so I can get back to my city.",
    ["go"] = "I\'ll handle it.",
    ["stop"] = "Not my problem.",
    ["stoptext"] = "I understand.",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 66 ]]
        questHandle("Clear the Forest", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Watch yourself out there. They may look like sweets but they hit hard.<AnimateYield=1>",
    ["go"] = "I\'m ready.",
    ["stop"] = "Back out.",
    ["stoptext"] = "...",
    ["endtext"] = true
}
return v2