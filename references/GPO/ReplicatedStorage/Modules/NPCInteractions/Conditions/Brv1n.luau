 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
local u2 = {
    ["Pika-Pika"] = true,
    ["Mochi-Mochi"] = true
}
function v1.check(_) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v3 = game.Players.LocalPlayer
    local _ = v3.Character
    if u2[game.ReplicatedStorage:FindFirstChild("Stats" .. v3.Name).Stats.DF.Value] == nil then
        return {
            {
                ["talkname"] = "NotValidFruit",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if _G.arena ~= true then
        return nil
    end
    local v4 = v3:GetAttribute("playersEliminated")
    return (v4 == nil and 0 or v4) < 3 and {
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
return v1