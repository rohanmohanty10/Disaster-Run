 

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
    ["QuestName"] = "hunt egirl",
    ["NPC"] = "Santa (HURT)",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["lvlReq"] = 350
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Kramprus",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 4500,
        ["Peli"] = 1000
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "<Color=Red>The kramprus attacked us while we were traveling to the north pole, he ate all the gifts that i had!",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["excu"] = function() --[[ Name: excu, Line 23 ]]
        script["h" .. math.random(1, 3)]:Play()
    end
}
v2.Talk2 = {
    ["Text"] = "<Color=Red>My sleigh is badly damaged, and i am hurt as well...",
    ["go"] = "...",
    ["stop"] = "no im going hunting!",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["excu"] = function() --[[ Name: excu, Line 34 ]]
        script["h" .. math.random(1, 3)]:Play()
    end
}
v2.Talk3 = {
    ["Text"] = "<Color=Red>Looks like the only way for us to escape is to defeat the <Color=Blue>Kramprus<Color=/>, are you willing to do so?",
    ["go"] = "YES I GO!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 46 ]]
        questHandle("hunt egirl", "takequest")
    end,
    ["excu"] = function() --[[ Name: excu, Line 49 ]]
        script["h" .. math.random(1, 3)]:Play()
    end
}
v2.Talk4 = {
    ["Text"] = "<Color=Red>Alright be careful, the <Color=Blue>Kramprus<Color=Red> has ice powers!",
    ["go"] = "YES I GO!",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 60 ]]
        script.Cheese:Play()
    end
}
return v2