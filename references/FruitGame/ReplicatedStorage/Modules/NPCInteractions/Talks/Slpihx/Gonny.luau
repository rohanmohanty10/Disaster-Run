 

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
    ["QuestName"] = "Help gonny",
    ["QuestDesc"] = "beat monkey",
    ["lvlReq"] = 55,
    ["NPC"] = "Gonny"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Monkey",
    ["Ammount"] = 10,
    ["Rewards"] = {
        ["EXP"] = 400,
        ["Peli"] = 200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Outside of this waterfall, monkeys have taken over this island...",
    ["go"] = "what can i do",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "If u can go defeat some monkeys for me ill give reward.",
    ["go"] = "yes i go beat monkey",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help gonny", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "ok good luck and watch out for the Gorilla King",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2