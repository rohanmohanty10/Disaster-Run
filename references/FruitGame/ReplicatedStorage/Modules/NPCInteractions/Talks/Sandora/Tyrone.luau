 

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
    ["QuestName"] = "Take down Lucid",
    ["QuestDesc"] = "Defeat Lucid and his lads",
    ["NPC"] = "Tyrone",
    ["lvlReq"] = 15
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Lucid",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 200,
        ["Peli"] = 145
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "This island may seen normal and <Color=Green>peaceful <Color=/>form the outside...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "But behind me is where <Color=Red>Lucid<Color=/><AnimateYield=.45>, the ace bandit resides.<AnimateYield=.45> Lucid has been casuing this island alot of trouble, can you go defeat him for us?",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Take down Lucid", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Thank you for helping<AnimateYield=.45>, let me give you one tip<AnimateYield=.45>, defeating <Color=Red>Lucid<Color=/> is impossible with out the help of your friends!<AnimateYield=.45>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2