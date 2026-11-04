 

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
    ["NPC"] = "Traveling Merchant",
    ["Talk1"] = {
        ["Text"] = "Ooh ooh ah ah! *tips my Blackvalk* I\'ve traveled across many islands collecting the finest treasures! Care to see my exotic wares?",
        ["go"] = "Show me!",
        ["stop"] = "Not interested",
        ["stoptext"] = "*counts gold coins* Your loss, friend! I\'ll be swinging to another island soon!",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Excellent choice! *rubs hands together*",
        ["go"] = "Open Shop",
        ["stop"] = "Maybe later",
        ["stoptext"] = "No bananas for you then! I\'ll be here for a short while if you change your mind!",
        ["endtext"] = true,
        ["afterEnd"] = function() --[[ Name: afterEnd, Line 21 ]]
            game.ReplicatedStorage.Events:FindFirstChild("TravelingMerchentRemote"):InvokeServer("OpenShop")
        end
    }
}
return v2