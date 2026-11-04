 

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
    ["NPC"] = script.Name,
    ["QuestInfo"] = {
        ["Type"] = "DeliverEnd",
        ["ItemName"] = "Bean Coffee",
        ["QuestDeliveryName"] = "Deliver Bean Coffee"
    },
    ["Talk1"] = {
        ["Text"] = "YOO FINALLY MY ORDER FORM BEAN CAFE!!",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "OMG I WAITED YEARS FOR THIS!!!!!!!!!!<AnimateYield=.45>",
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
        ["Text"] = "I\'ve ordered some coffee form bean cafe but still not here....<AnimateYield=.45>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
v2.TalkMissing = v3
return v2