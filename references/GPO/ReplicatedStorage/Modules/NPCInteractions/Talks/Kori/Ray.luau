 

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
    ["QuestName"] = "Road to Armament",
    ["QuestDesc"] = "Take down 100 Yetis",
    ["lvlReq"] = 80,
    ["NPC"] = "Ray",
    ["Save"] = true
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Yeti",
    ["Ammount"] = 50,
    ["Rewards"] = {
        ["BusoMastery"] = 1
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Ahoy, what can I do ye for?",
    ["go"] = "Teach me Armament",
    ["stop"] = "Notthing",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Tell you what, why don\'t ye fork over 25,000 peli real quick? Just as a sign of good will, ya know. ",
    ["go"] = "Yes sir i have ur money",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Heh heh, good. But I\'m also gonna need ye to defeat a few yetis for me. <AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 38 ]]
        questHandle("Road to Armament", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Ok go get movin, if you die good luck getting back. <Color=Red>If you QUIT this quest you will have to pay me aigan!!<AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
v2.Talk5 = {
    ["Text"] = "<Color=Red>BRO U DONT HAVE THE MONEY OMG!! BYE BYE!! <AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2