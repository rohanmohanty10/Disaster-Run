 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "Demon Step Transformation",
    "Demon Spectrum",
    "Demon Flash",
    "Demon Blitz",
    "Demon Axe Drop",
    "Demonic Sky Driller"
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
    if v5.Stats.FightingStyle.Value ~= "BlackLeg" or v5.Stats.FightingStyle.Value == "BlackLeg" and v5.Skills.BlackLeg.Value < 6 then
        return {
            {
                ["talkname"] = "notWorth",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if (v5.Stats.Peli.Value < 50000 or (v5.Stats.FightingStyle.Value ~= "BlackLeg" or v5.Stats.FightingStyleMastery.Value < 125)) and v5.Skills.BlackLeg.Value < 7 then
        return {
            {
                ["talkname"] = "notWorth",
                ["talknumber"] = 5,
                ["talkend"] = 5
            }
        }
    end
    if _G.HasItem(v4, "Scorched Heart") == false and v5.Skills.BlackLeg.Value < 7 then
        return {
            {
                ["talkname"] = "notBurn",
                ["talknumber"] = 5,
                ["talkend"] = 5
            }
        }
    end
    if v5.Stats.FightingStyle.Value ~= "BlackLeg" or v5.Skills.BlackLeg.Value < 7 then
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