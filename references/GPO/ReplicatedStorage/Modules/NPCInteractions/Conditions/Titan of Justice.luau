 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
local function u8(p2, p3) --[[ Line: 5 ]]
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
function v1.check(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v9 = game.Players.LocalPlayer
    local _ = v9.Character
    game.ReplicatedStorage:FindFirstChild("Stats" .. v9.Name)
    if _G.arena == true then
        local v10 = v9:GetAttribute("playersEliminated")
        return (v10 == nil and 0 or v10) < 3 and {
            {
                ["talkname"] = "NotEnoughGrips",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        } or {
            {
                ["talkname"] = "BRTalk1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "BRTalk2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
    local v11 = game.ReplicatedStorage:FindFirstChild("Stats" .. v9.Name)
    if v11.Stats.FightingStyle.Value == "Iron Fist" and v11.Skills.GarpFS.Value < 4 then
        game.ReplicatedStorage.Events.Quest:InvokeServer("CorrectIronFistQuest")
    end
    if v11.Skills.GarpFS.Value >= 4 or v11.Skills.GarpFS.Value == 3 and _G.HasItem(v9, "Titan of Justice\'s Cape") == true or u8(v9, "Pass the Trials of the Titan") == true then
        return {
            {
                ["talkname"] = "learnIronFist1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "learnIronFist2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
end
return v1