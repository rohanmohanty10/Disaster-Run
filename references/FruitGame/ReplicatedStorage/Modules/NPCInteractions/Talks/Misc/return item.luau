 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 1,
    ["Talk1"] = {
        ["Text"] = "<Color=Yellow>Thank you for finding it heres your reward!<Color=/>",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true
    }
}
return v2