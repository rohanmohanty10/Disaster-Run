 

return function(p1, p2, p3) --[[ Line: 11 ]]
    local v4 = p3.Bones[p1.ParentIndex]
    if v4 then
        local v5 = v4.Position
        local v6 = p2 - v4.Position
        return v5 + (v6.Magnitude == 0 and Vector3.new(0, 0, 0) or v6.Unit) * p1.FreeLength
    end
end