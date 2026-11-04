 

return {
    ["QuadBezier"] = function(p1, p2, p3, p4) --[[ Name: QuadBezier, Line 7 ]]
        local v5 = p2 + (p3 - p2) * p1
        return v5 + (p3 + (p4 - p3) * p1 - v5) * p1
    end,
    ["CubicBezier"] = function(p6, p7, p8, p9, p10) --[[ Name: CubicBezier, Line 14 ]]
        local v11 = p7 + (p8 - p7) * p6
        local v12 = p8 + (p9 - p8) * p6
        local v13 = p9 + (p10 - p9) * p6
        local v14 = v11 + (v12 - v11) * p6
        return v14 + (v12 + (v13 - v12) * p6 - v14) * p6
    end
}