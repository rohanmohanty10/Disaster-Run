 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v3 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Blacksmith Sen",
    ["Talk1"] = {
        ["Text"] = "If you have <Color=Blue>Blueprints<Color=/> i can craft you items, are you interested?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Take a look!",
        ["go"] = "Ok",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = true,
        ["excu"] = function(p2) --[[ Name: excu, Line 21 ]]
            game.Players.LocalPlayer.PlayerGui.Crafting.Enabled = true
            game.Players.LocalPlayer.PlayerGui.Crafting.CraftingClient.Crafter.Value = p2
        end
    }
}
return v3