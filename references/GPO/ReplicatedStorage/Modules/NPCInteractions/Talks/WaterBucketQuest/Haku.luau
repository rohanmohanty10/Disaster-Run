 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 6,
    ["NPC"] = "Haku",
    ["QuestName"] = "Deliver water to Devontai",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["Save"] = true,
    ["GiveItems"] = { "Sandora Eternal Pose" },
    ["lvlReq"] = 7
}
local v3 = {
    ["Type"] = "Deliver",
    ["MobName"] = "Water Bucket",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 100,
        ["Peli"] = 25
    },
    ["EndNPC"] = "Devontai"
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey, I\226\128\153m <Color=Yellow>Haku<Color=/> and, I love traveling!",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "If you don\226\128\153t mind<AnimateYield=.45>, I have a request for you.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Due to the <Color=Red>unbearable heat<Color=/> in Sandora<AnimateYield=.45>, the people living there are <Color=Red>dying<Color=/> from thirst.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk4 = {
    ["Text"] = "Could you go there and deliver this bucket of <Color=Blue>water<Color=/> to Devontai? It would be greatly appreciated!",
    ["go"] = "Alright!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk5 = {
    ["Text"] = "To aid you on this mission, i will give you a <Color=Blue>Eternal pose<Color=/>, which will show you the direction of Sandora incase you get lost.",
    ["go"] = "Alright!",
    ["stop"] = "I\226\128\153m sorry, I can\226\128\153t.",
    ["stoptext"] = "Wow, really? That\226\128\153s too bad...",
    ["result"] = function(_) --[[ Name: result, Line 53 ]]
        questHandle("Deliver water to Devontai", "takequest")
    end,
    ["endtext"] = false
}
v2.Talk6 = {
    ["Text"] = "Good luck and dont get hurt!",
    ["go"] = "Alright!",
    ["stop"] = "I\226\128\153m sorry, I can\226\128\153t.",
    ["stoptext"] = "Wow, really? That\226\128\153s too bad...",
    ["endtext"] = true
}
return v2