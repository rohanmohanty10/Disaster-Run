 

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
    ["QuestName"] = "Coffee Quest",
    ["QuestDesc"] = "Defeat Lucid and his lads",
    ["NPC"] = "Disgruntled Civilian",
    ["lvlReq"] = 15
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Lucid",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 200,
        ["Peli"] = 145
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "Dude i heard that the coffe at bean cafe is the best but its too far form this city, i cant walk that much!",
    ["go"] = "...",
    ["stop"] = "Bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Do you purphase have any extra coffee for me?",
    ["go"] = "Yes",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 30 ]]
        questHandle("", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "Thanks for the coffee now i can slurp away!!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
v2.dontHave = {
    ["Text"] = "<Color=Red>Is this a joke??? Im not playing games!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
return v2