 

local u1 = math.rad
local u2 = math.acos
local u3 = CFrame.fromAxisAngle
return function(p4, p5, p6) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v7 = p6.Bones[p4.ParentIndex]
    if not v7 then
        return p5
    end
    local v8 = v7.RotationLimit
    if v8 >= 180 then
        return p5
    end
    local v9 = p6.Bones[v7.ParentIndex]
    if not v9 then
        return p5
    end
    local v10 = v7.Position
    local v11 = v10 - v9.Position
    local v12 = v11.Magnitude == 0 and Vector3.new(0, 0, 0) or v11.Unit
    local v13 = p5 - v10
    local v14 = v13.Magnitude
    local v15 = v13.Magnitude == 0 and Vector3.new(0, 0, 0) or v13.Unit
    if v8 <= 0 then
        return v10 + v12 * v14
    end
    local v16 = u1(p4.RotationLimit)
    if v16 <= u2((v12:Dot(v15))) then
        local v17 = v12:Cross(v15)
        v15 = u3(v17.Magnitude == 0 and Vector3.new(0, 0, 0) or v17.Unit, v16) * v12
    end
    if v15 == v15 then
        v12 = v15
    end
    return v10 + v12 * v14
end