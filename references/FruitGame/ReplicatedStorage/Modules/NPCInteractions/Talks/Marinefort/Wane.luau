 

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
    ["QuestName"] = "Help Wane",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Wane",
    ["lvlReq"] = 215
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Marine Fort Sniper",
    ["Ammount"] = 2,
    ["Rewards"] = {
        ["EXP"] = 1200,
        ["Peli"] = 400
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Ive been trying to <Color=Red>breach<Color=/> my way into the fort but the snipers on top of the tower keep shooting at me...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Mind taking them down for me so i can enter??",
    ["go"] = "yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Wane", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright dont die form those BURN bazookas<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2