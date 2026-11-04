 

local v8 = {
    ["Bezier"] = {
        ["QuadBezier"] = function(p1, p2, p3, p4) --[[ Name: QuadBezier, Line 7 ]]
            local v5 = p2 + (p3 - p2) * p1
            return v5 + (p3 + (p4 - p3) * p1 - v5) * p1
        end
    },
    ["Easings"] = {
        ["easeOutSine"] = function(p6) --[[ Name: easeOutSine, Line 14 ]]
            local v7 = p6 * 3.141592653589793 / 2
            return math.sin(v7)
        end
    }
}
return v8