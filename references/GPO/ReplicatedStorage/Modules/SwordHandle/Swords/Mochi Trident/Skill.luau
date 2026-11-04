 

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
    game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    local u7 = require(u2.Backpack:WaitForChild("SkillCallbacks")):GetSkillCallback(u6)
    u4 = u3.InputBegan:Connect(function(p8, p9) --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
            [3] = u7
        --]]
        if u6.Parent == u5 and (_G.canuse ~= false and p9 ~= true) then
            if p8.KeyCode == Enum.KeyCode.E then
                u7:MochiTridentDrill()
            elseif p8.KeyCode == Enum.KeyCode.R then
                u7:MochiTridentThrow()
            end
        else
            return
        end
    end)
    return u7
end
return v1