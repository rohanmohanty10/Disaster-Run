 

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
    ["NPC"] = "Snaytona",
    ["QuestInfo"] = {
        ["Type"] = "DeliverEnd",
        ["ItemName"] = "Rainbow Flag",
        ["QuestDeliveryName"] = "Deliver to Snaytona"
    },
    ["Talk1"] = {
        ["Text"] = "Thanks for brining my favotire flag!!",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "i can finally attend the meetnig!!<AnimateYield=.45>",
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
        ["Text"] = "bestie go to RVK get my flag!<AnimateYield=.45>",
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