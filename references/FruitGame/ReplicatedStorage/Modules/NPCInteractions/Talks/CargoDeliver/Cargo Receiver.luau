 

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
    ["NPC"] = "Cargo Receiver",
    ["QuestInfo"] = {
        ["Type"] = "DeliverEnd",
        ["ItemName"] = "Cargo",
        ["QuestDeliveryName"] = "Deliver Civilian Cargo"
    },
    ["Talk1"] = {
        ["Text"] = "Thanks for delivering this cargo!",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "I\'ve paid the guy who requested you to deleiver. Have a nice day!<AnimateYield=.45>",
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
        ["Text"] = "Have any cargo?<AnimateYield=.45>",
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
        ["Text"] = "thanks for deliving the flag!1",
        ["go"] = "No problem.",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
v2.TalkFinished = v4
return v2