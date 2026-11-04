 

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
    ["QuestName"] = "Help Admiral Yon",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Admiral Yon",
    ["lvlReq"] = 350
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Moria",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 8000,
        ["Peli"] = 1200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hello there my name is Yon, i\'ve been sent by the marines to investigate this island.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "My findings show that the <Color=Arise>Shadow King<Color=/> will return soon, im not prepared and my backup isnt here yet.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "I\'m afraid that when the <Color=Arise>Shadow King<Color=/> does return i wont be able to fight. I don\'t care who you are but can you lend me a hand in defeating him?",
    ["go"] = "Yes i will try my best!",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Admiral Yon", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright don\'t forget, he has the power of the <Color=Arise>Kage<Color=/> fruit which has fatherless combos!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2