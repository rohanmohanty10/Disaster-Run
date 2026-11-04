 

return {
    ["map"] = function(p1, p2, p3, p4, p5) --[[ Name: map, Line 27 ]]
        if p3 == p2 then
            error("Range of zero")
        end
        return (p1 - p2) * (p5 - p4) / (p3 - p2) + p4
    end,
    ["lerp"] = function(p6, p7, p8) --[[ Name: lerp, Line 49 ]]
        return p6 + (p7 - p6) * p8
    end,
    ["lawOfCosines"] = function(p9, p10, p11) --[[ Name: lawOfCosines, Line 61 ]]
        local v12 = (p9 * p9 + p10 * p10 - p11 * p11) / (p9 * 2 * p10)
        local v13 = math.acos(v12)
        if v13 == v13 then
            return v13
        else
            return nil
        end
    end,
    ["round"] = function(p14, p15) --[[ Name: round, Line 81 ]]
        if p15 then
            local v16 = p14 / p15 + 0.5
            return math.floor(v16) * p15
        else
            local v17 = p14 + 0.5
            return math.floor(v17)
        end
    end,
    ["roundUp"] = function(p18, p19) --[[ Name: roundUp, Line 96 ]]
        local v20 = p18 / p19
        return math.ceil(v20) * p19
    end,
    ["roundDown"] = function(p21, p22) --[[ Name: roundDown, Line 107 ]]
        local v23 = p21 / p22
        return math.floor(v23) * p22
    end
}