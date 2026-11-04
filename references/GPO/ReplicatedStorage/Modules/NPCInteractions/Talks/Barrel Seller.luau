 

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
    ["NPC"] = "Barrel Seller",
    ["Talk1"] = {
        ["Text"] = "Would you like to buy a barrel form me? You can sell these barrels for 10% more at the sellers.",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "<Color=Green>Ok here you go!",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 21 ]]
            game.ReplicatedStorage.Events.Barrel:FireServer({
                ["action"] = "Buy",
                ["barrelType"] = "Normal"
            })
        end
    },
    ["haveBarrel"] = {
        ["Text"] = "<Color=Red>You\'re already carrying a barrel, drop it before buying another one!<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>You dont have enough money to buy a barrel!<Color=/><AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2