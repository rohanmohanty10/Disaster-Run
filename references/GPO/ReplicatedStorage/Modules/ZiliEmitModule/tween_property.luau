 

local u1 = require("./mod/lerp")
local u2 = require("./mod/tween")
local u3 = require("./mod/utility")
local u4 = Random.new()
return {
    ["emit"] = function(u5, p6, p7) --[[ Name: emit, Line 9 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
            [4] = u1
        --]]
        local u8 = p6.Name
        local v9 = u3.getAttribute(p6, "EmitDelay", 0)
        local v10 = u3.getAttribute(p6, "ResetOnFinish", true)
        local v11 = u3.getRangeAttribute(p6, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)))
        if v9 > 0 then
            task.wait(v9)
        end
        local u12 = p6:GetAttribute("_END_VALUE")
        local v13 = p6:GetAttribute("_START_VALUE")
        local v14, v15 = pcall(function() --[[ Line: 24 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u8
            --]]
            return u5[u8]
        end)
        local u16 = v13 or v15
        local v17 = typeof(u16)
        if v14 and v17 == typeof(u12) then
            local v18 = u4:NextNumber(v11.Min, v11.Max)
            local u19 = u3.getAttribute(p6, "Speed_Start", 1)
            local u20 = u3.getAttribute(p6, "Speed_End", 1)
            local u21 = u19
            local u22
            if u19 == u20 then
                u22 = nil
            else
                u22 = u2.fromParams(u3.getAttribute(p6, "Speed_Curve", u3.default_bezier), u3.getAttribute(p6, "Speed_Duration", 0.1), function(p23, p24) --[[ Line: 51 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u3
                        [3] = u19
                        [4] = u20
                    --]]
                    u21 = u3.lerp(u19, u20, p23)
                    return p24
                end)
                table.insert(p7, u22)
            end
            local u25 = u1[v17] or u1.Other
            local v26 = u2.fromParams
            local v27 = u3.getAttribute(p6, "Easing_Curve", u3.linear_bezier)
            local v28 = u3.RENDER_PRIORITY + p7.depth
            table.insert(p7, v26(v27, v18, function(p29, p30) --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u8
                    [3] = u25
                    [4] = u16
                    [5] = u12
                    [6] = u21
                --]]
                u5[u8] = u25(u16, u12, p29)
                return p30 * u21
            end, u22, nil, nil, v28))
            if v10 then
                table.insert(p7, function() --[[ Line: 79 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u8
                        [3] = u16
                    --]]
                    u5[u8] = u16
                end)
            end
            u2.timer(v18, function(p31, p32) --[[ Line: 84 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u22
                --]]
                if u21 > 0 or p32 > 0 and (u22 and u22.Connected) then
                    return p31 * u21
                else
                    return nil
                end
            end, u22, p7)
        end
    end
}