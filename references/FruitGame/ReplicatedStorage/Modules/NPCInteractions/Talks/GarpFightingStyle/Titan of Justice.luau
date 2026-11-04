 

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
    ["QuestName"] = "Pass the Trials of the Titan",
    ["QuestDesc"] = "kill",
    ["lvlReq"] = 600,
    ["NPC"] = "Titan of Justice",
    ["MiscQuest"] = true,
    ["Save"] = true,
    ["bypassComplete"] = true
}
local v4 = {
    ["Type"] = "Defeat",
    ["hideRewards"] = true,
    ["customFinish"] = function(p3) --[[ Name: customFinish, Line 18 ]]
        game.ReplicatedStorage.Events.note:FireClient(p3, "<Color=Orange>Return and talk with the Titan of Justice!")
    end
}
local v5 = {
    {
        ["Type"] = "Defeat",
        ["MiscType"] = "The Strongest Man in the World",
        ["MobName"] = "Captain Zhen",
        ["Ammount"] = 1,
        ["hideRewards"] = true
    },
    {
        ["Type"] = "Defeat",
        ["MiscType"] = "Battle of Supreme Kings",
        ["MobName"] = "Roger",
        ["Ammount"] = 1,
        ["hideRewards"] = true
    },
    {
        ["Type"] = "Defeat",
        ["MiscType"] = "Beast Slayer",
        ["MobName"] = "Megalodon",
        ["Ammount"] = 2,
        ["hideRewards"] = true
    }
}
local v6 = {
    ["Type"] = "Defeat",
    ["MiscType"] = "Family Reunion",
    ["MobName"] = "Lucy",
    ["Ammount"] = 1
}
local v7 = {
    ["GarpFS"] = 4,
    ["Items"] = {
        ["Titan of Justice\'s Cape"] = 1,
        ["Titan of Justice\'s Outfit"] = 1
    }
}
v6.Rewards = v7
v6.hideRewards = true
v5[4] = v6
v4.MultiQuest = v5
v2.QuestInfo = v4
v2.Talk1 = {
    ["Text"] = "<Color=Red>I am the Titan of Justice<Color=/>. Defender of the seas. Many seek my power, but few endure the trials. Do you think you have what it takes?",
    ["go"] = "Tell me more.",
    ["stop"] = "I\226\128\153m not ready.",
    ["stoptext"] = "<Color=Red>Come back when you\'re stronger.<Color=/>",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "To learn my style, you must pass <Color=Red>four trials<Color=/>. Each one will test you. Only those who succeed may wield the Iron Fist.",
    ["go"] = "I\226\128\153m ready!",
    ["stop"] = "I\226\128\153m not ready yet.",
    ["stoptext"] = "<Color=Red>I expected more from you...<Color=/>",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 73 ]]
        questHandle("Pass the Trials of the Titan", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "The <Color=Red>first trial<Color=/> awaits. Survive, and prove your strength. Come back to me once your finished.",
    ["go"] = "I\226\128\153m ready.",
    ["stop"] = "Wait, I need more time.",
    ["stoptext"] = "<Color=Red>Don\226\128\153t delay, strength waits for no one.<Color=/>",
    ["endtext"] = true
}
v2.learnIronFist1 = {
    ["Text"] = "Would you like to switch to <Color=Blue>Iron Fist<Color=/>?",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = false
}
v2.learnIronFist2 = {
    ["Text"] = "There you go!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 99 ]]
        game.ReplicatedStorage.Events.learnStyle:FireServer("Iron Fist")
    end
}
return v2