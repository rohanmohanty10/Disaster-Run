 

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
    ["QuestName"] = "Help Marine Scout Milli",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Marine Scout Milli",
    ["lvlReq"] = 425
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Pica",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 20000,
        ["Peli"] = 2200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "I was sent here to investigate this area by Admiral Jackson...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "My findings suggest that behinde me something HUGE will come from underground. I\'ve spoken to a few civilians and they said that its a giant stone monster.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "I still have to report back to Admiral Jackson, but incase the monster appears can you hold him off for me?",
    ["go"] = "Yes i will try my best!",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Marine Scout Milli", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "oki thanks!<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2