 

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
    ["QuestName"] = "Help Nami",
    ["QuestDesc"] = "Defeat buggy the clown",
    ["lvlReq"] = 50,
    ["NPC"] = "Aria"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Star Clown",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["Peli"] = 500,
        ["EXP"] = 1200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey wait! Want in on a <AnimateStyle=Rainbow><Color=Green>sweet deal<Color=/>?",
    ["go"] = "Yes",
    ["stop"] = "NOO",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Good, your task is simple: subdue infamous pirate <AnimateStyle=Wiggle><Color=Red>Star Clown<Color=/><AnimateStyle=/> for me while I pillage his treasure stash and I\'ll reward you with a portion of what I find. Sound good?",
    ["go"] = "Yes",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Nami", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright, then good luck to us both. <AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2