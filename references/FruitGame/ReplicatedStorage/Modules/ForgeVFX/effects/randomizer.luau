 

local u1 = require("../mod/attributes")
local u2 = require("../mod/lerp")
local u3 = require("../mod/tween")
require("../types")
local u4 = require("../mod/utility")
local u5 = require("../obj/Bezier")
local u6 = Random.new()
local v7 = {}
local function u12(u8) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    local v9 = u3.bezier_cache[u8]
    if not v9 then
        local v10, v11 = pcall(function() --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u8
            --]]
            return u4.deserializePath(u8)
        end)
        if not v10 then
            return nil
        end
        v9 = u5.new(v11, 0)
        u3.bezier_cache[u8] = v9
    end
    return v9
end
function v7.emit(p13, _, u14) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
        [3] = u12
        [4] = u2
        [5] = u6
    --]]
    local u15 = u4.getTarget(p13)
    if u15 then
        local u16 = p13.Name
        local v17 = u1.get(p13, "_START_VALUE", nil)
        local v18 = u1.get(p13, "_END_VALUE", nil)
        if v17 == nil or v18 == nil then
            return
        else
            local v19 = typeof(v17)
            if v19 == typeof(v18) then
                local v20 = u12((u1.get(p13, "Weight_Curve", u4.linear_bezier)))
                if v20 then
                    local u21
                    if u14 then
                        u21 = u1.get(u15, u16, nil)
                    else
                        local v22
                        v22, u21 = pcall(function() --[[ Line: 74 ]]
                            --[[
                            Upvalues:
                                [1] = u15
                                [2] = u16
                            --]]
                            return u15[u16]
                        end)
                        if not v22 then
                            return
                        end
                    end
                    local v23 = (u2[v19] or u2.Other)(v17, v18, 1 - v20:getEase((u6:NextNumber())).y)
                    local v24 = u1.get(p13, "ResetOnFinish", true)
                    if u14 then
                        u1.set(u15, u16, v23)
                    else
                        u15[u16] = v23
                    end
                    if v24 then
                        task.defer(function() --[[ Line: 100 ]]
                            --[[
                            Upvalues:
                                [1] = u14
                                [2] = u1
                                [3] = u15
                                [4] = u16
                                [5] = u21
                            --]]
                            if u14 then
                                u1.set(u15, u16, u21)
                            else
                                u15[u16] = u21
                            end
                        end)
                    end
                end
            else
                return
            end
        end
    else
        return
    end
end
return v7