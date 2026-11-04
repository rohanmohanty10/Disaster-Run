 

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
    ["QuestName"] = "Help Anty",
    ["QuestDesc"] = "beat guard",
    ["lvlReq"] = 325,
    ["NPC"] = "Anty"
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
    ["Text"] = "i hate this place...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "civlian go brrrrrrrrrrrrrrrr???",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help Anty", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2