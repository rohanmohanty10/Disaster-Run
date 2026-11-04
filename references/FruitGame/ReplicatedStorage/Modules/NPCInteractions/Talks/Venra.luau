 

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
    ["NPC"] = "Venra",
    ["Talk1"] = {
        ["Text"] = "Would you like to queue up for the next Karoo race?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Entry will cost <Color=Yellow>5000<Colo=/> peli, will you pay?",
        ["go"] = "Yes",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "Ok your in the queue now! Good luck!",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 29 ]]
            game.ReplicatedStorage.Events.KarooRace:InvokeServer("Add")
        end
    },
    ["full"] = {
        ["Text"] = "<Color=Red>The queue is currently full, wait until the next race is over!",
        ["go"] = "ok i go find for u!!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>You dont have enough peli!",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["noKaroo"] = {
        ["Text"] = "<Color=Red>You dont own a karoo mount!",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["inQueue"] = {
        ["Text"] = "<Color=Red>Your already in the queue!",
        ["go"] = "omg im sry bro!",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2