 

local u1 = CFrame.new(Vector3.new(0, 0, 0))
local v2 = game:GetService("ReplicatedStorage").OceanSimulator.OceanSimulator
local u3 = require(v2.GerstnerCalculation)
local u4 = require(v2.WaveSettings)
return function(p5, p6, p7, p8, p9, p10, p11) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
        [3] = u3
    --]]
    if p10 then
        u4._UpdateTree(p10)
    end
    local v12 = workspace.CurrentCamera
    local v13 = {}
    for v14 = p6, p7 do
        local v15 = p5[v14]
        if v15 then
            v13[#v13 + 1] = v15
        end
    end
    local v16 = p9 or v12.CFrame.Position
    for _, v17 in ipairs(v13) do
        local v18 = v17.WorldPosition
        local v19 = (v16 - v18).Magnitude or 0
        if v19 <= 10 then
            local v20 = u4.GetWaveSettings(v18.X, v18.Z)
            p11[v17] = u1 + (1 - v19 / 10) * u3.GetWaveTransform(v18, v20, p8)
        end
    end
end