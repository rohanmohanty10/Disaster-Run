 

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
    ["NPC"] = "Coro",
    ["lvlReq"] = 325,
    ["Talk1"] = {
        ["Text"] = "I see you\'ve learned from <Color=Blue>Rogson<Color=/>...",
        ["go"] = "...",
        ["stop"] = "bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "<Color=Blue>Rogson<Color=/> taught you well, however his teachings are <Color=Red>incomplete<Color=/>. What he taught you was only the first stage of <Color=Blue>observation<Color=/>.",
        ["go"] = "...",
        ["stop"] = "no",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "I can help you unlock the <Color=Blue>2nd stage<Color=/> thru a fun rigorous training, and just like <Color=Blue>Rogson<Color=/> its not free. You\'ll have to pay <Color=Yellow>25,000<Color=/> peli a try.",
        ["go"] = "Ok!!!",
        ["stop"] = "Sorry, I\226\128\153m not ready.",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "Ok lets begin the training now! Remember your goal is to score <Color=Blue>300 or higher<Color=/>, otherwise you fail!<AnimateYield=3> ",
        ["go"] = "Alright!",
        ["stop"] = "Sorry, I\226\128\153m not ready.",
        ["stoptext"] = "ok bye",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 38 ]]
            task.wait(2)
            game.ReplicatedStorage.Events.learnStyle:FireServer("kenV2Train")
        end
    },
    ["masterd"] = {
        ["Text"] = "<Color=Green>Go on, you\'ve learned what i taught you...",
        ["go"] = "Alright!",
        ["stop"] = "Sorry, I\226\128\153m not ready.",
        ["stoptext"] = "ok bye",
        ["endtext"] = true
    },
    ["nomoney"] = {
        ["Text"] = "<Color=Red>bro ya dont got enuh money",
        ["go"] = "Alright!",
        ["stop"] = "Sorry, I\226\128\153m not ready.",
        ["stoptext"] = "ok bye",
        ["endtext"] = true
    },
    ["notlearn"] = {
        ["Text"] = "<Color=Red>Seems like Rogson at skypiea hasnt taught you yet...",
        ["go"] = "Alright!",
        ["stop"] = "Sorry, I\226\128\153m not ready.",
        ["stoptext"] = "ok bye",
        ["endtext"] = true
    }
}
return v2