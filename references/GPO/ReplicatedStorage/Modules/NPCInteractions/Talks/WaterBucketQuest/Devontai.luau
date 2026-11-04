 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Devontai",
    ["QuestInfo"] = {
        ["Type"] = "DeliverEnd",
        ["ItemName"] = "Water",
        ["QuestDeliveryName"] = "Deliver water to Devontai"
    },
    ["Talk1"] = {
        ["Text"] = "Oh dear me<AnimateYield=.45>, may the gods have mercy on our dry<AnimateYield=.45>, barren lands.<AnimateYield=.45> People living here are suffering due to thirst<AnimateYield=.45>, and I swear it\226\128\153s the fault of those wretched pirates!",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "I had heard from Haku that she has sent some kid to help our situation here.<AnimateYield=.45> Thank you<AnimateYield=.45>, youngster.",
        ["go"] = "No problem.",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["excu"] = function() --[[ Name: excu, Line 25 ]]
            game.ReplicatedStorage.Events.Quest:InvokeServer({ "deliverfinish" })
        end,
        ["endtext"] = true
    }
}
local v3 = {
    ["TalkAmmount"] = 1,
    ["Talk1"] = {
        ["Text"] = "I need you to go to Haku and bring water here!<AnimateYield=.45>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
v2.TalkMissing = v3
local v4 = {
    ["TalkAmmount"] = 1,
    ["Talk1"] = {
        ["Text"] = "Thanks for delivering the water!",
        ["go"] = "No problem.",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
v2.TalkFinished = v4
return v2