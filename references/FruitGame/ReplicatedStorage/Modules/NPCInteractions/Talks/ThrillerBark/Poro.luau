 

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
    ["lvlReq"] = 300,
    ["QuestName"] = "Help Poro",
    ["QuestDesc"] = "Take down 10 Zou Inhabitants",
    ["NPC"] = "Poro"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Zombie",
    ["Ammount"] = 10,
    ["Rewards"] = {
        ["EXP"] = 800,
        ["Peli"] = 700
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "The zombies are so annoying, they made those weird noises 24/7.",
    ["go"] = "...",
    ["stop"] = "Ignore",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "I assume you know what to do right?",
    ["go"] = "yes mommy",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Poro", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Ok you got this!",
    ["go"] = "yes sir",
    ["stop"] = "Bye",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2