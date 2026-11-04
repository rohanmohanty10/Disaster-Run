 

local u11 = {
    ["Conversions"] = {
        ["Kilometer"] = 280.0336040324839,
        ["Hektometer"] = 28.00336040324839,
        ["Decameter"] = 2.800336040324839,
        ["Meter"] = 0.2800336040324839,
        ["Decimeter"] = 0.02800336040324839,
        ["Centimeter"] = 0.002800336040324839,
        ["Millimeter"] = 0.0002800336040324839,
        ["Miles"] = 4850.975973116774,
        ["Yards"] = 2.7562363483618033,
        ["Feet"] = 0.9187454494539344,
        ["Inches"] = 0.07656212078782787
    },
    ["Convert"] = function(p1, p2) --[[ Name: Convert, Line 22 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v3
        if u11.Conversions[p2] == nil then
            v3 = false
        else
            v3 = p1 * u11.Conversions[p2]
        end
        return v3
    end,
    ["ConvertInverse"] = function(p4, p5) --[[ Name: ConvertInverse, Line 26 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v6
        if u11.Conversions[p5] == nil then
            v6 = false
        else
            v6 = u11.Conversions[p5] / p4
        end
        return v6
    end,
    ["ConvertRounded"] = function(p7, p8) --[[ Name: ConvertRounded, Line 30 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v9
        if u11.Conversions[p8] == nil then
            v9 = false
        else
            local v10 = p7 * u11.Conversions[p8]
            v9 = math.floor(v10)
        end
        return v9
    end
}
return u11