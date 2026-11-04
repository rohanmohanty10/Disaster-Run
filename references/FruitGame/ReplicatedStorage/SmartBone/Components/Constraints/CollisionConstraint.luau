 

return function(p1, p2, p3) --[[ Line: 3 ]]
    local v4 = p1._collisionClosestPoints
    local v5 = p1._collisionNormals
    local v6 = p1.CollisionHits
    local v7 = p1.Radius
    table.clear(v4)
    table.clear(v5)
    table.clear(v6)
    local v8 = 0
    for v9 = 1, #p3 do
        local v10 = p3[v9]
        local v11 = v10:GetCollisions(p2, v7, v4, v5, v8)
        if v8 < v11 then
            v6[#v6 + 1] = v10:GetObject()
            v8 = v11
        else
            v8 = v11
        end
    end
    for v12 = 1, v8 do
        p2 = v4[v12] + v5[v12] * v7
    end
    p1._collisionCount = v8
    return p2
end