 

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
    ["QuestName"] = "Find Tina\'s Clay pot",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Tina"
}
local v3 = {
    ["Type"] = "Find",
    ["MobName"] = "Clay pot",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 15,
        ["Peli"] = 8
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hello, i lost my pot while moving around on this island...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "*wow...",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you help me find my pot, it should be in one of these buildings on this island...",
    ["go"] = "Alright!",
    ["stop"] = "NOPE",
    ["stoptext"] = "wow...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 29 ]]
        questHandle("Find Tina\'s Clay pot", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Ok thanks",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "Aw, that\226\128\153s too bad. I had hoped that you were stronger...",
    ["endtext"] = true
}
return v2