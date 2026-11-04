 

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
    ["QuestName"] = "Help Zanny",
    ["QuestDesc"] = "kill",
    ["lvlReq"] = 190,
    ["NPC"] = "Zanny"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Gravito",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 2400,
        ["Peli"] = 1000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Gravito keeps overpowering me, i cant do anything agianst the meteors he summons...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Do you think your strong enough to defeat him for me instead?",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "Aw, that\226\128\153s too bad. I had hoped that you were stronger...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Zanny", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "thanks bro",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2