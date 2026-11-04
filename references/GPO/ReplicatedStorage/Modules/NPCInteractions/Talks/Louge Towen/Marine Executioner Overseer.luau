 

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
    ["NPC"] = "Marine Executioner Overseer",
    ["Talk1"] = {
        ["Text"] = "Would you like to put that person your carrying up for execution?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "...",
        ["go"] = "Thanks",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function(_) --[[ Name: excu, Line 21 ]]
            game.ReplicatedStorage.Events.LogueTownExcute:FireServer()
        end
    },
    ["NoCarry"] = {
        ["Text"] = "<Color=Red>Your not carrying any pirates for me to execute, come back when you do.<AnimateYield=1><Color=/>",
        ["go"] = "Ok",
        ["stop"] = "...",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["IsMarine"] = {
        ["Text"] = "<Color=Red>Silly fool<AnimateYield=.45>, you cant execute your own teammates...<AnimateYield=2><Color=/>",
        ["go"] = "Ok",
        ["stop"] = "...",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    },
    ["PIRATE"] = {
        ["Text"] = "<Color=Red>GO AWAY STINKY<Color=/>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2