 

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
    ["NPC"] = "Phoeating",
    ["lvlReq"] = 0,
    ["Talk1"] = {
        ["Text"] = "I can help bring back your teammates into the game if you have enough <Color=Green>Life Essences<Color=/>.",
        ["go"] = "...",
        ["stop"] = "bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "You will need 2 <Color=Green>Life Essences<Color=/> for duos, 3 for trios, and 4 for squads. Would you like to proceed?",
        ["go"] = "yee",
        ["stop"] = "no",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "alr i gave u edo tensei",
        ["go"] = "Ok!!!",
        ["stop"] = "Sorry, I\226\128\153m not ready.",
        ["stoptext"] = "ok bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 30 ]]
            if game.ReplicatedStorage:FindFirstChild("matchEvents") then
                game.ReplicatedStorage.matchEvents:FireServer("coffin")
            end
        end
    },
    ["notenough"] = {
        ["Text"] = "<Color=Red>u not have enough life essence",
        ["go"] = "Alright!",
        ["stop"] = "Sorry, I\226\128\153m not ready.",
        ["stoptext"] = "ok bye",
        ["endtext"] = true
    }
}
return v2