 

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
    ["QuestName"] = "Help Captain Malik",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Captain Malik",
    ["lvlReq"] = 325
}
local v3 = {
    ["Type"] = "Rescue",
    ["MobName"] = "Infamous Pirate",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 700,
        ["Peli"] = 1000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<AnimateStyle=Rainbow>A pirate is about to be executed... The marines hold executions here every 15 minutes, taking down infamous names one by one...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "It\'s a grim spectacle... This time, they\226\128\153ve captured someone well-known. You can stop this madness and free them before it\226\128\153s too late.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "The execution will take place at <AnimateStyle=Rainbow><Color=Red>Logue Town\'s execution platform<Color=/><AnimateStyle=/>. The marines are heavily guarding the area. Can you free the pirate before they\226\128\153re executed?",
    ["go"] = "Yes, I\'ll help!",
    ["stop"] = "Sorry, I can\'t.",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Captain Malik", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "Thank you, brave one. Head to the execution platform in Logue Town. The clock is ticking.",
    ["go"] = "I\'ll go now!",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2