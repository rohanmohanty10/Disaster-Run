 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
local _ = game.Players.LocalPlayer
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v3 = {
    ["TalkAmmount"] = 2,
    ["NPC"] = "Ash the Tailor",
    ["Talk1"] = {
        ["Text"] = "I can tailor your outfit or accessories! Change colors, adjust positions, toggle hair visibility - whatever you need!",
        ["go"] = "Lets do it!",
        ["stop"] = "Not interested",
        ["stoptext"] = "Come back when you are",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Excellent choice! Use the edit mode to position your accessories just right!",
        ["go"] = "Open Shop",
        ["stop"] = "Maybe later",
        ["stoptext"] = "",
        ["endtext"] = true,
        ["afterEnd"] = function(p2) --[[ Name: afterEnd, Line 22 ]]
            game.ReplicatedStorage.Events:FindFirstChild("customTailor"):FireServer(p2)
        end
    }
}
return v3