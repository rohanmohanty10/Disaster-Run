 

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
    ["QuestName"] = "Help Robert",
    ["QuestDesc"] = "Take down 8 corrupt marines",
    ["lvlReq"] = 20,
    ["NPC"] = "Robert"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Corrupt Marine",
    ["Ammount"] = 8,
    ["Rewards"] = {
        ["EXP"] = 175,
        ["Peli"] = 100
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<Color=Red>Huffs Puffs Urrrgghhhhhh<Color=/><AnimateYield=.45>",
    ["go"] = "You alright?",
    ["stop"] = "Ignore",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "The marines... those suit wearing, money-mongering devils commandeered my property.<AnimateYield=.45>",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "ok bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Listen, if you promise to inflict pain upon those fiends and reclaim my property, I will grant you a portion of my fortunes.<AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Robert", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Don\'t stop till they drop.<AnimateYield=.45>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2