 

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
    ["Talk1"] = {
        ["Text"] = "zzzzzzzzzz",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "..............",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "zzzzz zzzzzzzzzz zzzzzzzzzzzzzzzzzzzzz",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["awaken"] = {
        ["Text"] = "i cee u has the fare escane,want to use on me//?/",
        ["go"] = "yes",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["awaken2"] = {
        ["Text"] = "prepare to <Color=Red>DIE",
        ["go"] = "yes",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 42 ]]
            task.wait(0.25)
            game.ReplicatedStorage.Events.summonWhite:FireServer()
        end
    }
}
return v2