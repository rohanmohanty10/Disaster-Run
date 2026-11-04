 

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
    ["QuestName"] = "Help Vak",
    ["QuestDesc"] = "beat guard",
    ["lvlReq"] = 325,
    ["NPC"] = "Vak"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Civilian",
    ["Ammount"] = 10,
    ["Rewards"] = {
        ["EXP"] = 700,
        ["Peli"] = 500
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Look at all those cilivans walking around!!",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Would be SUS if they all just disappeared >:)",
    ["go"] = "YES VERY SUS",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help Vak", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "sus....",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2