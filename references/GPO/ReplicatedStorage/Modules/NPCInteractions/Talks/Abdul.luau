 

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
    ["QuestName"] = "Help Abdul",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Abdul",
    ["lvlReq"] = 325
}
local v3 = {
    ["Type"] = "Awaken",
    ["MobName"] = "Pharaoh Akshan",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 2000,
        ["Peli"] = 900
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<AnimateStyle=Rainbow>Our pharaoh has been in his deep slumber after using all of his power to conquer this land...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "I\'ve yearn to see the day of his <AnimateStyle=Rainbow>reawakening<AnimateStyle=/>. A old man in the city told me that theres a <AnimateStyle=Rainbow>hidden cave<AnimateStyle=/> which has the power to <AnimateStyle=Rainbow>reawaken<AnimteStyle=/> our pharaoh.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "He said something about <AnimateStyle=Wiggle><Color=Yellow>artifacts<Color=/><AnimteStyle=/> being needed but i don\'t have much information on that, can you find this cave and try to <AnimateStyle=Rainbow>reawaken<AnimteStyle=/> our pharaoh?",
    ["go"] = "Yes for sure!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Abdul", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Alright have a safe journey",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2