 

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
    ["QuestName"] = "Help Ian",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Ian",
    ["lvlReq"] = 425
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Donmingo Family",
    ["Ammount"] = 4,
    ["Rewards"] = {
        ["EXP"] = 10000,
        ["Peli"] = 800
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey there, i\'m originally from the <Color=Orange>Desert Kingdom<Color=/>, but <Color=Orange>Pharaoh Akshan<Color=/> has sent me to investigate this neighboring kingdom...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "It seems like <Color=Pink>Donmingo<Color=/> is planning a attack agaisnt my kingdom, right now i cant do much about it...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "The only thing i can think of is to target his family so he knows he messed with the wrong kingdom. His family is scattered around the island. Would you mind doing that for me?",
    ["go"] = "Yes i will do!",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Ian", "takequest")
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