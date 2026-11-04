 

CFrame.Angles(0, 1.5707963267948966, 0)
local u1 = math.sin
local _ = math.sqrt
local _ = math.abs
local _ = table.insert
local u2 = Vector3.new
local v3 = game.ReplicatedStorage.Assets.StreamingObjects.NoWaterRegions
local v4 = v3:GetDescendants()
local u5 = {}
for v6 = 1, #v4 do
    if v4[v6]:IsA("BasePart") then
        local v7 = {
            ["CFrame"] = v4[v6].CFrame,
            ["Size"] = v4[v6].Size
        }
        table.insert(u5, v7)
    end
end
v3.ChildAdded:Connect(function(p8) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v9 = u5
    local v10 = {
        ["CFrame"] = p8.CFrame,
        ["Size"] = p8.Size
    }
    table.insert(v9, v10)
end)
return function(p11, p12, p13, _, p14, p15) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    debug.profilebegin("Worker")
    debug.profilebegin("Grab properties")
    local v16 = p14.SeaLevel
    local v17 = p14.SteepKA
    local v18 = p14.WaveAk
    local v19 = p14.WaveAXDir
    local v20 = p14.WaveAZDir
    local v21 = p14.SteepKB
    local v22 = p14.WaveBk
    local v23 = p14.WaveBXDir
    local v24 = p14.WaveBZDir
    local v25 = p14.ctA
    local v26 = p14.ctB
    debug.profileend()
    debug.profilebegin("Calculate height")
    for v27, v28 in ipairs(p12) do
        local v29 = v28[1]
        local v30 = v28[2]
        v28[4] = p13
        local v31 = v28[8]
        local v32
        if v28[3]:GetAttribute("noRender") == nil then
            if v31 == nil then
                local v33 = v16 + v17 * u1(v18 * (v19 * v29 + v20 * v30 - v25)) + v21 * u1(v22 * (v23 * v29 + v24 * v30 - v26))
                v32 = v16
                v16 = v33
            else
                v32 = v16
                for _, v34 in ipairs(v31) do
                    v16 = v16 + v34[5] * u1(v34[3] * (v34[1] * v29 + v34[2] * v30 - v34[4] * p13))
                end
            end
        else
            v32 = v16
            v16 = 0
        end
        p11[v27 + p15] = { v28[3], (u2(v29, v16, v30)) }
        v16 = v32
    end
    debug.profileend()
    debug.profileend()
end