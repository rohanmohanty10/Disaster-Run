 

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
    ["NPC"] = "Barrel Buyer",
    ["Talk1"] = {
        ["Text"] = "I buy barrels for money, do you have one to sell to me?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "<Color=Green>yes i buyed ur barrel, come back if u have more!!",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 21 ]]
            game.ReplicatedStorage.Events.Barrel:FireServer({
                ["action"] = "Sell",
                ["barrelType"] = "Normal"
            })
        end
    },
    ["noBarrel"] = {
        ["Text"] = "<Color=Red>You\'re not holding a barrel for me to buy!<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2