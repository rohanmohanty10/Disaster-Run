 

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
    ["NPC"] = "Teza",
    ["NotWings"] = {
        ["Text"] = "Have you ever wanted to glide? Well too bad you dont have wings!<AnimateYield=.45>",
        ["go"] = "No plz help",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["Talk1"] = {
        ["Text"] = "I can teach you how to glide if you pay me a small price :)<AnimateYield=.45>",
        ["go"] = "Yes",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Ok it will cost you 10000 peli, are you willing to learn?<AnimateYield=.45>",
        ["go"] = "Yes",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "Ok i\'ve taught you it, hold space in mid air to glide!<AnimateYield=.45> Falling form a high place then gliding will increase the speed!<AnimateYield=1> ",
        ["go"] = "Yes i have.",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 35 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Skypian")
        end
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>You dont have the money to learn!<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["got"] = {
        ["Text"] = "I\'ve already taught you how to glide!!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    }
}
return v2