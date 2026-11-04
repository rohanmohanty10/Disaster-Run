 

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
    ["QuestName"] = "Help Warren",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Warren",
    ["lvlReq"] = 425
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Scientist",
    ["Ammount"] = 25,
    ["Rewards"] = {
        ["EXP"] = 12000,
        ["Peli"] = 800
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "You might be wondering why im not in the factory with the other scientists...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "At first i thought it would be a good job to take on, but as time went on i realized the factorys true intentions and quit.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "When the factory opens i want you to defeat my ex cowokers.",
    ["go"] = "Ok!",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Warren", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright, but becareful if you take too long lava will start rising!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2