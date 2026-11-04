 

local v1 = game:GetService("ReplicatedStorage").OceanSimulator
local u2 = require(v1.GerstnerCalculation)
local u3 = require(v1.WaveSettings)
local v4 = script:GetActor()
local u5 = workspace.CurrentCamera
local u6 = {}
local u7 = 10
local u8 = CFrame.new(Vector3.new(0, 0, 0))
v4:BindToMessage("PrepareSimulation", function(p9, p10, p11, p12) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
    --]]
    u7 = p12 or u7
    for v13 = p10, p11 do
        local v14 = p9[v13]
        if v14 then
            u6[#u6 + 1] = v14
        end
    end
end)
v4:BindToMessageParallel("Simulate", function(p15, p16, p17) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u6
        [4] = u7
        [5] = u8
        [6] = u2
    --]]
    if p17 then
        u3._UpdateTree(p17)
    end
    local v18 = p16 or u5.CFrame.Position
    local v19 = {}
    for _, v20 in ipairs(u6) do
        local v21 = v20.WorldPosition
        local v22 = (v18 - v21).Magnitude or 0
        if v22 <= u7 then
            local v23 = u3.GetWaveSettings(v21.X, v21.Z)
            v19[v20] = u8 + (1 - v22 / u7) * u2.GetWaveTransform(v21, v23, p15)
        end
    end
    task.synchronize()
    for v24, v25 in v19 do
        v24.Transform = v25
    end
end)