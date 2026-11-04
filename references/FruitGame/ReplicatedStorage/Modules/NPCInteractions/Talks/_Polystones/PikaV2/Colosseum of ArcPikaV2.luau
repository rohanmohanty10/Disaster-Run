 

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
    ["QuestName"] = "Colosseum of ArcPikaV2",
    ["QuestDesc"] = "beat guard",
    ["HiddenName"] = true,
    ["lvlReq"] = 325,
    ["Save"] = true,
    ["noNPC"] = true,
    ["NPC"] = "Anty",
    ["MasteryName"] = "Pika-Pika"
}
local v6 = {
    ["Type"] = "Trial of Radiant Mastery",
    ["MobName"] = "Pika DMG ON BOSSES",
    ["Ammount"] = 100,
    ["Rewards"] = {
        ["PikaV2"] = 1
    },
    ["hideRewards"] = true,
    ["customProgress"] = function(p3) --[[ Name: customProgress, Line 22 ]]
        local v4, v5 = _G.getMasteryInfo(p3, "Pika-Pika")
        return v4, v5
    end,
    ["customFinish"] = require(game.ReplicatedStorage.Modules.Shared.MiscModules.PikaV2AwakenFunction)
}
v2.QuestInfo = v6
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
    ["result"] = function(_) --[[ Name: result, Line 43 ]]
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