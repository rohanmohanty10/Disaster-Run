 

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
    ["QuestName"] = "Help jeff",
    ["QuestDesc"] = "beat enel",
    ["lvlReq"] = 155,
    ["NPC"] = "Jeff"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MobName"] = "Thunder God",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["EXP"] = 2000,
        ["Peli"] = 900
    }
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "If u go ahead u can see the golden city underground...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "The golden city and the rest of the sky lands are controled by the Thunder God, if u can defeat him ill reward you!!",
    ["go"] = "yes i go beat the god",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 31 ]]
        questHandle("Help jeff", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "ok good luck",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2