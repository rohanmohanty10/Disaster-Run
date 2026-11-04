 

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
    ["NPC"] = "RVK",
    ["QuestName"] = "Deliver to Snaytona",
    ["QuestDesc"] = "Deliver flag",
    ["Save"] = true
}
local v3 = {
    ["Type"] = "Deliver",
    ["MobName"] = "Rainbow Flag",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 1000,
        ["Peli"] = 500
    },
    ["EndNPC"] = "Snaytona"
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Welcome to the second sea, this is the first island...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "The desert kingdom is right ahead, can you go deliver this flag to my friend, Snaytona at the desert kingdom??",
    ["go"] = "yes!!",
    ["stop"] = "no im busy",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["excu"] = function() --[[ Name: excu, Line 32 ]]
        script["Dog Panting"]:Play()
    end,
    ["result"] = function(_) --[[ Name: result, Line 35 ]]
        print("qyuest going")
        questHandle("Deliver to Snaytona", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "bye bestie",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2