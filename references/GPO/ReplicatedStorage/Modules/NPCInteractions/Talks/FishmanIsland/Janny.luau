 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 3,
    ["QuestName"] = "Help janny",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Janny",
    ["lvlReq"] = 230
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Neptune",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 3000,
        ["Peli"] = 1000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Neptune has been ruling fishman island for decades, hes refused to step down form his throne and we cant do much about it because of his power.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Will you be willing to help us take him down, i personally will reward you nicely!",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help janny", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright, good luck hes very strong because of his fishman karate and trident!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2