 

local v1 = {}
local u2 = 0
local u3 = 1
function v1.Damping(p4) --[[ Line: 2 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v5 = u2
    local v6 = u3
    return math.clamp(p4, v5, v6)
end
function v1.AnchorDepth(p7) --[[ Line: 7 ]]
    return math.floor(p7)
end
local u8 = 0
local u9 = 1
function v1.Stiffness(p10) --[[ Line: 2 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u9
    --]]
    local v11 = u8
    local v12 = u9
    return math.clamp(p10, v11, v12)
end
local u13 = 0
local u14 = 1
function v1.Inertia(p15) --[[ Line: 2 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u14
    --]]
    local v16 = u13
    local v17 = u14
    return math.clamp(p15, v16, v17)
end
local u18 = 0
local u19 = 1
function v1.Elasticity(p20) --[[ Line: 2 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u19
    --]]
    local v21 = u18
    local v22 = u19
    return math.clamp(p20, v21, v22)
end
local u23 = 0
local u24 = 1
function v1.BlendWeight(p25) --[[ Line: 2 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u24
    --]]
    local v26 = u23
    local v27 = u24
    return math.clamp(p25, v26, v27)
end
local u28 = 0
local u29 = 165
function v1.UpdateRate(p30) --[[ Line: 2 ]]
    --[[
    Upvalues:
        [1] = u28
        [2] = u29
    --]]
    local v31 = u28
    local v32 = u29
    return math.clamp(p30, v31, v32)
end
local u33 = 0
local u34 = 10
function v1.WindStrength(p35) --[[ Line: 2 ]]
    --[[
    Upvalues:
        [1] = u33
        [2] = u34
    --]]
    local v36 = u33
    local v37 = u34
    return math.clamp(p35, v36, v37)
end
local u38 = Vector3.new(0, -0.01, 0)
function v1.Gravity(p39) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    return p39 + u38
end
return v1