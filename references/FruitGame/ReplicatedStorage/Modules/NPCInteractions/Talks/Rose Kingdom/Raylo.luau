 

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
    ["QuestName"] = "Gear2",
    ["QuestDesc"] = "defeat some bandits for raph",
    ["NPC"] = "Raylo",
    ["lvlReq"] = 450,
    ["MiscQuest"] = true
}
local v3 = {
    ["Type"] = "Awaken",
    ["MobName"] = "Pharaoh Akshan",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 2000,
        ["Peli"] = 900
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Seems like you\'ve learned something from the Poneglyphs...",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "The Poneglyph are a set of stones that are scattered around the seas, going thru their trials unlocks something within you.",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "I\'ll teach you the final things you need to know for the next stage of Gomu, <Color=Pink>GEAR 2<Color=/>!",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk4 = {
    ["Text"] = "Do note that this power requires you to build up the <Color=Orange>mode bar<Color=/> before you can use it.",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true,
    ["excu"] = function(_) --[[ Name: excu, Line 46 ]]
        questHandle("Gear2", "takequest")
    end
}
v2.noTalk = {
    ["Text"] = "<Color=Red>I have notthing to say to you.",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2