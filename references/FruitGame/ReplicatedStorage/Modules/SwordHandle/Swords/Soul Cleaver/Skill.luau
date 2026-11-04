 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
local u5 = {
    ["slash"] = false,
    ["flash"] = false,
    ["overflow"] = false,
    ["divine"] = false
}
require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Modules.Skills)
local u6 = nil
function v1.setup(_, u7, u8) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
        [3] = u5
        [4] = u2
        [5] = u3
    --]]
    if u4 then
        u4:Disconnect()
        u4 = nil
    end
    if u6 ~= u7 then
        for v9, _ in u5 do
            u5[v9] = false
        end
    end
    u6 = u7
    local u10 = require(u2.Backpack:WaitForChild("SkillCallbacks")):GetSkillCallback(u8)
    game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    u4 = u3.InputBegan:Connect(function(p11, p12) --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u7
            [3] = u10
        --]]
        if u8.Parent == u7 and (_G.canuse ~= false and p12 ~= true) then
            if p11.KeyCode == Enum.KeyCode.Z then
                u10:HakaiSlash()
                return
            elseif p11.KeyCode == Enum.KeyCode.R then
                u10:Hahaba()
                return
            elseif p11.KeyCode == Enum.KeyCode.E then
                u10:MaserRay()
            elseif p11.KeyCode == Enum.KeyCode.X then
                u10:BlazeEruption()
            end
        else
            return
        end
    end)
    return u10
end
return v1