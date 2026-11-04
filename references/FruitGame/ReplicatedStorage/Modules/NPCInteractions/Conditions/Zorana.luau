 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
local function u8(p2, p3) --[[ Line: 4 ]]
    local v4 = game.ReplicatedStorage:FindFirstChild("Stats" .. p2.Name)
    local v5 = game:GetService("HttpService"):JSONDecode(v4.Quest.CompletedQuests.Value)
    local v6 = false
    for v7 = 1, #v5 do
        if v5[v7] == p3 then
            return true
        end
    end
    return v6
end
function v1.check(_) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v9 = game.Players.LocalPlayer
    local _ = v9.Character
    game.ReplicatedStorage:FindFirstChild("Stats" .. v9.Name)
    local v10 = game.ReplicatedStorage:FindFirstChild("Stats" .. v9.Name)
    if v10.Skills["3SS"].Value >= 4 or u8(v9, "Pass the Trials of Zorana") == true then
        if v10.Inventory.Claimed3SSReward.Value == false then
            game.ReplicatedStorage.Events.Quest:InvokeServer("3SSQuestReward")
        end
        return v10.Stats.FightingStyle.Value == "3SS" and {
            {
                ["talkname"] = "max",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or {
            {
                ["talkname"] = "learn3SS1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "learn3SS2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
    if v10.Skills["2SS"].Value < 5 or v10.Stats.FightingStyle.Value ~= "2SS" then
        return {
            {
                ["talkname"] = "notWorth",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
end
return v1