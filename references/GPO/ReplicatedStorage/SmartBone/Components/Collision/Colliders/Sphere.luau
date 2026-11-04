 

return function(p1, p2, p3, p4) --[[ Line: 18 ]]
    local v5 = p1.Position
    local v6 = p2.X
    local v7 = p2.Y
    local v8 = p2.Z
    local v9 = math.min(v6, v7, v8) * 0.5
    local v10 = (v5 - p3).Magnitude
    local v11 = p3 - v5
    local v12 = v11.Magnitude == 0 and Vector3.new(0, 0, 0) or v11.Unit
    local v13 = v10 <= v9
    local v14 = v5 + v12 * v9
    if v13 then
        return v13, v14, v12
    else
        return (v14 - p3).Magnitude < p4, v14, v12
    end
end