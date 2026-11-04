 

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
    ["QuestName"] = "Help Noah",
    ["QuestDesc"] = "Defeat desert bandits for noah",
    ["lvlReq"] = 10,
    ["NPC"] = "Noah"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Desert Bandit",
    ["Ammount"] = 7,
    ["Rewards"] = {
        ["EXP"] = 125,
        ["Peli"] = 75
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Sigh, times have indeed been tough.<AnimateYield=.45> Our lands are dry<AnimateYield=.45>, water is scarce, and there are Pirates running around stealing the limited amounts of supplies we have.",
    ["go"] = "How can i help?",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Oh traveler<AnimateYield=.45>, please defeat those bandits in our stead<AnimateYield=.45>, as we do not have the strength to do so.",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "Aw, that\226\128\153s too bad. I had hoped that you were stronger...",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Noah", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "With this<AnimateYield=.45>, our people can be at ease. Thank you<AnimateYield=.45>, brave one.",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2