 

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
    ["QuestName"] = "Help Miska",
    ["QuestDesc"] = "kill",
    ["lvlReq"] = 160,
    ["NPC"] = "Miska"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Gravito\'s Undermen",
    ["Ammount"] = 4,
    ["Rewards"] = {
        ["EXP"] = 800,
        ["Peli"] = 200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey i\'ve been trying to get past Gravito\'s Undermen but i havent made any progress...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "You seem strong enough to overpower them, can you go clear them out for me so i can get pass?",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "Aw, that\226\128\153s too bad. I had hoped that you were stronger...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Miska", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Thank you!!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2