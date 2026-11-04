 

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
    ["QuestName"] = "Help Rice",
    ["QuestDesc"] = "Take down 7 Krieg Pirates",
    ["lvlReq"] = 40,
    ["NPC"] = "Chef Rice"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Krieg Pirate",
    ["Ammount"] = 8,
    ["Rewards"] = {
        ["EXP"] = 350,
        ["Peli"] = 150
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "um hi my resturant under attack by pirate!!!!",
    ["go"] = "omg bro need help??",
    ["stop"] = "Ignore",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "yes plz if u can help i reward u!!.<AnimateYield=.45>",
    ["go"] = "yes!!",
    ["stop"] = "Bye",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Rice", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "ok good luck bye!!.<AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2