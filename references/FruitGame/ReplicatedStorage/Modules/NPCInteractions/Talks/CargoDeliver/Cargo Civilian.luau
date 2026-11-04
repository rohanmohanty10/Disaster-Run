 

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
    ["NPC"] = "Cargo Civilian",
    ["QuestName"] = "Deliver Civilian Cargo",
    ["QuestDesc"] = "Deliver cargo"
}
local v3 = {
    ["Type"] = "Deliver",
    ["MobName"] = "Cargo",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 800,
        ["Peli"] = 500
    },
    ["EndNPC"] = "Cargo Receiver",
    ["block"] = true
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey there i have cargo that needs to be delivered so that i get paid...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "I can split the pay with you if you help me deliver it :) What do you say?",
    ["go"] = "Yes i will help you!",
    ["stop"] = "no im busy",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 32 ]]
        questHandle("Deliver Civilian Cargo", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Ok good luck, godspeed!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2