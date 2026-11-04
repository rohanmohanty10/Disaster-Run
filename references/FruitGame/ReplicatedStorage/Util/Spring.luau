 

local u1 = {}
u1.__index = u1
local u2 = math.exp
local u3 = math.sin
local u4 = math.cos
local u5 = math.sqrt
function u1.new(p6, p7, p8) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v9 = type(p6) == "number"
    assert(v9)
    local v10 = type(p7) == "number"
    assert(v10)
    local v11 = p6 * p7 >= 0
    assert(v11, "Spring does not converge")
    local v12 = {
        ["d"] = p6,
        ["f"] = p7,
        ["g"] = p8,
        ["p"] = p8,
        ["v"] = p8 * 0
    }
    local v13 = u1
    return setmetatable(v12, v13)
end
function u1.SetGoal(p14, p15) --[[ Line: 31 ]]
    p14.g = p15
end
function u1.GetPosition(p16) --[[ Line: 35 ]]
    return p16.p
end
function u1.GetVelocity(p17) --[[ Line: 39 ]]
    return p17.v
end
function u1.Update(p18, p19) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u4
        [4] = u3
    --]]
    local v20 = p18.d
    local v21 = p18.f * 2 * 3.141592653589793
    local v22 = p18.g
    local v23 = p18.p
    local v24 = p18.v
    local v25 = v23 - v22
    local v26 = u2(-v20 * v21 * p19)
    local v27, v28
    if v20 == 1 then
        v27 = (v25 * (1 + v21 * p19) + v24 * p19) * v26 + v22
        v28 = (v24 * (1 - v21 * p19) - v25 * (v21 * v21 * p19)) * v26
    elseif v20 < 1 then
        local v29 = u5(1 - v20 * v20)
        local v30 = u4(v21 * v29 * p19)
        local v31 = u3(v21 * v29 * p19)
        local v32
        if v29 > 0.0001 then
            v32 = v31 / v29
        else
            local v33 = p19 * v21
            v32 = v33 + (v33 * v33 * (v29 * v29) * (v29 * v29) / 20 - v29 * v29) * (v33 * v33 * v33) / 6
        end
        local v34
        if v21 * v29 > 0.0001 then
            v34 = v31 / (v21 * v29)
        else
            local v35 = v21 * v29
            v34 = p19 + (p19 * p19 * (v35 * v35) * (v35 * v35) / 20 - v35 * v35) * (p19 * p19 * p19) / 6
        end
        v27 = (v25 * (v30 + v20 * v32) + v24 * v34) * v26 + v22
        v28 = (v24 * (v30 - v32 * v20) - v25 * (v32 * v21)) * v26
    else
        local v36 = u5(v20 * v20 - 1)
        local v37 = -v21 * (v20 - v36)
        local v38 = -v21 * (v20 + v36)
        local v39 = (v24 - v25 * v37) / (2 * v21 * v36)
        local v40 = (v25 - v39) * u2(v37 * p19)
        local v41 = v39 * u2(v38 * p19)
        v27 = v40 + v41 + v22
        v28 = v40 * v37 + v41 * v38
    end
    p18.p = v27
    p18.v = v28
    return v27
end
return u1