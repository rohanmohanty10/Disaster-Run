 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v3 = {
    ["TalkAmmount"] = 1,
    ["Talk1"] = {
        ["Text"] = "u handcuff yes?? <AnimateYield=.45> i help free for <Color=Green>$$$$<Color=/> <AnimateYield=.45> :      ) <AnimateYield=.45>",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["TalkStart"] = {
        ["Text"] = "want me free u for 75 mone??????????",
        ["go"] = "yeye",
        ["stop"] = "No",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "ok im free u now thx for moeny :))",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function(p2) --[[ Name: excu, Line 27 ]]
            game.ReplicatedStorage.Events.Cuff:FireServer(nil, nil, p2)
        end
    }
}
return v3