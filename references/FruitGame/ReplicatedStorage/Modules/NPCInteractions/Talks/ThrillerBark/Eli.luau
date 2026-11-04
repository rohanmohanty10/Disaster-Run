 

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
    ["QuestName"] = "Help Eli",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Eli",
    ["lvlReq"] = 325
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Borj",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 5000,
        ["Peli"] = 1200
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<Color=Orange>Pharaoh Akshan<Color=/> sent me on a special mission to subdue <Color=Red>Borj<Color=/>.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "<Color=Red>Borj<Color=/> caused alot of trouble for our citizens back at the desert kingdom, his raw strength however is too strong for me...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "I dont think ill be able to handle his power, can you go in my place instead?",
    ["go"] = "Yes",
    ["stop"] = "No not my problem!",
    ["stoptext"] = "wow bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Eli", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright becareful he pounces and throws people alot.",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2