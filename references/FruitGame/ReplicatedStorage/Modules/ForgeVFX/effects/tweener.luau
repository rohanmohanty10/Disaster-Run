 

local u1 = require("../mod/attributes")
local u2 = require("../mod/lerp")
local u3 = require("../mod/tween")
require("../types")
local u4 = require("../mod/utility")
local u5 = Random.new()
return {
    ["emit"] = function(p6, p7, u8) --[[ Name: emit, Line 11 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
            [3] = u5
            [4] = u3
            [5] = u2
        --]]
        local u9 = u4.getTarget(p6)
        if u9 then
            local u10 = p6.Name
            local v11 = u1.get(p6, "EmitDelay", 0)
            local v12 = u1.get(p6, "ResetOnFinish", true)
            local v13 = u1.getRange(p6, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)))
            if v11 > 0 then
                task.wait(v11)
            end
            local u14 = u1.get(p6, "_END_VALUE", nil)
            local v15 = u1.get(p6, "_START_VALUE", nil)
            local v16
            if u8 then
                v16 = u1.get(u9, u10, nil)
            else
                local v17
                v17, v16 = pcall(function() --[[ Line: 37 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u10
                    --]]
                    return u9[u10]
                end)
                if not v17 then
                    return
                end
            end
            local u18 = v15 or v16
            local v19 = typeof(u18)
            if v19 == typeof(u14) then
                local v20 = u5:NextNumber(v13.Min, v13.Max)
                local u21 = u1.get(p6, "Speed_Start", 1)
                local u22 = u1.get(p6, "Speed_End", 1)
                local u23 = u21
                local u24
                if u21 == u22 then
                    u24 = nil
                else
                    u24 = u3.fromParams(u1.get(p6, "Speed_Curve", u4.default_bezier), u1.get(p6, "Speed_Duration", 0.1), function(p25, p26) --[[ Line: 71 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u4
                            [3] = u21
                            [4] = u22
                        --]]
                        u23 = u4.lerp(u21, u22, p25)
                        return p26
                    end)
                    table.insert(p7, u24)
                end
                local u27 = u2[v19] or u2.Other
                local v32 = u8 and function(p28, p29) --[[ Line: 83 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u9
                        [3] = u10
                        [4] = u27
                        [5] = u18
                        [6] = u14
                        [7] = u23
                    --]]
                    u1.set(u9, u10, u27(u18, u14, p28))
                    return p29 * u23
                end or function(p30, p31) --[[ Line: 87 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u10
                        [3] = u27
                        [4] = u18
                        [5] = u14
                        [6] = u23
                    --]]
                    u9[u10] = u27(u18, u14, p30)
                    return p31 * u23
                end
                local v33 = u3.fromParams
                local v34 = u1.get(p6, "Easing_Curve", u4.linear_bezier)
                local v35 = u4.RENDER_PRIORITY + p7.depth
                table.insert(p7, v33(v34, v20, v32, u24, nil, nil, v35))
                if v12 then
                    local function v36() --[[ Line: 106 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u1
                            [3] = u9
                            [4] = u10
                            [5] = u18
                        --]]
                        if u8 then
                            u1.set(u9, u10, u18)
                        else
                            u9[u10] = u18
                        end
                    end
                    table.insert(p7, v36)
                end
                u3.timer(v20, function(p37, p38) --[[ Line: 115 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u24
                    --]]
                    if u23 > 0 or p38 > 0 and (u24 and u24.Connected) then
                        return p37 * u23
                    else
                        return nil
                    end
                end, u24, p7)
            end
        else
            return
        end
    end
}