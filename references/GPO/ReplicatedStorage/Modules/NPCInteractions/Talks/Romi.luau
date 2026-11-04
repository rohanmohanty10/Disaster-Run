 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
local _ = game.Players.LocalPlayer
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Romi",
    ["Talk1"] = {
        ["Text"] = "I can convert your <Color=Blue>Race Rerolls<Color=/> into <Color=Blue>Race Reroll Tokens<Color=/> which are tradeable. You can also redeem them to get your rerolls back.",
        ["go"] = "Lets do it!",
        ["stop"] = "Not interested",
        ["stoptext"] = "Come back when you are",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Excellent choice!",
        ["go"] = "Open Shop",
        ["stop"] = "Maybe later",
        ["stoptext"] = "",
        ["endtext"] = true,
        ["afterEnd"] = function(_) --[[ Name: afterEnd, Line 24 ]]
            game.ReplicatedStorage.Events:FindFirstChild("RaceRerollConversion"):FireServer()
        end
    }
}
return v2