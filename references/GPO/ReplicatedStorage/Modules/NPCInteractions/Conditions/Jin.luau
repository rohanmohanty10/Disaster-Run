 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = {
    "Five Thousand Brick Fist",
    "Water Prison",
    "Shark Barrage",
    "Water Serpent",
    "Water Bomb"
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
    if v5.Customization.Race.Value:match("Fishman") == nil then
        return {
            {
                ["talkname"] = "notRace",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v5.Skills.FishmanKarate.Value >= #u3 and v5.Stats.FightingStyle.Value ~= "FishmanKarate" then
        return {
            {
                ["talkname"] = "swap1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "swap2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
    local v6 = 0
    for v7, v8 in game:GetService("HttpService"):JSONDecode(v5.Inventory.Inventory.Value) do
        if v7 == "Shark Tooth" then
            v6 = v8
        end
    end
    if (v5.Stats.Peli.Value < 30000 or v6 < 75) and v5.Stats.FightingStyle.Value ~= "FishmanKarate" then
        return {
            {
                ["talkname"] = "nomoney",
                ["talknumber"] = 5,
                ["talkend"] = 5
            }
        }
    end
    if v5.Stats.FightingStyle.Value ~= "FishmanKarate" then
        return nil
    end
    if v5.Skills.FishmanKarate.Value >= #u3 then
        return {
            {
                ["talkname"] = "max",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    local v9 = u2.GetM(u3[v5.Skills.FishmanKarate.Value + 1])
    return (v9.statreq and _G.MeetReq(v9.statreq, true) == false or v5.Stats.Peli.Value < v9.moneyreq) and {
        {
            ["talkname"] = "learn" .. u3[v5.Skills.FishmanKarate.Value + 1],
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
            ["talkname"] = "learn" .. u3[v5.Skills.FishmanKarate.Value + 1],
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