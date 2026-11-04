 

return function(p1, p2, p3, p4) --[[ Line: 27 ]]
    local v5 = (p2.Y < p2.Z and p2.Y or p2.Z) * 0.5
    local v6 = p2.X
    local v7 = p1 * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)
    local v8 = v7.Position
    local v9 = v7.UpVector
    local v10 = v6 * 0.5
    local v11 = (p3 - v8):Dot(v9)
    local v12 = -v10
    local v13 = v8 + v9 * math.clamp(v11, v12, v10)
    local v14 = (v13 - p3).Magnitude
    local v15 = p3 - v13
    local v16 = v15.Magnitude == 0 and Vector3.new(0, 0, 0) or v15.Unit
    local v17 = v14 <= v5
    local v18 = v13 + v16 * v5
    if v17 then
        return v17, v18, v16
    else
        return (v18 - p3).Magnitude < p4, v18, v16
    end
end