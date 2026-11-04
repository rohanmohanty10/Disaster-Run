 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = game:GetService("ReplicatedStorage").Modules.Shared.Marketplace
local u3 = require(v2.Products)
local v4 = {
    ["TalkAmmount"] = 3,
    ["NPC"] = "Tari",
    ["Talk1"] = {
        ["Text"] = "I raise these birds also known as Karoos, karoos are really fast and can be used to travel long distances...",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Are you intrested in buying one for <Color=Green>150<Color=/> robux?",
        ["go"] = "Yes",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "Take care of your Karoo and remember to buy food to feed it when it gets tired!<AnimateYield=1>",
        ["go"] = "Yes",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 36 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer, u3:GetProductIdByPlace("Karoo Mount"))
        end
    },
    ["alreadyhave"] = {
        ["Text"] = "Take good care of your karoo!<AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v4