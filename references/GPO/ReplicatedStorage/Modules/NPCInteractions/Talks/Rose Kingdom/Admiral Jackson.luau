 

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
    ["QuestName"] = "Help Admiral Jackson",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Admiral Jackson",
    ["lvlReq"] = 425
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Law",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 15000,
        ["Peli"] = 2200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Seems like you\'ve made it far enough,i assume you know what this factory is for?",
    ["go"] = "Yes i do!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "The regular scientists are no match for us, however once we defeat them all the real threat occurs.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "The higherups will send Law, one who is able to wield the powers of the Ope-Ope fruit. I myself wont be able to defeat him, will you help me?",
    ["go"] = "Ok!",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Admiral Jackson", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright you alone might not be enough so gather your friends if you have any!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2