 

local u1 = CFrame.new
return function(p2, p3, p4, p5, p6) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = p5.Settings
    local v8 = v7.Stiffness
    local v9 = v7.Elasticity
    local v10 = p5.Bones[p2.ParentIndex]
    if v10 then
        local v11 = p2.FreeLength
        if v8 > 0 or v9 > 0 then
            local v12 = p4 or (u1(v10.Position) * v10.TransformOffset.Rotation * u1(p2.LocalTransformOffset.Position)).Position
            p3 = p3 + (v12 - p3) * (v9 * p6)
            if v8 > 0 then
                local v13 = v12 - p3
                local v14 = v13.Magnitude
                local v15 = v11 * (1 - v8) * 2
                if v15 < v14 then
                    p3 = p3 + v13 * ((v14 - v15) / v14)
                end
            end
        end
        local v16 = v10.Position - p3
        local v17 = v16.Magnitude
        if v17 > 0 then
            p3 = p3 + v16 * ((v17 - v11) / v17)
        end
    end
    return p3
end