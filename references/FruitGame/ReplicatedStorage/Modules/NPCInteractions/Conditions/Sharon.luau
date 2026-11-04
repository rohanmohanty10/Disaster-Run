 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = {
    "Electro Fist",
    "Electro Dash",
    "Electro Luna",
    "Electro Rain",
    "Raiju Punishment"
}
function v1.check(_) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v4 = game.Players.LocalPlayer
    local _ = v4.Character
    if game.ReplicatedStorage:FindFirstChild("Stats" .. v4.Name).Customization.Race.Value:match("Mink") == nil then
        return {
            {
                ["talkname"] = "NotMink",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    else
        local v5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v4.Name)
        local v6 = 0
        for v7, v8 in game:GetService("HttpService"):JSONDecode(v5.Inventory.Inventory.Value) do
            if v7 == "Carrot" then
                v6 = v8
            end
        end
        if v5.Skills.Electro.Value >= #u3 and v5.Stats.FightingStyle.Value ~= "Electro" then
            return {
                {
                    ["talkname"] = "swapElectro1",
                    ["talknumber"] = 1,
                    ["talkend"] = 2
                },
                {
                    ["talkname"] = "swapElectro2",
                    ["talknumber"] = 2,
                    ["talkend"] = 2
                }
            }
        elseif v5.Stats.FightingStyle.Value == "Electro" or v5.Stats.Peli.Value >= 15000 and v6 >= 25 then
            if v5.Stats.FightingStyle.Value == "Electro" then
                if v5.Skills.Electro.Value < #u3 then
                    local v9 = u2.GetM(u3[v5.Skills.Electro.Value + 1])
                    if v9.statreq and _G.MeetReq(v9.statreq, true) == false or v5.Stats.Peli.Value < v9.moneyreq then
                        print("not meat")
                        return {
                            {
                                ["talkname"] = "learn" .. u3[v5.Skills.Electro.Value + 1],
                                ["talknumber"] = 1,
                                ["talkend"] = 2
                            },
                            {
                                ["talkname"] = "dontMeet",
                                ["talknumber"] = 2,
                                ["talkend"] = 2
                            }
                        }
                    else
                        print("learningignigngigng" .. u3[v5.Skills.Electro.Value + 1])
                        return {
                            {
                                ["talkname"] = "learn" .. u3[v5.Skills.Electro.Value + 1],
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
                else
                    return {
                        {
                            ["talkname"] = "max",
                            ["talknumber"] = 1,
                            ["talkend"] = 1
                        }
                    }
                end
            else
                return nil
            end
        else
            return {
                {
                    ["talkname"] = "nomoney",
                    ["talknumber"] = 4,
                    ["talkend"] = 4
                }
            }
        end
    end
end
return v1