 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
local u5 = {
    ["spin"] = false,
    ["sweep"] = false,
    ["counter"] = false,
    ["trans"] = false
}
require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Modules.Skills)
local u6 = nil
local u7 = nil
function v1.setup(_, u8, u9, _) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
        [3] = u5
        [4] = u6
        [5] = u2
        [6] = u3
    --]]
    if u4 then
        u4:Disconnect()
    end
    if u7 ~= u8 then
        for v10, _ in u5 do
            u5[v10] = false
        end
        u6 = nil
    end
    u7 = u8
    game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    local u11 = require(u2.Backpack:WaitForChild("SkillCallbacks")):GetSkillCallback(u9)
    u4 = u3.InputBegan:Connect(function(p12, p13) --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u8
            [3] = u11
        --]]
        if u9.Parent == u8 and (_G.canuse ~= false and p13 ~= true) then
            if p12.KeyCode == Enum.KeyCode.E then
                u11:RapidThrust()
                return
            elseif p12.KeyCode == Enum.KeyCode.R then
                u11:GoldenSweep()
                return
            elseif p12.KeyCode == Enum.KeyCode.Z then
                u11:PoleCounter()
            elseif p12.KeyCode == Enum.KeyCode.X then
                u11:GoldenStaffTransform()
            end
        else
            return
        end
    end)
    return weaponCallbacks
end
return v1