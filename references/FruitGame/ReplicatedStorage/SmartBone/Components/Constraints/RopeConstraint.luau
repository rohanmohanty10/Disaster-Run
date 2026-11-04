 

return function(p1, p2, p3) --[[ Line: 11 ]]
    local v4 = p3.Bones[p1.ParentIndex]
    if v4 then
        local v5 = p1.FreeLength
        local v6 = p2 - v4.Position
        local v7 = v6.Magnitude == 0 and Vector3.new(0, 0, 0) or v6.Unit
        if v6.Magnitude < v5 then
            v5 = v6.Magnitude or v5
        end
        return v4.Position + v7 * v5
    end
end