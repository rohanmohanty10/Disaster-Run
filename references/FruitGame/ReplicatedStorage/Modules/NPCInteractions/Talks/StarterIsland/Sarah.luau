 

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
    ["QuestName"] = "Find Sarah\'s necklace",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Sarah",
    ["lvlReq"] = 3
}
local v3 = {
    ["Type"] = "Find",
    ["MobName"] = "Necklace",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 5,
        ["Peli"] = 25
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<AnimateStyle=Wiggle><Color=125,255,217>*sniffle* *sniffle*<Color=/><AnimateYield=.25><AnimateStyle=/>  Please help me! I lost my necklace while I was running away from those bandits.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "*sniff* *sniff* : (",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Find it for me, I beg of you! I\'ll give you a reward if you bring it back.",
    ["go"] = "Alright!",
    ["stop"] = "Sorry your on your own!",
    ["stoptext"] = "*sniff* *sniff* : (",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Find Sarah\'s necklace", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Thank you so much! ;)",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "Aw, that\226\128\153s too bad. I had hoped that you were stronger...",
    ["endtext"] = true
}
return v2