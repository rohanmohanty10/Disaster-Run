 

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
    ["NPC"] = " Lopi",
    ["Talk1"] = {
        ["Text"] = "You wondering where my house went?",
        ["go"] = "YES??",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "I\'ve deicded to move and find the 2SS master to teach me...",
        ["go"] = "...",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "I heard he lives on a island with his own dojo. Im so exited to go there and learn!!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "If you want to go try looking around this island on a ship...",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    }
}
return v2