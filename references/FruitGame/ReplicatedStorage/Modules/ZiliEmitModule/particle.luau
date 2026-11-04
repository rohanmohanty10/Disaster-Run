 

local u1 = require("./mod/tween")
local u2 = require("./mod/utility")
return {
    ["emit"] = function(u3, u4, p5) --[[ Name: emit, Line 6 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        if u3.Enabled then
            u3.Enabled = false
        end
        local v6 = u2.getAttribute(u3, "EmitDelay", 0)
        local v7 = u2.getAttribute(u3, "EmitCount", 1)
        local v8 = u2.getAttribute(u3, "EmitDuration", 0)
        local v9 = v8 > 0
        task.wait(v6)
        if v9 then
            u4.Enabled = true
        end
        local v10 = u2.getAttribute(u3, "TimeScale_Duration", 0.1)
        local u11 = u2.getAttribute(u3, "TimeScale_Start", u4.TimeScale)
        local u12 = u2.getAttribute(u3, "TimeScale_End", u4.TimeScale)
        local u13 = nil
        if u11 == u12 then
            u4.TimeScale = u11
        else
            u13 = u1.fromParams(u2.getAttribute(u3, "TimeScale_Curve", u2.default_bezier), v10, function(p14, p15) --[[ Line: 34 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u11
                    [3] = u12
                    [4] = u4
                --]]
                u4.TimeScale = u2.lerp(u11, u12, (math.clamp(p14, 0, 1)))
                return p15
            end)
            table.insert(p5, u13)
        end
        u4:Emit(v7)
        if v9 then
            task.wait(v8)
            u4.Enabled = false
        end
        u1.timer(u3.Lifetime.Max, function(p16, p17) --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u13
            --]]
            if u3.TimeScale > 0 or p17 > 0 and (u13 and u13.Connected) then
                return p16 * u3.TimeScale
            else
                return nil
            end
        end, u13, p5)
    end
}