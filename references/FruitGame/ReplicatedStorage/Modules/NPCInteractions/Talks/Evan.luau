 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 5,
    ["NPC"] = "Evan",
    ["Talk1"] = {
        ["Text"] = "Yung one, you\'ve found me...",
        ["go"] = "???",
        ["stop"] = "Bye",
        ["stoptext"] = "Bye",
        ["endtext"] = false
    },
    ["Talk2"] = {
        ["Text"] = "I\'m guessing you\'re wondering about your next <Color=Purple>adventure<Color=/>?",
        ["go"] = "...",
        ["stop"] = "no",
        ["stoptext"] = "...",
        ["endtext"] = false
    },
    ["Talk3"] = {
        ["Text"] = "I have a few crewmates that have passed the locked gates and transversed to the <Color=Blue>Second Sea<Color=/>.",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk4"] = {
        ["Text"] = "My memory isn\'t the best but I think the gates are in the <Color=Orange>direction<Color=/> that I\'m facing...<AnimateYield=1>",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = false
    },
    ["Talk5"] = {
        ["Text"] = "If my memory serves me correctly then you will encounter a monkey named <Color=Red>PUFF<Color=/>. This PUFF is a bad jungler so dont worry too much<AnimateYield=3>, good luck!",
        ["go"] = "...",
        ["stop"] = "No",
        ["stoptext"] = "...........................",
        ["endtext"] = true
    }
}
return v2