 

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
    ["NPC"] = "Brv1n",
    ["NotValidFruit"] = {
        ["Text"] = "<Color=Red>Seems like your fruit does not have an awakening...",
        ["go"] = "Your right...",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["BRTalk1"] = {
        ["Text"] = "Seems like your strong enough, do you want to awaken your fruit?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["BRTalk2"] = {
        ["Text"] = "I\'ve awakened your fruit, you better win!",
        ["go"] = "I can go get you some!",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 31 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("AwakenFruitBR")
        end
    },
    ["NotEnoughGrips"] = {
        ["Text"] = "<Color=Red>Your not strong enough, eliminate 3 people.",
        ["go"] = "Yes",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2