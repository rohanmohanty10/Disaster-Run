 

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
    ["NPC"] = "V Kirishima, The Shadow of Halloween",
    ["Talk1"] = {
        ["Text"] = "Another festive soul!, What can I do for you?",
        ["go"] = "Can you teach me the Dullahan fighting style?",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "Hmm, I mean... I guess I could teach you... for a small fee of.. let\'s say... FREE?",
        ["go"] = "Ok",
        ["stop"] = "No",
        ["stoptext"] = "ok bye",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "Talk to me aigan to learn the skills!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 28 ]]
            game.ReplicatedStorage.Events.learnStyle:FireServer("Dullahan")
        end
    },
    ["notRace"] = {
        ["Text"] = "<Color=Red>You are not one of my kind...",
        ["go"] = "My bad",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["dontMeet"] = {
        ["Text"] = "You dont have enough <Color=Blue>Wandering Souls<Color=/> or you dont have enough fighting style mastery...",
        ["go"] = "My bad",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    },
    ["max"] = {
        ["Text"] = "<Color=Blue>Go and show them true fear!",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "You already learned everthing I have to offer...",
        ["endtext"] = true
    },
    ["learnWill O\' Wisp"] = {
        ["Text"] = "<Color=Blue>Will O\' Wisp<Color=/> is a Dullahan technique that creates spirit orbs that hunt down your enemies and will cost you <Color=Blue>10 Wandering Souls<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnFear Inducement"] = {
        ["Text"] = "<Color=Blue>Fear Inducement<Color=/> is a Dullahan technique that involves grabbing onto an opponent and haunting them and will cost you <Color=Blue>20 Wandering Souls<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnHead Throw"] = {
        ["Text"] = "<Color=Blue>Head Throw<Color=/> is a Dullahan technique that lets you throw your head that explodes on contact and will cost you <Color=Blue>30 Wandering Souls<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnResurrection"] = {
        ["Text"] = "<Color=Blue>Ressurection<Color=/> is a Dullahan technique that resurrects souls to fight for you and will cost you <Color=Blue>40 Wandering Souls<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnOnslaught of Shadows"] = {
        ["Text"] = "<Color=Blue>Onslaught of Shadows<Color=/> is the ultimate Dullahan technique that lets you charge forward and fear enemies in your path and will cost you <Color=Blue>50 Wandering Souls<Color=/>.",
        ["go"] = "Teach me.",
        ["stop"] = "...",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = false
    },
    ["learnedSkill"] = {
        ["Text"] = "Go on little one...",
        ["go"] = "Yes",
        ["stop"] = "No",
        ["stoptext"] = "Ok come back when your ready...",
        ["endtext"] = true,
        ["excu"] = function() --[[ Name: excu, Line 99 ]]
            game.ReplicatedStorage.Events.learnSkill:FireServer("Dullahan")
        end
    }
}
return v2