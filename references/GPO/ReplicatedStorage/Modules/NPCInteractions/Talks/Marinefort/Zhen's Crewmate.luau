 

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
    ["QuestName"] = "Help Zhen\'s Crewmate",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Zhen\'s Crewmate",
    ["lvlReq"] = 265
}
local v3 = {
    ["Type"] = "Awaken",
    ["MobName"] = "Captain Zhen",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 1200,
        ["Peli"] = 400
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Shhhhhh, ive been hiding here for a long time to escape detection of the marines...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Ive tried to enter the fort and get the fire essence form Admiral Zeke, but i cant breach the guards. I need the fire essence to awaken <Color=Red>Captain Zhen<Color=/> so that he can finish what he started!",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "But im too weak right now, our entire crew has been wiped out and im powerless. Can i ask you to get the <Color=Red>Fire Essence<Color=/> and awaken our captain by defeating <Color=Red>Admiral Zeke<Color=/>?",
    ["go"] = "Yes",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 37 ]]
        questHandle("Help Zhen\'s Crewmate", "takequest")
    end
}
v2.Talk4 = {
    ["Text"] = "alright keep your GUARD UP!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2