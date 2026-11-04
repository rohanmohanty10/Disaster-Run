 

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
    ["QuestName"] = "Help Samira",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Samira",
    ["lvlReq"] = 375
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Pharaoh Akshan",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 4000,
        ["Peli"] = 2000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "I\'ve heard some rumors of people attempting to reawaken the pharaoh. Altough many citizens want him back, us marines <AnimateStyle=Wiggle><Color=Red>CANNOT<Color=/><AnimateStyle=/> tolerate him.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "We fought the pharaoh many times in the past but he prevailed agaisnt us. If he does get reawakened somehow can you subdue him?",
    ["go"] = "Yes!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("Help Samira", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Alright be careful, the pharaoh has the <AnimateStyle=Wiggle><Color=Orange>Suna-Suna<Color=/><AnimateStyle=/> devil fruit which allows him to use the powers of sand!",
    ["go"] = "Yes for sure!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = true
}
return v2