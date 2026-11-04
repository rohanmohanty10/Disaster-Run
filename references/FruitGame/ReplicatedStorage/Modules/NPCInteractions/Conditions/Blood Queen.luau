 

local v1 = {}
local u2 = {
    "Vampire Bite",
    "Blood Dash",
    "Blood Chain",
    "Blood Aura",
    "Blood Dragon"
}
local u3 = require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v4 = game.Players.LocalPlayer
    local _ = v4.Character
    local v5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v4.Name)
    if v5.Customization.Race.Value:match("Vampire") == nil then
        return {
            {
                ["talkname"] = "notRace",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v5.Stats.FightingStyle.Value ~= "Vampire" then
        return nil
    end
    if v5.Skills.Vampire.Value >= #u2 then
        return {
            {
                ["talkname"] = "max",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    local v6 = u3.GetM(u2[v5.Skills.Vampire.Value + 1])
    return v6.statreq and (_G.MeetReq(v6.statreq, true) == false or v5.Stats.Peli.Value < v6.moneyreq) and {
        {
            ["talkname"] = "learn" .. u2[v5.Skills.Vampire.Value + 1],
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
            ["talkname"] = "learn" .. u2[v5.Skills.Vampire.Value + 1],
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