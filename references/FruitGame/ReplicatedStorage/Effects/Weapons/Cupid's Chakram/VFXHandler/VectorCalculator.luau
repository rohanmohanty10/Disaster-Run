 

local u19 = {
    ["GetCircularPosition"] = function(p1, p2, p3) --[[ Name: GetCircularPosition, Line 5 ]]
        local v4 = math.cos(p3) * p2
        local v5 = math.sin(p3) * p2
        return p1 + Vector3.new(v4, 0, v5)
    end,
    ["GetCircularCFrame"] = function(p6, p7, p8, p9) --[[ Name: GetCircularCFrame, Line 9 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        local v10 = u19.GetCircularPosition(p6, p8, p9)
        return CFrame.lookAt(p6, p6 + p7) * CFrame.new(v10)
    end,
    ["GetAngleBetweenVectors"] = function(p11, p12, p13) --[[ Name: GetAngleBetweenVectors, Line 14 ]]
        local v14 = p11.Unit
        local v15 = p12.Unit
        if not p13 then
            local v16 = v14:Dot(v15)
            return math.acos(v16)
        end
        local v17 = v14:Dot(v15)
        local v18 = v14.X * v15.Z - v14.Z * v15.X
        return math.atan2(v18, v17)
    end
}
return u19