 

local u1 = require("./mod/tween")
local u2 = require("./mod/utility")
local u3 = Random.new()
local function u6(p4, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2.getAttribute(p4, "Width0", p4.Width0, true) * p5, u2.getAttribute(p4, "Width1", p4.Width1, true) * p5, u2.getAttribute(p4, "StartWidth0", p4.Width0, true) * p5, u2.getAttribute(p4, "StartWidth1", p4.Width1, true) * p5
end
return {
    ["emit"] = function(u7, u8, p9, p10) --[[ Name: emit, Line 18 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u3
            [4] = u1
        --]]
        local v11, v12, v13, v14 = u6(u7, p10)
        local u15 = u2.getAttribute(u7, "Width0_Start", v13)
        local u16 = u2.getAttribute(u7, "Width0_End", v11)
        local u17 = u2.getAttribute(u7, "Width1_Start", v14)
        local u18 = u2.getAttribute(u7, "Width1_End", v12)
        local v19 = u2.getAttribute(u7, "EmitDelay", 0)
        local v20 = u2.getAttribute(u7, "Duration", 1, true)
        local v21 = u2.getAttribute(u7, "EndTransparencyScale", 1, true)
        local v22 = u2.getRangeAttribute(u7, "EffectDuration", NumberRange.new(v20, v20), NumberRange.new(0, (1 / 0)))
        local v23 = u3:NextNumber(v22.Min, v22.Max)
        local u24 = u2.getAttribute(u7, "Transparency_Scale_Start", 1)
        local u25 = u2.getAttribute(u7, "Transparency_Scale_End", v21)
        local u26 = u2.getAttribute(u7, "Speed_Start", 1)
        local u27 = u2.getAttribute(u7, "Speed_End", 1)
        local u28 = u8.TextureSpeed
        task.wait(v19)
        u8.Enabled = true
        local u29 = 1
        local u30
        if u26 == u27 then
            u30 = nil
        else
            u30 = u1.fromParams(u2.getAttribute(u7, "Speed_Curve", u2.default_bezier), u2.getAttribute(u8, "Speed_Duration", 0.1), function(p31, p32) --[[ Line: 61 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u2
                    [3] = u26
                    [4] = u27
                    [5] = u8
                    [6] = u28
                --]]
                u29 = u2.lerp(u26, u27, p31)
                u8.TextureSpeed = u28 * u29
                return p32
            end)
            table.insert(p9, u30)
        end
        if u24 == u25 then
            if u24 ~= 1 then
                u8.Transparency = u2.scaleNumberSequence(u7.Transparency, function(p33, p34) --[[ Line: 74 ]]
                    --[[
                    Upvalues:
                        [1] = u24
                    --]]
                    return p33 + (u24 > 1 and 1 - p33 or -p33) * (u24 > 1 and u24 - 1 or 1 - u24), p34
                end)
            end
        else
            local v35 = u1.fromParams
            local v36 = u2.getAttribute(u7, "Transparency_Scale_Curve", u2.default_bezier)
            local function v42(p37, p38) --[[ Line: 88 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u24
                    [3] = u25
                    [4] = u8
                    [5] = u7
                    [6] = u29
                --]]
                local u39 = u2.lerp(u24, u25, p37)
                u8.Transparency = u2.scaleNumberSequence(u7.Transparency, function(p40, p41) --[[ Line: 74 ]]
                    --[[
                    Upvalues:
                        [1] = u39
                    --]]
                    return p40 + (u39 > 1 and 1 - p40 or -p40) * (u39 > 1 and u39 - 1 or 1 - u39), p41
                end)
                return p38 * u29
            end
            table.insert(p9, v35(v36, v23, v42, u30))
        end
        if u15 == u16 then
            u8.Width0 = u15
        else
            local v43 = u1.fromParams
            local v44 = u2.getAttribute(u7, "Width0_Curve", u2.default_bezier)
            local function v47(p45, p46) --[[ Line: 105 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u2
                    [3] = u15
                    [4] = u16
                    [5] = u29
                --]]
                u8.Width0 = u2.lerp(u15, u16, p45)
                return p46 * u29
            end
            table.insert(p9, v43(v44, v23, v47, u30))
        end
        if u17 == u18 then
            u8.Width1 = u17
        else
            local v48 = u1.fromParams
            local v49 = u2.getAttribute(u7, "Width1_Curve", u2.default_bezier)
            local function v52(p50, p51) --[[ Line: 122 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u2
                    [3] = u17
                    [4] = u18
                    [5] = u29
                --]]
                u8.Width1 = u2.lerp(u17, u18, p50)
                return p51 * u29
            end
            table.insert(p9, v48(v49, v23, v52, u30))
        end
        u1.timer(v23, function(p53, p54) --[[ Line: 133 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u30
            --]]
            if u29 > 0 or p54 > 0 and (u30 and u30.Connected) then
                return p53 * u29
            else
                return nil
            end
        end, u30, p9)
    end
}