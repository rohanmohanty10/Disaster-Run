 

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
    ["QuestName"] = script.Name,
    ["QuestDesc"] = "beat guard",
    ["HiddenName"] = true,
    ["lvlReq"] = 325,
    ["Save"] = true,
    ["noNPC"] = true,
    ["NPC"] = "Anty"
}
local v3 = {
    ["Type"] = "Defeat",
    ["MiscType"] = "Trial of the Starlight Rapier",
    ["MobName"] = "Hawk Eye",
    ["Ammount"] = 1,
    ["Rewards"] = {
        ["PikaV2"] = 1
    },
    ["hideRewards"] = true,
    ["customFinish"] = require(game.ReplicatedStorage.Modules.Shared.MiscModules.PikaV2AwakenFunction)
}
v2.QuestInfo = v3
v2.Talk1 = {
    ["Text"] = "i hate this place...",
    ["go"] = "...",
    ["stop"] = "bye",
    ["stoptext"] = "Bye",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "civlian go brrrrrrrrrrrrrrrr???",
    ["go"] = "yes i go",
    ["stop"] = "no",
    ["stoptext"] = "ok bye",
    ["endtext"] = false,
    ["result"] = function(_) --[[ Name: result, Line 38 ]]
        questHandle("Help Anty", "takequest")
    end
}
v2.Talk3 = {
    ["Text"] = "BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR",
    ["go"] = "Alright!",
    ["stop"] = "Sorry, I\226\128\153m not ready.",
    ["stoptext"] = "ok bye",
    ["endtext"] = true
}
return v2