 

return function(p1, p2, p3, p4) --[[ Line: 13 ]]
    local v5 = p4:Inverse() * p2
    local v6 = v5.X
    local v7 = v5.Y
    local v8 = v5.Z
    local v9 = p1.XAxisLimits
    local v10 = p1.YAxisLimits
    local v11 = p1.ZAxisLimits
    local v12 = p1.AxisLocked[1] and 0 or 1
    local v13 = p1.AxisLocked[2] and 0 or 1
    local v14 = p1.AxisLocked[3] and 0 or 1
    if v9.Min == (-1 / 0) and (v9.Max == (1 / 0) and (v10.Min == (-1 / 0) and (v10.Max == (1 / 0) and (v11.Min == (-1 / 0) and v11.Max == (1 / 0))))) then
        if v12 == 1 and (v13 == 1 and v14 == 1) then
            return p2
        end
        local v15 = v6 * v12
        local v16 = v7 * v13
        local v17 = v8 * v14
        return p4 * Vector3.new(v15, v16, v17)
    end
    local v18 = v9.Min + p1.Radius
    local v19
    if v18 <= v9.Max - p1.Radius then
        v19 = v9.Max - p1.Radius or v18
    else
        v19 = v18
    end
    local v20 = v10.Min + p1.Radius
    local v21
    if v20 <= v10.Max - p1.Radius then
        v21 = v10.Max - p1.Radius or v20
    else
        v21 = v20
    end
    local v22 = v11.Min + p1.Radius
    local v23
    if v22 <= v11.Max - p1.Radius then
        v23 = v11.Max - p1.Radius or v22
    else
        v23 = v22
    end
    if v6 < v18 and v18 then
        v6 = v18
    elseif v19 < v6 then
        v6 = v19 or v6
    end
    if v7 < v20 and v20 then
        v7 = v20
    elseif v21 < v7 then
        v7 = v21 or v7
    end
    if v8 < v22 and v22 then
        v8 = v22
    elseif v23 < v8 then
        v8 = v23 or v8
    end
    local v24 = v6 * v12
    local v25 = v7 * v13
    local v26 = v8 * v14
    local v27 = p4 * Vector3.new(v24, v25, v26)
    local v28 = p4.RightVector
    local v29 = p4.UpVector
    local v30 = p4.LookVector
    local v31 = v27 - p3
    local v32 = v31.Magnitude == 0 and Vector3.new(0, 0, 0) or v31.Unit
    if v24 ~= v5.X then
        if v28:Dot(v32) < 0 then
            v28 = -v28 or v28
        end
        p1:ClipVelocity(v27, v28)
    end
    if v25 ~= v5.Y then
        if v29:Dot(v32) < 0 then
            v29 = -v29 or v29
        end
        p1:ClipVelocity(v27, v29)
    end
    if v26 ~= v5.Z then
        if v30:Dot(v32) > 0 then
            v30 = -v30 or v30
        end
        p1:ClipVelocity(v27, v30)
    end
    return v27
end