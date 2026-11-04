 

game:GetService("RunService")
require(script.Parent.FrustumCulling)
local v1 = {}
v1.__index = v1
local _ = script.Parent:GetAttribute("PlaneSize") or 100
local u2 = script.Parent:GetAttribute("MaxTextureAnimationDistance") or 280
local u3 = 1
local u4 = 0
local u5 = {}
local u6 = false
local u7 = CFrame.new()
local u8 = {}
function v1.AddWavePlane(p9) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    u5[p9] = true
end
function v1.RemoveWavePlane(p10) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    u5[p10] = nil
end
local function u14() --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
        [3] = u5
        [4] = u2
    --]]
    local v11 = workspace.CurrentCamera.CFrame
    if u7 ~= v11 then
        u7 = v11
        u8 = {}
        for v12 in pairs(u5) do
            if v12.isInFrustum and ((v12.wavePlane.Position - v11.Position) * Vector3.new(1, 0, 1)).Magnitude <= u2 then
                local v13 = u8
                table.insert(v13, v12)
            end
        end
        return true
    end
end
function v1.Update(p15) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u3
        [4] = u14
        [5] = u8
    --]]
    if u6 then
        u4 = u4 + p15
        if u4 >= 0.041666666666666664 then
            u4 = u4 - 0.041666666666666664
            u3 = u3 % 240 + 1
            local v16 = u3
            local v17 = "Water" .. tostring(v16)
            u14()
            for _, v18 in pairs(u8) do
                v18.wavePlane.MaterialVariant = v17
            end
        end
    else
        return
    end
end
function v1.SetEnabled(p19) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    u6 = p19
end
function v1.IsEnabled() --[[ Line: 78 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6
end
return v1