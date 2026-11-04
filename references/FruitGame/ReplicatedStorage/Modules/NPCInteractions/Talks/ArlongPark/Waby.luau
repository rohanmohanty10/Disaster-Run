 

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
    ["QuestName"] = "Help Waby",
    ["QuestDesc"] = "Take down Arlong Pirates",
    ["lvlReq"] = 70,
    ["NPC"] = "Waby"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Saw Shark Pirate",
    ["Ammount"] = 10,
    ["Rewards"] = {
        ["Peli"] = 250,
        ["EXP"] = 450
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "The Saw Shark pirates have taken over this island.",
    ["go"] = "Yes",
    ["stop"] = "NOO",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "If you can take care of some of those pirates on the other side of the island ill reward you!!",
    ["go"] = "Yes i will",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Waby", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright, then good luck. <AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2