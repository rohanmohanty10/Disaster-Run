 

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
    ["QuestName"] = "Help Mur",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Mur",
    ["lvlReq"] = 325
}
local v3 = {
    ["Type"] = "Awaken",
    ["MobName"] = "Moria",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 2000,
        ["Peli"] = 900
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "The <Color=Arise>Shadow King<Color=/> was defeated and sent back to the depths...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Inside the castle theres a special door with a ritual, if you can somehow bring the <Color=Arise>Shadow King<Color=/> back ill pay u hefty.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Just be careful, once the <Color=Arise>Shadow King<Color=/> is back theres no telling of what he will do.",
    ["go"] = "Yes for sure!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Mur", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright good luck.",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2