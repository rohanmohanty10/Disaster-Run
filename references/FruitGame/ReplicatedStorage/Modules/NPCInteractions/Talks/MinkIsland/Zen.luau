 

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
    ["lvlReq"] = 30,
    ["QuestName"] = "Help Zen",
    ["QuestDesc"] = "Take down 7 Zou Inhabitants",
    ["NPC"] = "Zen"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Zou Inhabitant",
    ["Ammount"] = 7,
    ["Rewards"] = {
        ["EXP"] = 250,
        ["Peli"] = 150
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "hey bro can u go defeat me some people, they r mad",
    ["go"] = "yeye",
    ["stop"] = "Ignore",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "ok see those zou people over there??? i need u go take down 7 of them",
    ["go"] = "yes sir",
    ["stop"] = "Bye",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Zen", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "ok go fast and come fast1!!1",
    ["go"] = "yes sir",
    ["stop"] = "Bye",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2