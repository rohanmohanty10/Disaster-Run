 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("RxInstanceUtils")
local u3 = v1("RxBrioUtils")
local u13 = {
    ["observe"] = function(p4, p5, p6) --[[ Name: observe, Line 24 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u13
        --]]
        warn("[RxValueBaseUtils.observe] - Deprecated since 4.0.0. Use RxValueBaseUtils.observeBrio")
        return u2.observeLastNamedChildBrio(p4, p5, p6):Pipe({ u3.switchMap(function(p7) --[[ Line: 29 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                return u13.observeValue(p7)
            end) })
    end,
    ["observeBrio"] = function(p8, p9, p10) --[[ Name: observeBrio, Line 43 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u13
        --]]
        return u2.observeLastNamedChildBrio(p8, p9, p10):Pipe({ u3.switchMapBrio(function(p11) --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                return u13.observeValue(p11)
            end) })
    end,
    ["observeValue"] = function(p12) --[[ Name: observeValue, Line 58 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        return u2.observeProperty(p12, "Value")
    end
}
return u13