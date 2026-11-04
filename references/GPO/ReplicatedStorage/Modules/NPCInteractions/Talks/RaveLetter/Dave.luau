 

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
    ["NPC"] = "Dave",
    ["QuestInfo"] = {
        ["Type"] = "DeliverEnd",
        ["ItemName"] = "Rave\'s Letter",
        ["QuestDeliveryName"] = "Deliver letter to Dave"
    },
    ["Talk1"] = {
        ["Text"] = "OMG RAVE GAVE ME THE LETTER",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "THX SO MUCH BRO HERE UR REWARD!!<AnimateYield=.45>",
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
        ["Text"] = "My friend rave, at sandora has something to tell me!<AnimateYield=.45>",
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
        ["Text"] = "Thanks for delivering the letter!",
        ["go"] = "No problem.",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
v2.TalkFinished = v4
return v2