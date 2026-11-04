 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = {
    "B-Shot",
    "Coiller",
    "Sky Walk",
    "Concasser",
    "Party Table Kick Course",
    "Anti-Manner Kick Course"
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
    if v5.Stats.Peli.Value < 9000 and v5.Stats.FightingStyle.Value ~= "BlackLeg" then
        return {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 3,
                ["talkend"] = 3
            }
        }
    end
    if v5.Stats.FightingStyle.Value ~= "BlackLeg" then
        return nil
    end
    if v5.Skills.BlackLeg.Value >= #u3 then
        return {
            {
                ["talkname"] = "max",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    local v6 = u2.GetM(u3[v5.Skills.BlackLeg.Value + 1])
    return (v6.statreq and _G.MeetReq(v6.statreq, true) == false or v5.Stats.Peli.Value < v6.moneyreq) and {
        {
            ["talkname"] = "learn" .. u3[v5.Skills.BlackLeg.Value + 1],
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
            ["talkname"] = "learn" .. u3[v5.Skills.BlackLeg.Value + 1],
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