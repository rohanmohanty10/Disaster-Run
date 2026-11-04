 

local u1 = {
    ["Single"] = {
        ["Color3"] = { "Decal", "Texture" },
        ["Color"] = {
            "Part",
            "Union",
            "MeshPart",
            "SpotLight",
            "PointLight",
            "SurfaceLight",
            "SurfaceAppearance"
        }
    },
    ["Sequence"] = {
        ["Color"] = { "Beam", "Trail", "ParticleEmitter" }
    }
}
local function u4(p2, p3) --[[ Line: 55 ]]
    return Color3.new(p2.R * p3, p2.G * p3, p2.B * p3)
end
local function u60(p5, p6, p7, p8) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
    --]]
    if p8 or not p5:IsA("BasePart") then
        local v9, v10, v11 = p6:ToHSV()
        for _, v12 in u1 do
            for v13, v14 in v12 do
                if table.find(v14, p5.ClassName) then
                    local v15 = p5[v13]
                    if p7 == "multiply" then
                        if typeof(v15) == "Color3" then
                            local v16 = v15.R
                            local v17 = v15.G
                            local v18 = v15.B
                            local v19 = math.max(1, v16, v17, v18)
                            local v20, v21, v22 = Color3.new(v16 / v19, v17 / v19, v18 / v19):ToHSV()
                            local v23 = ((v20 + (v9 - 0.5) * 1) % 1 + 1) % 1
                            local v24 = v10 * 2 - 1
                            local v25
                            if v24 >= 0 then
                                local v26 = v21 + (1 - v21) * v24
                                v25 = math.clamp(v26, 0, 1)
                            else
                                local v27 = v21 - v21 * math.abs(v24)
                                v25 = math.clamp(v27, 0, 1)
                            end
                            local v28 = v11 * 2 - 1
                            local v29
                            if v28 >= 0 then
                                local v30 = v22 + (1 - v22) * v28
                                v29 = math.clamp(v30, 0, 1)
                            else
                                local v31 = v22 - v22 * math.abs(v28)
                                v29 = math.clamp(v31, 0, 1)
                            end
                            local v32 = Color3.fromHSV(v23, v25, v29)
                            p5[v13] = Color3.new(v32.R * v19, v32.G * v19, v32.B * v19)
                        elseif typeof(v15) == "ColorSequence" then
                            local v33 = {}
                            for _, v34 in v15.Keypoints do
                                local v35 = v34.Value
                                local v36 = v35.R
                                local v37 = v35.G
                                local v38 = v35.B
                                local v39 = math.max(1, v36, v37, v38)
                                local v40, v41, v42 = Color3.new(v36 / v39, v37 / v39, v38 / v39):ToHSV()
                                local v43 = ((v40 + (v9 - 0.5) * 1) % 1 + 1) % 1
                                local v44 = v10 * 2 - 1
                                local v45
                                if v44 >= 0 then
                                    local v46 = v41 + (1 - v41) * v44
                                    v45 = math.clamp(v46, 0, 1)
                                else
                                    local v47 = v41 - v41 * math.abs(v44)
                                    v45 = math.clamp(v47, 0, 1)
                                end
                                local v48 = v11 * 2 - 1
                                local v49
                                if v48 >= 0 then
                                    local v50 = v42 + (1 - v42) * v48
                                    v49 = math.clamp(v50, 0, 1)
                                else
                                    local v51 = v42 - v42 * math.abs(v48)
                                    v49 = math.clamp(v51, 0, 1)
                                end
                                local v52 = ColorSequenceKeypoint.new
                                local v53 = v34.Time
                                local v54 = u4
                                local v55 = Color3.fromHSV(v43, v45, v49)
                                table.insert(v33, v52(v53, v54(v55, v39)))
                            end
                            p5[v13] = ColorSequence.new(v33)
                        end
                    elseif typeof(v15) == "Color3" then
                        local v56 = v15.R
                        local v57 = v15.G
                        local v58 = v15.B
                        local v59 = math.max(1, v56, v57, v58)
                        Color3.new(v56 / v59, v57 / v59, v58 / v59)
                        p5[v13] = Color3.new(p6.R * v59, p6.G * v59, p6.B * v59)
                    elseif typeof(v15) == "ColorSequence" then
                        p5[v13] = ColorSequence.new(p6)
                    end
                end
            end
        end
    end
end
return function(p61, p62, ...) --[[ Name: recolor, Line 112 ]]
    --[[
    Upvalues:
        [1] = u60
    --]]
    for _, v63 in { ... } do
        u60(v63, p61, p62, true)
        for _, v64 in v63:GetDescendants() do
            u60(v64, p61, p62, false)
        end
    end
end