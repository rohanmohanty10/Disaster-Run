 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Modules.Skills)
function v1.setup(_, u5, u6) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u3
    --]]
    if u4 then
        u4:Disconnect()
    end
    local u7 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    local u8 = require(u2.Backpack:WaitForChild("SkillCallbacks")):GetSkillCallback(u6)
    u4 = u3.InputBegan:Connect(function(p9, p10) --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
            [3] = u7
            [4] = u8
        --]]
        if u6.Parent == u5 and (_G.canuse ~= false and p10 ~= true) then
            if u7.Stats.FightingStyle.Value == "1SS" then
                if p9.KeyCode == Enum.KeyCode.E then
                    u8["36CaliberPhoenix"](u8)
                    return
                elseif p9.KeyCode == Enum.KeyCode.R then
                    u8:RapidSlashes()
                    return
                elseif p9.KeyCode == Enum.KeyCode.Z then
                    u8:RagingSerpent()
                    return
                elseif p9.KeyCode == Enum.KeyCode.X then
                    u8:ShishiSonson()
                elseif p9.KeyCode == Enum.KeyCode.C then
                    u8:DragonBlaze()
                end
            else
                return
            end
        else
            return
        end
    end)
    return u8
end
return v1