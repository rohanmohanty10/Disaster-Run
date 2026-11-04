 

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
    ["QuestName"] = "Help Frutose",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Frutose",
    ["lvlReq"] = 265
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Flame Admiral Zeke",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 3500,
        ["Peli"] = 900
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "This floor is where the <Color=Red>Flame Admiral Zeke<Color=/> resides. The flame admiral has the power of the <Color=Red>Mera<Color=/> fruit which makes him extremely powerful.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Would you want to attempt to take him down?",
    ["go"] = "yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Frutose", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright dont forget, he has the power of the <Color=Red>Mera<Color=/> fruit which means you will need haki to damage him<AnimateYield=1>!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2