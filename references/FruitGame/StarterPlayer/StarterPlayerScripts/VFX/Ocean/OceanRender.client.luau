 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v3 = v1.Modules
local u4 = require(v3.OceanModule)
local v5 = require(v3.DataStructures.CuboidGrid)
require(v3.DataStructures.Cuboid)
local u6 = v5.new(150)
local _ = v1.Assets.StreamingObjects
local u7 = nil
local u8 = u4.OceanMeshes
local u9 = workspace.CurrentCamera
v2.Heartbeat:Connect(function() --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u4
        [3] = u7
        [4] = u8
        [5] = u6
    --]]
    debug.profilebegin("OceanRender")
    local v10 = u9.CFrame
    if u4.NoOceanRegion then
        if u7 ~= false then
            u7 = false
            u4.NoRender = true
            u8.Parent = nil
        end
    else
        local v11 = u6:GetPointData(v10.X, v10.Y, v10.Z) == nil
        if u7 ~= v11 then
            u7 = v11
            u4.NoRender = not v11
            u8.Parent = v11 and workspace.Ocean or nil
        end
    end
    debug.profileend()
end)