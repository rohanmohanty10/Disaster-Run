 

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
    ["QuestName"] = "Help Pichu",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Pichu",
    ["lvlReq"] = 230
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Marine Fort Gunner",
    ["Ammount"] = 4,
    ["Rewards"] = {
        ["EXP"] = 1200,
        ["Peli"] = 400
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Omg the people with those big bazookas keep spoting me, ive been hiding down here to avoid detection...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "u wana go and punch their heads for me?",
    ["go"] = "yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Pichu", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "dont get bullied by those bazookas!!!!!!!!!!!!!!!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2