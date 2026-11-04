 

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
    ["QuestName"] = "Help Kevin",
    ["QuestDesc"] = "Take down 8 Shell\'s Bandits",
    ["lvlReq"] = 25,
    ["NPC"] = "Kevin"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Shell\'s Bandit",
    ["Ammount"] = 8,
    ["Rewards"] = {
        ["EXP"] = 200,
        ["Peli"] = 150
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Corrupt marines on the other side of the island are terroizing Robert<AnimateYield=.45>, on this side bandits are causing the trouble.<AnimateYield=.45>",
    ["go"] = "Need help?",
    ["stop"] = "..",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Yes help would be much appreciated<AnimateYield=.45>, if you can go defeat some bandits i\'ll reward you.<AnimateYield=.45>",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Kevin", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright be careful, these bandits are fast!<AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2