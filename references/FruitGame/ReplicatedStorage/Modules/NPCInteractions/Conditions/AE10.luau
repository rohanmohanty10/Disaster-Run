 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = {
    "Machine Gun Blows",
    "Laser Pulsar",
    "Cyborg Flight",
    "Self Repair",
    "Missle Shower",
    "Obliteration Rush"
}
function v1.check(_) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v4 = game.Players.LocalPlayer
    local _ = v4.Character
    local v5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v4.Name)
    if v5.Customization.Race.Value:match("Cyborg") == nil then
        return {
            {
                ["talkname"] = "notCyborg",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v5.Stats.FightingStyle.Value ~= "Cyborg" then
        return nil
    end
    if v5.Skills.Cyborg.Value >= #u3 then
        return {
            {
                ["talkname"] = "upgrade1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "upgrade2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
    local v6 = u2.GetM(u3[v5.Skills.Cyborg.Value + 1])
    return v6.statreq and (_G.MeetReq(v6.statreq, true) == false or _G.CheckItemAmmount(v4, "Cyborg Gear") < v6.moneyreq) and {
        {
            ["talkname"] = "learn" .. u3[v5.Skills.Cyborg.Value + 1],
            ["talknumber"] = 1,
            ["talkend"] = 2
        },
        {
            ["talkname"] = "dontMeet",
            ["talknumber"] = 2,
            ["talkend"] = 2
        }
    } or {
        {
            ["talkname"] = "learn" .. u3[v5.Skills.Cyborg.Value + 1],
            ["talknumber"] = 1,
            ["talkend"] = 2
        },
        {
            ["talkname"] = "learnedSkill",
            ["talknumber"] = 2,
            ["talkend"] = 2
        }
    }
end
return v1