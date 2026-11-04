 

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
        ["Text"] = "Im the bounty collector at this island<AnimateYield=.35>, the bounty board shows everyone that you can hunt!",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["TalkStart"] = {
        ["Text"] = "Would you like to collect this guys bounty?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Ok here are your rewards<AnimateYield=.45>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function(p2) --[[ Name: excu, Line 27 ]]
            game.ReplicatedStorage.Events.BountyPoster:FireServer(p2)
        end
    }
}
return v3