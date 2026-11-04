 

local function u35(p1, p2, p3) --[[ Line: 9 ]]
    local v4 = p1:pointToObjectSpace(p3)
    local v5 = p2.x
    local v6 = p2.y
    local v7 = p2.z
    local v8 = v4.x
    local v9 = v4.y
    local v10 = v4.z
    local v11 = -v5 * 0.5
    local v12 = v5 * 0.5
    local v13 = math.clamp(v8, v11, v12)
    local v14 = -v6 * 0.5
    local v15 = v6 * 0.5
    local v16 = math.clamp(v9, v14, v15)
    local v17 = -v7 * 0.5
    local v18 = v7 * 0.5
    local v19 = math.clamp(v10, v17, v18)
    if v13 == v8 and (v16 == v9 and v19 == v10) then
        local v20 = v8 - v5 * 0.5
        local v21 = v9 - v6 * 0.5
        local v22 = v10 - v7 * 0.5
        local v23 = -v8 - v5 * 0.5
        local v24 = -v9 - v6 * 0.5
        local v25 = -v10 - v7 * 0.5
        local v26 = math.max(v20, v21, v22, v23, v24, v25)
        if v26 == v20 then
            local v27 = v5 * 0.5
            return true, p1 * Vector3.new(v27, v9, v10), p1.XVector
        elseif v26 == v21 then
            local v28 = v6 * 0.5
            return true, p1 * Vector3.new(v8, v28, v10), p1.YVector
        elseif v26 == v22 then
            local v29 = v7 * 0.5
            return true, p1 * Vector3.new(v8, v9, v29), p1.ZVector
        elseif v26 == v23 then
            local v30 = -v5 * 0.5
            return true, p1 * Vector3.new(v30, v9, v10), -p1.XVector
        elseif v26 == v24 then
            local v31 = -v6 * 0.5
            return true, p1 * Vector3.new(v8, v31, v10), -p1.YVector
        elseif v26 == v25 then
            local v32 = -v7 * 0.5
            return true, p1 * Vector3.new(v8, v9, v32), -p1.ZVector
        else
            warn("CLOSEST POINT ON BOX FAIL")
            return false, p1.Position, Vector3.new(0, 0, 0)
        end
    else
        local v33 = p1 * Vector3.new(v13, v16, v19)
        local v34 = p3 - v33
        return false, v33, v34.Magnitude == 0 and Vector3.new(0, 0, 0) or v34.Unit
    end
end
return function(p36, p37, p38, p39) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u35
    --]]
    local v40, v41, v42 = u35(p36, p37, p38)
    if v40 then
        return v40, v41, v42
    else
        return (v41 - p38).Magnitude < p39, v41, v42
    end
end