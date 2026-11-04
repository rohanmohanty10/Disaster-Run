 

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
    ["QuestName"] = "Help Fhan",
    ["QuestDesc"] = "beat guard",
    ["lvlReq"] = 375,
    ["NPC"] = "Fhan"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Crab King Cho",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 4000,
        ["Peli"] = 3000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "YOOO ARE U THE GUY THAT ZERUS SAID IS COMING??",
    ["go"] = "yes....",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "PERFECT, DUDE I BEEN STUCK HERE FOR DAYS THE CRABS KEEP DANCING ON ME. THE KING CRAB IS SO CHUNKY I CANT DO ANYTHING TO IT!!!",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "CAN U GO KILL?",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 38 ]]
        questHandle("Help Fhan", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "ok good luck",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2