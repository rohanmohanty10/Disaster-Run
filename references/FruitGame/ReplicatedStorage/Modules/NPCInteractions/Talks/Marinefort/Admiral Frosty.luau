 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 4,
    ["QuestName"] = "Help Admiral Frosty",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Admiral Frosty",
    ["lvlReq"] = 265
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Captain Zhen",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 6000,
        ["Peli"] = 1200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hello there my name is Frosty, I wield the power of the <TextColor3=170,255,255>Hie<Color=/> fruit which allows me to use the abilities of ice.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "During the previous war with the pirates i was able to freeze <Color=Red>Captain Zhen<Color=/>. He possesses power that can destroy the world, however now he\'s in eternal slumber...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "I\'m afraid one day he will wake up and cause <Color=Red>destruction<Color=/> once again. I don\'t care if you\'re a marine or pirate but can you promise to subdue him when he reawakens?",
    ["go"] = "Yes i will try my best!",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Admiral Frosty", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright don\'t forget, he has the power of the <Color=ZBlue>Gura<Color=/> fruit which has immeasurable power.<AnimateYield=1> He can easily obliterate an entire army, keep your guard up!<AnimateYield=1> ",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2