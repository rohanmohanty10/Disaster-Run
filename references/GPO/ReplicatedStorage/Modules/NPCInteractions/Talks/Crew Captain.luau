 

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
    ["NPC"] = "Crew Captain",
    ["Talk1"] = {
        ["Text"] = "I can increase the max members of your crew with your conquest points, would you like to increase?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "...",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 21 ]]
            game.ReplicatedStorage.CrewRemote:InvokeServer({
                ["Method"] = "Purchase",
                ["PurchaseType"] = "UpgradeMaxMembers"
            })
        end
    },
    ["noCrew"] = {
        ["Text"] = "<Color=Red>Your not in any crew...",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["notOwner"] = {
        ["Text"] = "<Color=Red>It seems your crew was recently created or you are not the captain of your crew!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2