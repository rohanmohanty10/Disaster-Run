 

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
    ["QuestName"] = "Help Higa",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Higa",
    ["lvlReq"] = 240
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Marine Fort Kiribachi User",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 1700,
        ["Peli"] = 600
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Man ever sense the marines captured the saw shark, they been mass producing his weapon. That girl up front has that weapon and shes too strong for me to handle...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "You think your up for the job? To take her down?",
    ["go"] = "yes",
    ["stop"] = "noooooooooooo",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Higa", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "alright watch out, she can also use the skills that come with the weapon!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2