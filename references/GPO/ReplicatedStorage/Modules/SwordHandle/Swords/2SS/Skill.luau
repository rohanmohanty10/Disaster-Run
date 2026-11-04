 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Modules.Skills)
require(game.ReplicatedStorage.Modules.sBeat)
local function u8() --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = u2.Backpack:GetChildren()
    local v6 = nil
    for v7 = 1, #v5 do
        if v5[v7]:IsA("Tool") and (v5[v7]:FindFirstChild("SwordEquip") and v5[v7].Name ~= "2SS") then
            return v5[v7].Name
        end
    end
    return v6
end
function v1.setup(_, u9, u10) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u3
        [4] = u8
    --]]
    if u4 then
        u4:Disconnect()
        u4 = nil
    end
    local u11 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    local u12 = require(u2.Backpack:WaitForChild("SkillCallbacks")):GetSkillCallback(u10)
    u4 = u3.InputBegan:Connect(function(p13, p14) --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
            [3] = u11
            [4] = u8
            [5] = u12
        --]]
        if u10.Parent == u9 and (_G.canuse ~= false and p14 ~= true) then
            if u11.Stats.FightingStyle.Value == "2SS" then
                if u8() == nil then
                    if p13.KeyCode == Enum.KeyCode.E then
                        u12["72CaliberPhoenix"](u12)
                        return
                    elseif p13.KeyCode == Enum.KeyCode.R then
                        u12:RagingWhirl()
                        return
                    elseif p13.KeyCode == Enum.KeyCode.Z then
                        u12:TowerClimb()
                        return
                    elseif p13.KeyCode == Enum.KeyCode.X then
                        u12:NitoryuStrike()
                    elseif p13.KeyCode == Enum.KeyCode.C then
                        u12:RashomonDraw()
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    end)
    return u12
end
return v1