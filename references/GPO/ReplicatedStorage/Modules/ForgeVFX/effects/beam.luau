 

local u1 = require("../mod/attributes")
local u2 = require("../mod/tween")
require("../types")
local u3 = require("../mod/utility")
local u4 = require("../mod/common/flipbook")
local u5 = require("../pkg/Promise")
local u6 = Random.new()
local function u9(p7, p8) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.get(p7, "Width0", p7.Width0, true) * p8, u1.get(p7, "Width1", p7.Width1, true) * p8, u1.get(p7, "StartWidth0", p7.Width0, true) * p8, u1.get(p7, "StartWidth1", p7.Width1, true) * p8
end
return {
    ["emit"] = function(p10, u11, p12, p13) --[[ Name: emit, Line 24 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u1
            [3] = u6
            [4] = u2
            [5] = u3
            [6] = u4
            [7] = u5
        --]]
        local v14 = p12.effects.prepareEmitOnFinish(u11, p12)
        local v15, v16, v17, v18 = u9(p10, p13)
        local u19 = u1.get(p10, "Width0_Start", v17)
        local u20 = u1.get(p10, "Width0_End", v15)
        local u21 = u1.get(p10, "Width1_Start", v18)
        local u22 = u1.get(p10, "Width1_End", v16)
        local u23 = u1.get(p10, "CurveSize0_Start", u11.CurveSize0)
        local u24 = u1.get(p10, "CurveSize0_End", u11.CurveSize0)
        local u25 = u1.get(p10, "CurveSize1_Start", u11.CurveSize1)
        local u26 = u1.get(p10, "CurveSize1_End", u11.CurveSize1)
        local v27 = u1.get(p10, "EmitDelay", 0)
        local v28 = u1.get(p10, "Duration", 1, true)
        local v29 = u1.get(p10, "EndTransparencyScale", 1, true)
        local v30 = u1.getRange(p10, "EffectDuration", NumberRange.new(v28, v28), NumberRange.new(0, (1 / 0)))
        local v31 = u1.get(p10, "Length_Scale_Start", NumberRange.new(1, 1))
        local v32 = u1.get(p10, "Length_Scale_End", NumberRange.new(1, 1))
        local u33 = u1.get(p10, "Length_Texture_Start", p10.TextureLength)
        local u34 = u1.get(p10, "Length_Texture_End", p10.TextureLength)
        local v35 = u6:NextNumber(v30.Min, v30.Max)
        local u36 = u6:NextNumber(v32.Min, v32.Max)
        local u37 = u6:NextNumber(v31.Min, v31.Max)
        local u38 = u1.get(p10, "Transparency_Scale_Start", 1)
        local u39 = u1.get(p10, "Transparency_Scale_End", v29)
        local u40 = u1.get(p10, "Speed_Texture_Start", p10.TextureSpeed)
        local u41 = u1.get(p10, "Speed_Texture_End", p10.TextureSpeed)
        local u42 = u1.get(p10, "Speed_Start", 1)
        local u43 = u1.get(p10, "Speed_End", 1)
        local u44 = u11.TextureSpeed
        task.wait(v27)
        u11.Enabled = true
        local v45 = {}
        local u46 = 1
        local u47 = nil
        local v48 = p12.effects.emitNested(u11, p12.depth + 1).Finished
        table.insert(v45, v48)
        if u40 ~= u41 then
            u2.fromParams(u1.get(p10, "Speed_Texture_Curve", u3.default_bezier), v35, function(p49, p50) --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u3
                    [3] = u40
                    [4] = u41
                    [5] = u11
                    [6] = u46
                --]]
                u44 = u3.lerp(u40, u41, p49)
                u11.TextureSpeed = u44 * u46
                return p50
            end)
        end
        if u42 ~= u43 then
            u47 = u2.fromParams(u1.get(p10, "Speed_Curve", u3.default_bezier), u1.get(u11, "Speed_Duration", 0.1), function(p51, p52) --[[ Line: 98 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u3
                    [3] = u42
                    [4] = u43
                    [5] = u11
                    [6] = u44
                --]]
                u46 = u3.lerp(u42, u43, p51)
                u11.TextureSpeed = u44 * u46
                return p52
            end)
            table.insert(p12, u47)
        end
        local v53 = p10.Transparency.Keypoints
        local v54 = #v53
        local u55 = table.create(v54)
        local u56 = table.create(v54)
        for v57, v58 in v53 do
            u56[v57] = {
                ["time"] = v58.Time,
                ["value"] = v58.Value,
                ["envelope"] = v58.Envelope
            }
        end
        local u59 = nil
        local function u67(p60) --[[ Line: 127 ]]
            --[[
            Upvalues:
                [1] = u59
                [2] = u56
                [3] = u55
                [4] = u11
            --]]
            if u59 then
                local v61 = p60 - u59
                if math.abs(v61) < 0.001 then
                    return
                end
            end
            u59 = p60
            local v62 = p60 > 1 and p60 - 1 or 1 - p60
            for v63, v64 in u56 do
                local v65 = v64.value
                local v66 = p60 > 1 and 1 - v65 or -v65
                u55[v63] = NumberSequenceKeypoint.new(v64.time, v65 + v66 * v62, v64.envelope)
            end
            u11.Transparency = NumberSequence.new(u55)
        end
        local u68 = u11.Attachment0
        local u69 = u11.Attachment1
        local u70
        if u68 then
            u70 = u68.CFrame
        else
            u70 = u68
        end
        local u71
        if u69 then
            u71 = u69.CFrame
        else
            u71 = u69
        end
        local function u76(p72) --[[ Line: 149 ]]
            --[[
            Upvalues:
                [1] = u70
                [2] = u71
                [3] = u68
                [4] = u69
            --]]
            if u70 and u71 then
                local v73 = (u71.Position - u70.Position) * 0.5
                local v74 = u70.Position + v73
                local v75 = v73 * p72
                u68.CFrame = CFrame.new(v74 - v75) * (u70 - u70.Position)
                u69.CFrame = CFrame.new(v74 + v75) * (u71 - u71.Position)
            end
        end
        table.insert(p12, function() --[[ Line: 168 ]]
            --[[
            Upvalues:
                [1] = u76
            --]]
            u76(1)
        end)
        if u38 == u39 then
            if u38 ~= 1 then
                u67(u38)
            end
        else
            local v77 = u2.fromParams
            local v78 = u1.get(p10, "Transparency_Scale_Curve", u3.default_bezier)
            local function v81(p79, p80) --[[ Line: 178 ]]
                --[[
                Upvalues:
                    [1] = u67
                    [2] = u3
                    [3] = u38
                    [4] = u39
                    [5] = u46
                --]]
                u67(u3.lerp(u38, u39, p79))
                return p80 * u46
            end
            table.insert(p12, v77(v78, v35, v81, u47))
        end
        if u33 ~= u34 then
            local v82 = u2.fromParams
            local v83 = u1.get(p10, "Length_Texture_Curve", u3.default_bezier)
            local function v86(p84, p85) --[[ Line: 195 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u3
                    [3] = u33
                    [4] = u34
                    [5] = u46
                --]]
                u11.TextureLength = u3.lerp(u33, u34, p84)
                return p85 * u46
            end
            table.insert(p12, v82(v83, v35, v86, u47))
        end
        if u37 == u36 then
            if u33 ~= 1 then
                u76(u37)
            end
        else
            local v87 = u2.fromParams
            local v88 = u1.get(p10, "Length_Scale_Curve", u3.default_bezier)
            local function v91(p89, p90) --[[ Line: 207 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u37
                    [3] = u36
                    [4] = u76
                    [5] = u46
                --]]
                u76((u3.lerp(u37, u36, p89)))
                return p90 * u46
            end
            table.insert(p12, v87(v88, v35, v91, u47))
        end
        if u19 == u20 then
            u11.Width0 = u19
        else
            local v92 = u2.fromParams
            local v93 = u1.get(p10, "Width0_Curve", u3.default_bezier)
            local function v96(p94, p95) --[[ Line: 222 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u3
                    [3] = u19
                    [4] = u20
                    [5] = u46
                --]]
                u11.Width0 = u3.lerp(u19, u20, p94)
                return p95 * u46
            end
            table.insert(p12, v92(v93, v35, v96, u47))
        end
        if u21 == u22 then
            u11.Width1 = u21
        else
            local v97 = u2.fromParams
            local v98 = u1.get(p10, "Width1_Curve", u3.default_bezier)
            local function v101(p99, p100) --[[ Line: 234 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u3
                    [3] = u21
                    [4] = u22
                    [5] = u46
                --]]
                u11.Width1 = u3.lerp(u21, u22, p99)
                return p100 * u46
            end
            table.insert(p12, v97(v98, v35, v101, u47))
        end
        if u23 == u24 then
            u11.Width0 = u19
        else
            local v102 = u2.fromParams
            local v103 = u1.get(p10, "CurveSize0_Curve", u3.default_bezier)
            local function v106(p104, p105) --[[ Line: 246 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u3
                    [3] = u23
                    [4] = u24
                    [5] = u46
                --]]
                u11.CurveSize0 = u3.lerp(u23, u24, p104)
                return p105 * u46
            end
            table.insert(p12, v102(v103, v35, v106, u47))
        end
        if u25 == u26 then
            u11.Width1 = u21
        else
            local v107 = u2.fromParams
            local v108 = u1.get(p10, "CurveSize1_Curve", u3.default_bezier)
            local function v111(p109, p110) --[[ Line: 258 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u3
                    [3] = u25
                    [4] = u26
                    [5] = u46
                --]]
                u11.CurveSize1 = u3.lerp(u25, u26, p109)
                return p110 * u46
            end
            table.insert(p12, v107(v108, v35, v111, u47))
        end
        local v112 = u4.getFlipbookData(p10)
        local v113
        if v112 then
            local v115 = {
                ["ref"] = p10,
                ["frames"] = v112,
                ["speedTween"] = u47,
                ["effectDuration"] = v35,
                ["curve"] = u1.get(p10, "Flipbook_Change_Curve", u3.linear_bezier),
                ["duration"] = u1.get(p10, "Flipbook_Change_Duration", v35),
                ["getSpeed"] = function() --[[ Name: getSpeed, Line 281 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                    --]]
                    return u46
                end,
                ["setTexture"] = function(p114) --[[ Name: setTexture, Line 285 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                    --]]
                    u11.Texture = p114
                end
            }
            v113 = u4.getChangeDuration(v115)
            local v116 = u2.fromParams
            local v117 = v115.curve
            local v118 = u4.createUpdateCallback(v115)
            table.insert(p12, v116(v117, v113, v118, u47))
        else
            v113 = 0
        end
        u2.timer(math.max(v35, v113), function(p119, p120) --[[ Line: 298 ]]
            --[[
            Upvalues:
                [1] = u46
                [2] = u47
            --]]
            if u46 > 0 or p120 > 0 and (u47 and u47.Connected) then
                return p119 * u46
            else
                return nil
            end
        end, u47, p12)
        if v14 then
            local v121 = p12.effects.emitOnFinish(v14, u11.Parent or workspace.Terrain, p12.depth + 1).Finished
            table.insert(v45, v121)
        end
        u5.all(v45):await()
    end
}