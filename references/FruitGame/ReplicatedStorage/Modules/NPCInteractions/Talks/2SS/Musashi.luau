 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 4,
    ["NPC"] = "Musashi",
    ["Talk1"] = {
        ["Text"] = "Hello there, im Musashi the founder of Two Sword Style...",
        ["go"] = "bro teach me!!",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "I can teach you my ways thru sparing matches, if you can defeat me within the time allotted i will pass down a book for each match.",
        ["go"] = "yeye i have ur money",
        ["stop"] = "bye bye",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "My spars arent free, are you willing to pay <Color=Yellow>10000<Color=/> peli?",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "Alright lets begin our match!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 35 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("2SSMatch")
        end
    },
    ["nomoney"] = {
        ["Text"] = "... <Color=Red>u dont have enough money<Color=/>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["max"] = {
        ["Text"] = "You\'ve mastered my ways...",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["notWorth"] = {
        ["Text"] = "<Color=Red>You are not worthy of my teachings!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["have"] = {
        ["Text"] = "<Color=Red>Learn the next skill form the current book that you have before sparing with me aigan!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true
    },
    ["switch1"] = {
        ["Text"] = "Would you like to switch back to 2SS?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["switch2"] = {
        ["Text"] = "Ok your style has been switched!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 85 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("2SS")
        end
    }
}
return v2