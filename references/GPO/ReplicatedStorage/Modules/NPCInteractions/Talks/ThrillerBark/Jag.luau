 

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
    ["QuestName"] = "Help Jag",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Jag",
    ["lvlReq"] = 350
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Ryuma",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 5000,
        ["Peli"] = 1200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<Color=Blue>Ryuma<Color=/> was my former master, he taught me everything i needed to become a good swordsman...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "However ever since he died, his body was possessed and he lost all his senses.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "At my current state im still not strong enough to defeat him, i dont want to see my master like this. Do you mind lending me a hand?",
    ["go"] = "Yes",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Jag", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright becareful, although hes a undead now, hes still very powerful!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2