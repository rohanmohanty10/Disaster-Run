 

local u1 = require("../mod/attributes")
local u2 = require("../mod/tween")
require("../types")
local u3 = require("../mod/utility")
return {
    ["emit"] = function(u4, u5, p6) --[[ Name: emit, Line 8 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u3
        --]]
        if u4.Enabled then
            u4.Enabled = false
        end
        local v7 = u1.get(u4, "EmitDelay", 0)
        local v8 = u1.get(u4, "EmitCount", 1)
        local v9 = u1.get(u4, "EmitDuration", 0)
        local v10 = v9 > 0
        task.wait(v7)
        if v10 then
            u5.Enabled = true
        end
        local v11 = u1.get(u4, "TimeScale_Duration", 0.1)
        local u12 = u1.get(u4, "TimeScale_Start", u5.TimeScale, true)
        local u13 = u1.get(u4, "TimeScale_End", u5.TimeScale, true)
        local u14 = nil
        if u12 == u13 then
            if u12 ~= u5.TimeScale then
                u5.TimeScale = u12
            end
        else
            u14 = u2.fromParams(u1.get(u4, "TimeScale_Curve", u3.default_bezier), v11, function(p15, p16) --[[ Line: 36 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u12
                    [3] = u13
                    [4] = u5
                --]]
                u5.TimeScale = u3.lerp(u12, u13, (math.clamp(p15, 0, 1)))
                return p16
            end)
            table.insert(p6, u14)
        end
        u5:Emit(v8)
        if v10 then
            task.wait(v9)
            u5.Enabled = false
        end
        u2.timer(u4.Lifetime.Max, function(p17, p18) --[[ Line: 57 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u14
            --]]
            if u4.TimeScale > 0 or p18 > 0 and (u14 and u14.Connected) then
                return p17 * u4.TimeScale
            else
                return nil
            end
        end, u14, p6)
    end
}