 

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
    ["QuestName"] = "Serve Justice",
    ["QuestDesc"] = "Defeat Axe Hand Morgan",
    ["NPC"] = "Gozen",
    ["lvlReq"] = 29
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Axe Hand Logan",
    ["Ammount"] = 1
}
local v4 = {
    ["EXP"] = 800,
    ["Peli"] = 500,
    ["Items"] = {
        ["Katana"] = 1
    }
}
v3.Rewards = v4
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "This town used to be peacefull until <Color=Red>Logan<Color=/> started abusing his powers...<AnimateYield=.45>",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "If you can defeat and serve justice to Logan<AnimateYield=.45>, i\'ll give you with a hefty reward.<AnimateYield=.45>",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Serve Justice", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Thanks for helping<AnimateYield=.45>, also i suggest you bring your <Color=Green>friends<Color=/> along<AnimateYield=.45>, Logan summons his <Color=Red>chore boys<Color=/> all the time.<AnimateYield=1>",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2