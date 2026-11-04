 

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
    ["QuestName"] = "Help crim",
    ["QuestDesc"] = "beat guard",
    ["lvlReq"] = 325,
    ["NPC"] = "City Criminal"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Kingdom Guards",
    ["Ammount"] = 6,
    ["Rewards"] = {
        ["EXP"] = 1000,
        ["Peli"] = 800
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Everytime i try murder someone the guards just keep coming after me!",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Do you think you can distract and defeat the guards while i do my dity work?",
    ["go"] = "YES",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help crim", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "hehe good looks...",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2