 

local u1 = math.noise
local u2 = math.cos
local u3 = math.sin
local u4 = math.sqrt
local function u30(p5, p6, p7, p8, p9, p10, p11) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u2
        [4] = u3
    --]]
    if p6 == Vector3.new(0, 0, 0) then
        local v12 = u1(p5.X / 100, p5.Z / 100, 1)
        local v13 = u1(p5.X / 100, p5.Z / 100, 0)
        p6 = Vector3.new(v12, v13)
    end
    local v14 = 6.283185307179586 / p7
    local v15 = p8 / v14
    local v16 = u4(p9 / v14)
    local v17 = p5.X
    local v18 = p5.Z
    local v19 = v14 * p6:Dot((Vector3.new(v17, v18))) - v16 * p10
    local v20 = u2(v19)
    local v21 = u3(v19)
    local v22 = p6.X * v20
    local v23 = p6.Y * v20
    local v24 = v15 * Vector3.new(v22, v21, v23)
    local v25, v26
    if p11 then
        local v27 = -p6.X * v21
        local v28 = -p6.Y * v21
        local v29 = p8 * Vector3.new(v27, v20, v28)
        v25 = p6.X * v29
        v26 = p6.Y * v29
    else
        v25 = nil
        v26 = nil
    end
    return v24, v25, v26
end
local function u36(p31, p32, p33) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u30
    --]]
    local v34 = Vector3.new(0, 0, 0)
    for _, v35 in ipairs(p32) do
        if v35.Cancel then
            return Vector3.new(0, 0, 0)
        end
        v34 = v34 + u30(p31, v35.Direction, v35.WaveLength, v35.Steepness, v35.Gravity, p33, false)
    end
    return v34
end
local function u47(p37, p38, p39) --[[ Line: 58 ]]
    --[[
    Upvalues:
        [1] = u30
    --]]
    local v40 = Vector3.new(0, 0, 0)
    local v41 = Vector3.new(0, 0, 0)
    local v42 = Vector3.new(0, 0, 0)
    for _, v43 in ipairs(p38) do
        if v43.Cancel then
            return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
        end
        local v44, v45, v46 = u30(p37, v43.Direction, v43.WaveLength, v43.Steepness, v43.Gravity, p39, true)
        v40 = v40 + v44
        v41 = v41 + v45
        v42 = v42 + v46
    end
    return v40, v41, v42
end
return table.freeze({
    ["_gerstner"] = u30,
    ["GetTransform"] = function(p48, p49, p50, p51, p52, p53) --[[ Name: GetTransform, Line 43 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        return u30(p48, p49, p50, p51, p52, p53, false)
    end,
    ["GetWaveTransform"] = u36,
    ["GetWaveTransformWithExtraNormals"] = u47,
    ["GetHeightAndNormal"] = function(p54, p55, p56, p57, p58, p59) --[[ Name: GetHeightAndNormal, Line 72 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        return u30(p54, p55, p56, p57, p58, p59, true)
    end,
    ["GetWaveHeightAtPosition"] = function(p60, p61, p62) --[[ Name: GetWaveHeightAtPosition, Line 76 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        local v63 = p60
        for _ = 0, 8 do
            p60 = v63 - u36(p60, p61, p62)
        end
        return u36(p60, p61, p62).Y
    end,
    ["GetWaveNormalAtPosition"] = function(p64, p65, p66) --[[ Name: GetWaveNormalAtPosition, Line 86 ]]
        --[[
        Upvalues:
            [1] = u47
        --]]
        local _, v67, v68 = u47(p64, p65, p66)
        return v67.Unit:Cross(v68.Unit)
    end
})