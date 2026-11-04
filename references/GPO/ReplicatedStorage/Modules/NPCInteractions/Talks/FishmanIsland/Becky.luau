 

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
    ["QuestName"] = "Help becky",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Becky",
    ["lvlReq"] = 190
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Fishman Karate User",
    ["Ammount"] = 5,
    ["Rewards"] = {
        ["EXP"] = 1200,
        ["Peli"] = 500
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Fishman island is home to many strong users of fishman karate...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Want to test your self agaisnt them?",
    ["go"] = "yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help becky", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright dont let your guard down!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2