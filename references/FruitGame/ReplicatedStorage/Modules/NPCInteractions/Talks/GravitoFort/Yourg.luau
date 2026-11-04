 

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
    ["QuestName"] = "Help Yourg",
    ["QuestDesc"] = "kill",
    ["lvlReq"] = 180,
    ["NPC"] = "Yourg"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Gravito\'s Guards",
    ["Ammount"] = 3,
    ["Rewards"] = {
        ["EXP"] = 1200,
        ["Peli"] = 900
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Gravito\'s guards keep guarding him i cant even touch that dude, his gravity moves always pushes me back and i get killed by the guards...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Do you mind doing me a favor and take care of the guards so i can defeat gravito?",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "Aw, that\226\128\153s too bad. I had hoped that you were stronger...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Yourg", "takequest")
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