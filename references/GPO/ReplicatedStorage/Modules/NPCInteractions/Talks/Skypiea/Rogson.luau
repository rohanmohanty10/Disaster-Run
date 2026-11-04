 

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
    ["NPC"] = "Rogson",
    ["QuestName"] = "Road to observation",
    ["QuestDesc"] = "kenhaki",
    ["Save"] = true,
    ["lvlReq"] = 165
}
local v3 = {
    ["Type"] = "Perfect Block",
    ["Ammount"] = 200,
    ["MobName"] = "Block",
    ["Rewards"] = {
        ["KenMastery"] = 1
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Want to learn how to evade attacks?",
    ["go"] = "Yes i want to learn...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Its gona cost ya 50k peli my stuff aint free...",
    ["go"] = "yes i will pay",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Ait you going to have to go throuh my training as well<AnimateYield=.45>, you gotta perfect block 200 times and if you quit your going to have to pay me aigan!",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 39 ]]
        questHandle("Road to observation", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Ok lets begin the training now!",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
v2.masterd = {
    ["Text"] = "I\'ve already taught you how to evade attacks...",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
v2.nomoney = {
    ["Text"] = "<Color=Red>bro ya dont got enuh money",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2