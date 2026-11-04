 

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
    ["NPC"] = "Brad",
    ["Talk1"] = {
        ["Text"] = "Hey pal want me to coat you with my special bubble? It will let you stay underwater for a longer peroid of time but if you lose 10% hp your bubble will pop.",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "It will cost you <Color=Yellow>2000<Color=/> Peli per bubble, are you willing to buy one?",
        ["go"] = "yes plz",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "ok i gaved u ur bubble :)",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function(_) --[[ Name: excu, Line 29 ]]
            game.ReplicatedStorage.Events.Bubble:FireServer()
        end
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>Sorry pal, you dont have enough money to buy a bubble!<AnimateYield=1>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["already"] = {
        ["Text"] = "<Color=Red>Bro u already have a bubble, why u need another one??<AnimateYield=1>",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    }
}
return v2