 

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
    ["NPC"] = "Bean Cafe Owner",
    ["QuestName"] = "Deliver Bean Coffee",
    ["QuestDesc"] = "Deliver coffee"
}
local v3 = {
    ["Type"] = "Deliver",
    ["MobName"] = "Bean Coffee Order",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 800,
        ["Peli"] = 600
    },
    ["EndNPC"] = "Bean Cafe Customer",
    ["block"] = true
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "I have orders that need to be deliverd to my customers all around the <Color=Orange>Desert kingdom<Color=/>, but i dont have enough workers...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Can you help me deliver some orders to my customers that are at the 2 other cities??",
    ["go"] = "Yes",
    ["stop"] = "no im busy",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 32 ]]
        questHandle("Deliver Bean Coffee", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright dont be late!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2