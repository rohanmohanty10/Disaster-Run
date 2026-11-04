 

local function u39(p1, p2, p3) --[[ Line: 25 ]]
    local v4 = (p2.Y < p2.Z and p2.Y or p2.Z) * 0.5
    local v5 = p2.X * 0.5
    local v6 = p1.Position
    local v7 = p1.RightVector
    local v8 = (p3 - v6):Dot(v7)
    local v9 = -v5
    local v10 = math.clamp(v8, v9, v5)
    local v11 = v6 + v7 * v10
    local v12 = p1.Position + -p1.RightVector * v5
    local v13 = p1.Position + p1.RightVector * v5
    local v14 = -p1.RightVector
    local v15 = p1.RightVector
    local v16 = p3 - (p3 - v12):Dot(v14) * v14
    local v17 = p3 - (p3 - v13):Dot(v15) * v15
    local v18 = v16 - v12
    local v19 = v18.Magnitude == 0 and Vector3.new(0, 0, 0) or v18.Unit
    local v20 = (v16 - v12).Magnitude
    local v21
    if v20 < v4 then
        v21 = v20 or v4
    else
        v21 = v4
    end
    local v22 = v12 + v19 * v21
    local v23 = v17 - v13
    local v24 = v23.Magnitude == 0 and Vector3.new(0, 0, 0) or v23.Unit
    local v25 = (v17 - v13).Magnitude
    local v26
    if v25 < v4 then
        v26 = v25 or v4
    else
        v26 = v4
    end
    local v27 = v13 + v24 * v26
    local v28 = (v11 - p3).Magnitude
    local v29 = p3 - v11
    local v30 = v29.Magnitude == 0 and Vector3.new(0, 0, 0) or v29.Unit
    local v31 = v28 <= v4
    local v32 = v11 + v30 * v4
    local v33 = (v27 - p3).Magnitude
    local v34 = (v22 - p3).Magnitude
    local v35 = (v32 - p3).Magnitude
    local v36 = math.min(v33, v34, v35)
    if v10 == v5 or v36 == v33 then
        local v37 = p3 - v27
        return (v37.Magnitude == 0 and Vector3.new(0, 0, 0) or v37.Unit):Dot(v15) < 0, v27, v15
    end
    if v10 ~= -v5 and v36 ~= v34 then
        return v31, v32, v30
    end
    local v38 = p3 - v22
    return (v38.Magnitude == 0 and Vector3.new(0, 0, 0) or v38.Unit):Dot(v14) < 0, v22, v14
end
return function(p40, p41, p42, p43) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u39
    --]]
    local v44, v45, v46 = u39(p40, p41, p42)
    if v44 then
        return v44, v45, v46
    else
        return (v45 - p42).Magnitude < p43, v45, v46
    end
end