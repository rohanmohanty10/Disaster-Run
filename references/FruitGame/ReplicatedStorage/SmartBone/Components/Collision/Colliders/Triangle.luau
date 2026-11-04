 

local u1 = Vector3.new().Dot
local u2 = Vector3.new().Cross
local u3 = math.clamp
return function(p4, p5, p6, p7) --[[ Name: ClosestPointOnTri, Line 52 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u2
    --]]
    local v8 = p5 - p4
    local v9 = p4 + u3(u1(p7 - p4, v8) / u1(v8, v8), 0, 1) * v8
    local v10 = p6 - p5
    local v11 = p5 + u3(u1(p7 - p5, v10) / u1(v10, v10), 0, 1) * v10
    local v12 = p4 - p6
    local v13 = p6 + u3(u1(p7 - p6, v12) / u1(v12, v12), 0, 1) * v12
    local v14 = u2(p5 - p4, p6 - p4)
    local v15 = v14.Magnitude == 0 and Vector3.new(0, 0, 0) or v14.Unit
    local v16 = p7 - (p7 - (p4 + p5 + p6) * 0.3333):Dot(v15) * v15
    local v17
    if u1(u2(p6 - p5, p7 - p5), (u2(p6 - p5, p4 - p5))) >= 0 and u1(u2(p6 - p4, p7 - p4), (u2(p6 - p4, p5 - p4))) >= 0 then
        v17 = u1(u2(p5 - p4, p7 - p4), (u2(p5 - p4, p6 - p4))) >= 0
    else
        v17 = false
    end
    if v17 then
        return v16, v15
    else
        local v18 = (v9 - p7).Magnitude
        local v19 = (v11 - p7).Magnitude
        local v20 = (v13 - p7).Magnitude
        local v21 = math.min(v18, v19, v20)
        if v21 == v18 then
            return v9, v15
        elseif v21 == v19 then
            return v11, v15
        elseif v21 == v20 then
            return v13, v15
        else
            return p7, v15
        end
    end
end