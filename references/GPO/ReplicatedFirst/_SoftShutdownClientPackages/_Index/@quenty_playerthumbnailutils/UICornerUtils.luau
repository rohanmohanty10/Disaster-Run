 

return {
    ["fromScale"] = function(p1, p2) --[[ Name: fromScale, Line 7 ]]
        local v3 = Instance.new("UICorner")
        v3.CornerRadius = UDim.new(p1, 0)
        v3.Parent = p2
        return v3
    end,
    ["fromOffset"] = function(p4, p5) --[[ Name: fromOffset, Line 14 ]]
        local v6 = Instance.new("UICorner")
        v6.CornerRadius = UDim.new(0, p4)
        v6.Parent = p5
        return v6
    end,
    ["clampPositionToFrame"] = function(p7, p8, p9, p10) --[[ Name: clampPositionToFrame, Line 23 ]]
        local v11 = p9 > 0
        assert(v11, "Bad radius")
        assert(p10, "Bad point")
        local v12 = p10.x
        local v13 = p10.y
        local v14 = p7.x
        local v15 = p7.y
        local v16 = p8.x
        local v17 = p8.y
        local v18 = v14 + p9
        local v19 = v14 + v16 - p9
        local v20 = v15 + p9
        local v21 = v15 + v17 - p9
        if v18 < v19 then
            v18 = math.clamp(v12, v18, v19)
        end
        if v20 < v21 then
            v20 = math.clamp(v13, v20, v21)
        end
        local v22 = Vector2.new(v18, v20)
        local v23 = p10 - v22
        if v23.magnitude == 0 then
            return nil, nil
        end
        local v24 = v23.unit
        return v22 + v24 * p9, v24
    end
}