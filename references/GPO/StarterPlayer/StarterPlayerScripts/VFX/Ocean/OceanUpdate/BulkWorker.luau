 

local _ = game:GetService("ReplicatedStorage").Modules
CFrame.Angles(0, 1.5707963267948966, 0)
local u1 = math.sin
local _ = math.sqrt
local _ = math.abs
local u2 = Vector3.new
local u3 = table.insert
local v4 = game.ReplicatedStorage.Assets.StreamingObjects.NoWaterRegions
local v5 = v4:GetDescendants()
local u6 = {}
for v7 = 1, #v5 do
    if v5[v7]:IsA("BasePart") then
        local v8 = {
            ["CFrame"] = v5[v7].CFrame,
            ["Size"] = v5[v7].Size
        }
        table.insert(u6, v8)
    end
end
v4.ChildAdded:Connect(function(p9) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v10 = u6
    local v11 = {
        ["CFrame"] = p9.CFrame,
        ["Size"] = p9.Size
    }
    table.insert(v10, v11)
end)
local function u23(p12) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v13 = p12.X
    local v14 = p12.Y
    local v15 = Vector3.new(v13, 0, v14)
    for _, v16 in ipairs(u6) do
        local v17 = v16.CFrame
        local v18 = v16.Size
        local v19 = v17:PointToObjectSpace(v15)
        local v20 = v19.X
        local v21
        if math.abs(v20) <= v18.X / 2 then
            local v22 = v19.Z
            v21 = math.abs(v22) <= v18.Z / 2
        else
            v21 = false
        end
        if v21 == true then
            return true
        end
    end
    return false
end
return function(p24, p25, p26, p27, p28) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u1
        [3] = u2
        [4] = u3
    --]]
    debug.profilebegin("NoMoveWorker")
    debug.profilebegin("Grab properties")
    local v29 = p27.SeaLevel
    local v30 = p27.SteepKA
    local v31 = p27.WaveAk
    local v32 = p27.WaveAXDir
    local v33 = p27.WaveAZDir
    local v34 = p27.ctA
    local v35 = p27.SteepKB
    local v36 = p27.WaveBk
    local v37 = p27.WaveBXDir
    local v38 = p27.WaveBZDir
    local v39 = p27.ctB
    local _ = p27.WaveAc
    local _ = p27.WaveBc
    local v40 = p27.VertexGrid
    local v41 = p27.DefaultRegionData
    debug.profileend()
    debug.profilebegin("Calculate height")
    for _, v42 in ipairs(p25.Vertices) do
        local v43 = v42[1]
        local v44 = v42[2]
        v40:MoveNode(v42, v43, v44)
        v42[4] = p26
        local v45 = v42[8]
        local v46 = not u23((Vector3.new(v43, v44)))
        local v47
        if v46 then
            if v45 == nil then
                local v48 = v29 + v30 * u1(v31 * (v32 * v43 + v33 * v44 - v34)) + v35 * u1(v36 * (v37 * v43 + v38 * v44 - v39))
                v47 = v29
                v29 = v48
            else
                v47 = v29
                for _, v49 in ipairs(v45) do
                    v29 = v29 + v49[5] * u1(v49[3] * (v49[1] * v43 + v49[2] * v44 - v49[4] * p26))
                end
            end
            v42[8] = p28:GetPointData(v43, v44) or v41
        else
            v47 = v29
            v29 = 0
        end
        u3(p24, { v42[3], u2(v43, v29, v44), v46 })
        v29 = v47
    end
    for _, v50 in ipairs(p25.EdgeVertices) do
        local v51 = {}
        local v52 = v50[3]
        local v53 = u2(v50[1], v29, v50[2])
        local v54 = u23
        local v55 = v50[1]
        local v56 = v50[2]
        __set_list(v51, 1, {v52, v53, not v54((Vector3.new(v55, v56)))})
        u3(p24, v51)
    end
    debug.profileend()
    debug.profileend()
end