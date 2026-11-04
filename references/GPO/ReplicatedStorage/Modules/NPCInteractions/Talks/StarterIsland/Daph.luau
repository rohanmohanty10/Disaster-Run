 

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
    ["QuestName"] = "Help Daph",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Daph",
    ["lvlReq"] = 1
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Bandit",
    ["Ammount"] = 5,
    ["Rewards"] = {
        ["EXP"] = 60,
        ["Peli"] = 50
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Hey, I\226\128\153m <Color=255,201,201>Daph<Color=/>, and welcome to my island!",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "You\226\128\153re a <Color=Green>new<Color=/> traveler right? Well, I\226\128\153ve been looking for someone <Color=Red>strong<Color=/>. Those bandits up this hill have been <Color=Red>wreaking havoc<Color=/> all over the place! Please, you have to <Color=Red>stop<Color=/> them!",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "Aw, that\226\128\153s too bad. I had hoped that you were stronger...",
    ["endtext"] = false,
    ["result"] = function(p4) --[[ Name: result, Line 30 ]]
        p4.Humanoid:LoadAnimation(p4.Info.FinishAnim):Play()
        questHandle("Help Daph", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "<AnimateStyle=Wiggle><Color=Green>Thank you so much<Color=/><AnimateYield=.25><AnimateStyle=/> kind traveler! I definitely won\226\128\153t forget this favor!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2