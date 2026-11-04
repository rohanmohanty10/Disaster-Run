 

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
    ["NPC"] = "Tatter",
    ["NotRokushiki"] = {
        ["Text"] = "Seems like your not using <Color=Blue>Rokushiki<Color=/>",
        ["go"] = "Your right...",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["NotMax"] = {
        ["Text"] = "You havent fully learned <Color=Blue>Rokushiki<Color=/>...<AnimateYield=.45>",
        ["go"] = "Nice to meet you!",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["Talk1"] = {
        ["Text"] = "Seems like you\'ve mastered <Color=Blue>Rokushiki<Color=/>...<AnimateYield=.45>",
        ["go"] = "Yes i have...",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Rokushiki is just the tip of the ice berg \240\159\164\147! I can help you uncover the rest but not for free!<AnimateYield=.45>",
        ["go"] = "...",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "I\'ve always looked up to the <Color=Green>Soul King<Color=/> and his <Color=Green>Green Electric Guitar<Color=/>. If i can get my hands on one ill glady teach you what your missing! The art of <Color=Blue>Kamishiki<Color=/>!",
        ["go"] = "Sure i can help!",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "Ok a deals a deal! Bring me the <Color=Green>Soul King\'s Guitar<Color=/>! Thanks in advance!",
        ["go"] = "YES",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true
    },
    ["GiveGuitar1"] = {
        ["Text"] = "Wow you really did it! Are you sure you want to give the <Color=Green>Soul King\'s Guitar<Color=/> to me?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["GiveGuitar2"] = {
        ["Text"] = "Thanks for the Guitar, time to <Color=Green>ROCK AND ROLL!!<Color=/>",
        ["go"] = "Yes",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 67 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Kamishiki")
        end
    },
    ["AlreadyGave"] = {
        ["Text"] = "Seems like you\'ve finally reached your true potential!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["learnRokuV21"] = {
        ["Text"] = "Would you like to switch to <Color=Blue>Kamishiki<Color=/>?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["learnRokuV22"] = {
        ["Text"] = "Ive passed on my teachings to you!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 92 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Kamishiki")
        end
    },
    ["BRTalk1"] = {
        ["Text"] = "Seems like your strong enough, do you want to learn Kamishiki?",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["BRTalk2"] = {
        ["Text"] = "I\'ve taught you <Color=Blue>Kamishiki<Color=/>, you better win this!",
        ["go"] = "I can go get you some!",
        ["stop"] = "Bye",
        ["stoptext"] = "...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 110 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Kamishiki")
        end
    },
    ["NotEnoughGrips"] = {
        ["Text"] = "<Color=Red>Your not strong enough, eliminate 3 people.",
        ["go"] = "Yes",
        ["stop"] = "...",
        ["stoptext"] = "...",
        ["endtext"] = true
    }
}
return v2