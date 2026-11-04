 

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
    ["QuestName"] = "Find Tysoncat",
    ["QuestDesc"] = "d",
    ["NPC"] = "Tyson"
}
local v3 = {
    ["Type"] = "Find",
    ["MobName"] = "Cat",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 45,
        ["Peli"] = 50
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "yo bro i lost my cat",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "*wow...",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "can u finds my cat?",
    ["go"] = "yse!",
    ["stop"] = "NOPE",
    ["stoptext"] = "wow...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 29 ]]
        questHandle("Find Tysoncat", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "aigt thx bro",
    ["go"] = "Alright!",
    ["stop"] = "..",
    ["stoptext"] = "bro......",
    ["endtext"] = true
}
return v2