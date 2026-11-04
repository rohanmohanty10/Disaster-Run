 

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
    ["QuestName"] = "Pass the Trials of Zorana",
    ["QuestDesc"] = "kill",
    ["lvlReq"] = 600,
    ["NPC"] = "Zorana",
    ["MiscQuest"] = true,
    ["Save"] = true,
    ["bypassComplete"] = true
}
local v4 = {
    ["Type"] = "Defeat",
    ["hideRewards"] = true,
    ["customFinish"] = function(p3) --[[ Name: customFinish, Line 17 ]]
        game.ReplicatedStorage.Events.note:FireClient(p3, "<Color=Orange>Return and talk to Zorana!")
    end
}
local v5 = {
    {
        ["Type"] = "Defeat",
        ["MiscType"] = "2SS Execution",
        ["MobName"] = "Rashomon Execute Players",
        ["Ammount"] = script:GetAttribute("excuCount"),
        ["hideRewards"] = true
    },
    {
        ["Type"] = "Defeat",
        ["MiscType"] = "The Strongest Swordsman in the World",
        ["MobName"] = "Hawk Eye",
        ["Ammount"] = 1,
        ["hideRewards"] = true
    },
    {
        ["Type"] = "Defeat",
        ["MiscType"] = "2SS Perfection",
        ["MobName"] = "Successfully Tower Climb",
        ["Ammount"] = script:GetAttribute("towerCount"),
        ["hideRewards"] = true
    }
}
local v6 = {
    ["Type"] = "Defeat",
    ["MiscType"] = "Duel of the Undying Samurai",
    ["MobName"] = "Ryuma",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["3SS"] = 4,
        ["customFinish"] = function(_) --[[ Name: customFinish, Line 52 ]]
            warn("QUEST FINISHED COIMPLTIED CUSTOM FINISH HERE!!!!")
        end
    },
    ["hideRewards"] = true
}
v5[4] = v6
v4.MultiQuest = v5
v2.QuestInfo = v4
v2.Talk1 = {
    ["Text"] = "<Color=Red>I am Zorana, Mistress of the Three Blades<Color=/>. I have honed my craft through countless duels. Many covet this power, yet few endure its trials. Will you dare to seek true strength?",
    ["go"] = "Tell me more.",
    ["stop"] = "I\226\128\153m not ready.",
    ["stoptext"] = "<Color=Red>Return when your resolve is sharpened.<Color=/>",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "To wield my <Color=Red>Three Sword Style<Color=/>, you must overcome <Color=Red>four trials<Color=/>. Each will test your body, mind, and soul. Only those who conquer them may claim my technique.",
    ["go"] = "I\226\128\153m ready!",
    ["stop"] = "I\226\128\153m not ready yet.",
    ["stoptext"] = "<Color=Red>Do not waste my time.<Color=/>",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 76 ]]
        questHandle("Pass the Trials of Zorana", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "The <Color=Red>first trial<Color=/> stands before you. Prove your strength and precision. When the deed is done, return to me, and we shall see if you are worthy.",
    ["go"] = "I\226\128\153m ready.",
    ["stop"] = "Wait, I need more time.",
    ["stoptext"] = "<Color=Red>Hesitate, and you will never grasp true power.<Color=/>",
    ["endtext"] = true
}
v2.notWorth = {
    ["Text"] = "<Color=Red>You are not worthy of my teachings! You need to master 2SS and be using it!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "Ok come back when your ready...",
    ["endtext"] = true
}
v2.learn3SS1 = {
    ["Text"] = "Would you like to switch to <Color=Green>3SS<Color=/>?",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = false
}
v2.learn3SS2 = {
    ["Text"] = "There you go, if you havent chosen items from me, talk to me again.",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 111 ]]
        game.ReplicatedStorage.Events.learnStyle:FireServer("3SS")
    end
}
v2.max = {
    ["Text"] = "You\'ve mastered my ways...",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "Ok come back when your ready...",
    ["endtext"] = true
}
return v2