 

local u1 = game:GetService("RunService")
local u2 = require(script.Parent.FrustumCulling)
local u3 = require(script.Parent.TextureSync)
local u4 = script.Parent:GetAttribute("MaxRenderDistance") or 512
local u5 = script.Parent:GetAttribute("RefreshRate") or 0.02
local u6 = {}
u6.__index = u6
local u7 = {}
local u8 = false
local u9 = nil
local u10 = 0
function u6.AddWavePlane(p11) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    u7[p11] = true
end
function u6.RemoveWavePlane(p12) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    u7[p12] = nil
end
function u6.SetEnabled(p13) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u9
        [3] = u1
        [4] = u6
    --]]
    u8 = p13
    if u8 and not u9 then
        u9 = u1.Heartbeat:Connect(function(p14) --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            u6.Update(p14)
        end)
    elseif not u8 and u9 then
        u9:Disconnect()
        u9 = nil
    end
end
function u6.Update(p15) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u10
        [3] = u5
        [4] = u2
        [5] = u4
        [6] = u7
    --]]
    u3.Update(p15)
    u10 = u10 + p15
    if u10 >= u5 then
        u10 = 0
        local v16 = workspace:GetServerTimeNow()
        local v17 = workspace.CurrentCamera
        local v18 = v17.CFrame.Position
        local v19 = u2.getFrustumPlanes(v17, u4)
        for v20 in pairs(u7) do
            v20:UpdateSimulation(v16, v19, v18)
        end
    end
end
return u6