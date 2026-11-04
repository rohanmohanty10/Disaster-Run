 

local u1 = require("../mod/attributes")
local u2 = require("../mod/tween")
require("../types")
local u3 = require("../mod/utility")
local u4 = require("../mod/common/bezier")
local u5 = require("../obj/Bezier")
local u6 = require("../pkg/Promise")
require("../obj/ObjectCache")
local v7 = {}
local u8 = nil
function v7.init(p9) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    u8 = p9
end
function v7.deinit() --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    u8 = nil
end
local function u13(p10) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v11 = {}
    local v12 = u1.get(p10, "Segments", 8)
    v11.segments = math.max(v12, 2)
    v11.jaggedness = u1.getRange(p10, "Jaggedness", NumberRange.new(0.5, 1), NumberRange.new(0, (1 / 0)))
    v11.offsetScale = u1.get(p10, "OffsetScale", 1)
    v11.refreshRate = u1.get(p10, "RefreshRate", 15)
    v11.independentSegments = u1.get(p10, "IndependentSegments", false)
    v11.refreshDuringDissipate = u1.get(p10, "RefreshDuringDissipate", false)
    v11.nestedEffectMode = u1.getEnum(p10, "NestedEffectMode", "None", {
        "None",
        "All",
        "Head",
        "Tail"
    })
    v11.colorSequence = u1.get(p10, "Color", ColorSequence.new(Color3.new(1, 1, 1)))
    v11.colorEasingData = u1.get(p10, "Color_Curve", u3.linear_bezier)
    v11.colorDuration = u1.get(p10, "Color_Duration", 1)
    v11.transparencyStart = u1.get(p10, "Transparency_Start", 0)
    v11.transparencyEnd = u1.get(p10, "Transparency_End", 0)
    v11.fillColorSequence = u1.get(p10, "Fill_Color", ColorSequence.new(Color3.new(1, 1, 1)))
    v11.fillColorEasingData = u1.get(p10, "Fill_Color_Curve", u3.linear_bezier)
    v11.fillColorDuration = u1.get(p10, "Fill_Color_Duration", 1)
    v11.fillTransparencyStart = u1.get(p10, "Fill_Transparency_Start", 1)
    v11.fillTransparencyEnd = u1.get(p10, "Fill_Transparency_End", 1)
    v11.fillDepthMode = u1.getEnum(p10, "Fill_DepthMode", "Occluded", { "AlwaysOnTop", "Occluded" })
    v11.fadeInStart = u1.get(p10, "Fade_In_Start", 1)
    v11.fadeInDuration = u1.get(p10, "Fade_In_Duration", 0)
    v11.fadeInCurveData = u1.get(p10, "Fade_In_Curve", u3.default_bezier)
    v11.fadeOutEnd = u1.get(p10, "Fade_Out_End", 1)
    v11.fadeOutDuration = u1.get(p10, "Fade_Out_Duration", 0)
    v11.fadeOutCurveData = u1.get(p10, "Fade_Out_Curve", u3.default_bezier)
    v11.lengthStart = u1.get(p10, "Length_Start", 1)
    v11.lengthEnd = u1.get(p10, "Length_End", 1)
    v11.dissipateMode = u1.getEnum(p10, "Dissipate_Mode", "None", { "None", "Retract", "Scale" })
    v11.dissipateDuration = u1.get(p10, "Dissipate_Duration", 0.5)
    v11.dissipateCurveData = u1.get(p10, "Dissipate_Curve", u3.default_bezier)
    v11.widthStart = u1.get(p10, "Width_Start", 2)
    v11.widthEnd = u1.get(p10, "Width_End", 0.2)
    return v11
end
local function u17(p14) --[[ Line: 77 ]]
    local v15 = {}
    for v16 = 1, p14 do
        v15[v16] = {
            ["birthTime"] = nil,
            ["initialWidth"] = nil,
            ["initialTransparency"] = nil,
            ["wasVisible"] = false
        }
    end
    return v15
end
local function u40(p18, p19, p20, p21, p22) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v23 = table.create(p19 + 1)
    local v24 = 1 / p19
    v23[1] = p20(0)
    local v25 = v23[1]
    for v26 = 1, p19 - 1 do
        local v27 = v26 * v24
        local v28 = p20(v27)
        local v29 = v27 + 0.01
        local v30 = p20((math.min(v29, 1))) - v28
        local v31 = v30.Magnitude <= 0.001 and Vector3.new(0, 1, 0) or v30.Unit
        local v32, v33 = u4.getPerpendicularVectors(v31)
        local v34 = (v28 - v25).Magnitude
        local v35 = p18:NextNumber(p21.Min, p21.Max)
        local v36 = v34 * 0.8
        local v37 = v35 * p22 * v34
        local v38 = math.min(v37, v36)
        local v39 = p18:NextNumber(0, 6.283185307179586)
        v25 = v28 + (v32 * math.cos(v39) + v33 * math.sin(v39)) * v38
        v23[v26 + 1] = v25
    end
    v23[p19 + 1] = p20(1)
    return v23
end
local function u63(p41, p42, p43, p44, p45, p46, p47) --[[ Line: 148 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v48 = table.create(p42 + 1)
    local v49 = 1 / p42
    local v50 = p44 - p43
    local v51 = v50.Magnitude
    if v51 > 0.001 then
        p47 = v50 / v51
    end
    local v52, v53 = u4.getPerpendicularVectors(p47)
    local v54 = v51 * v49
    v48[1] = p43
    for v55 = 1, p42 - 1 do
        local v56 = p43:Lerp(p44, v55 * v49)
        local v57 = p41:NextNumber(p45.Min, p45.Max)
        local v58 = v54 * 0.8
        local v59 = v57 * p46 * v54
        local v60 = math.min(v59, v58)
        local v61 = p41:NextNumber(0, 6.283185307179586)
        local v62 = (v52 * math.cos(v61) + v53 * math.sin(v61)) * v60
        v48[v55 + 1] = v56 + v62
    end
    v48[p42 + 1] = p44
    return v48
end
local function u75(p64, p65, p66, p67, p68) --[[ Line: 193 ]]
    local v69 = (1 - p64) * p68.boltLength
    local v70 = (p68.distanceTraveled - v69) / p68.transitionBuffer
    local v71 = math.clamp(v70, 0, 1)
    local v72 = p68.distanceTraveled / p68.boltLength
    local v73 = math.min(v72, 1) * p68.curvedLengthT
    local v74 = p68.curvedTailT + p64 * p68.curvedLengthT + v73
    return p65((math.min(1, v74))):Lerp(p66:Lerp(p67, p64), v71)
end
local function u101(p76, p77, p78, p79, p80, p81, p82, p83, p84) --[[ Line: 217 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u75
    --]]
    local v85 = table.create(p77 + 1)
    local v86 = table.create(p77 + 1)
    local v87 = 1 / p77
    local v88 = p80 - p79
    local v89 = v88.Magnitude
    if v89 > 0.001 then
        p83 = v88 / v89
    end
    local v90, v91 = u4.getPerpendicularVectors(p83)
    local v92 = v89 * v87
    for v93 = 0, p77 do
        local v94 = u75(v93 * v87, p78, p79, p80, p84)
        if v93 == 0 or v93 == p77 then
            v85[v93 + 1] = v94
            v86[v93 + 1] = Vector3.new(0, 0, 0)
        else
            local v95 = p76:NextNumber(p81.Min, p81.Max)
            local v96 = v92 * 0.8
            local v97 = v95 * p82 * v92
            local v98 = math.min(v97, v96)
            local v99 = p76:NextNumber(0, 6.283185307179586)
            local v100 = (v90 * math.cos(v99) + v91 * math.sin(v99)) * v98
            v85[v93 + 1] = v94 + v100
            v86[v93 + 1] = v100
        end
    end
    return v85, v86
end
local function u112(p102, p103, p104, p105, p106) --[[ Line: 259 ]]
    --[[
    Upvalues:
        [1] = u75
    --]]
    local v107 = table.create(p102 + 1)
    local v108 = 1 / p102
    local v109 = p106.jaggedOffsets
    for v110 = 0, p102 do
        local v111 = u75(v110 * v108, p103, p104, p105, p106)
        v107[v110 + 1] = v111 + (not v109 and Vector3.new(0, 0, 0) or v109[v110 + 1])
    end
    return v107
end
function v7.emit(u113, u114, u115, p116) --[[ Line: 285 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u4
        [3] = u13
        [4] = u1
        [5] = u2
        [6] = u3
        [7] = u5
        [8] = u6
        [9] = u17
        [10] = u40
        [11] = u101
        [12] = u63
        [13] = u112
    --]]
    local v117 = u113:FindFirstChild("Points")
    if v117 and (v117:IsA("Attachment") and u8) then
        local u118 = u4.readCommonAttributes(u113)
        local u119 = u13(u113)
        local u120 = u4.drawFuncMap[u118.shapeType]
        if u120 then
            u120 = u4.drawFuncMap[u118.shapeType][u118.shapeStyle]
        end
        if u120 then
            local v121 = u118.emitDuration > 0
            task.wait(u118.emitDelay)
            if v121 and not p116 then
                u1.trigger(u113, "Enabled", true)
                if u118.speedStart ~= u118.speedEnd then
                    u1.setState(u113, "SpeedTweening", true)
                    local v122 = u2.fromParams
                    local v123 = u1.get(u113, "Speed_Curve", u3.default_bezier)
                    local v124 = u1.get(u113, "Speed_Duration", 0.1)
                    local function v127(p125, p126) --[[ Line: 317 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u113
                            [3] = u3
                            [4] = u118
                        --]]
                        u1.setState(u113, "SpeedOverride", u3.lerp(u118.speedStart, u118.speedEnd, p125))
                        return p126
                    end
                    local function v128() --[[ Line: 322 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u113
                        --]]
                        u1.setState(u113, "SpeedTweening", nil)
                    end
                    table.insert(u115, v122(v123, v124, v127, nil, v128))
                end
                task.wait(u118.emitDuration)
                u1.trigger(u113, "Enabled", false)
                u1.clearState(u113)
                return
            elseif u118.emitCount <= 0 then
                return
            else
                local u129 = u4.validateParent(u113)
                if u129 then
                    local u130, u131 = u3.getTransformedOriginExtents(u129)
                    if u130 then
                        local u132, u133 = u4.findEndAttachments(u113)
                        local u134 = u3.getBezierPoints(v117)
                        local u135 = Random.new()
                        local u136 = not u132
                        if u136 then
                            u136 = u5.new(u134)
                        end
                        local u137 = u5.new(u3.deserializePath(u119.colorEasingData), 0)
                        local u138 = u5.new(u3.deserializePath(u119.fillColorEasingData), 0)
                        local u139 = u5.new(u3.deserializePath(u119.fadeInCurveData), 0)
                        local u140 = u5.new(u3.deserializePath(u119.fadeOutCurveData), 0)
                        local u141 = u4.createHitboxParams({
                            ["enabled"] = u118.hitboxEnabled,
                            ["collisionGroup"] = u118.hitboxCollisionGroup,
                            ["filterTag"] = u118.hitboxFilterTag,
                            ["filterType"] = u118.hitboxFilterType,
                            ["ignoreCanCollide"] = u118.hitboxIgnoreCanCollide
                        }, u129, v117)
                        local u142 = {}
                        for _ = 1, u118.emitCount do
                            local u143 = u135:NextNumber(u118.duration.Min, u118.duration.Max)
                            local u144 = u118.projectileEnabled
                            if u144 then
                                u144 = u135:NextNumber(u118.projectileLifetime.Min, u118.projectileLifetime.Max)
                            end
                            local v145 = u6.new
                            local function v354(u146) --[[ Line: 382 ]]
                                --[[
                                Upvalues:
                                    [1] = u4
                                    [2] = u130
                                    [3] = u131
                                    [4] = u118
                                    [5] = u120
                                    [6] = u135
                                    [7] = u132
                                    [8] = u129
                                    [9] = u136
                                    [10] = u134
                                    [11] = u133
                                    [12] = u119
                                    [13] = u17
                                    [14] = u8
                                    [15] = u138
                                    [16] = u115
                                    [17] = u114
                                    [18] = u3
                                    [19] = u40
                                    [20] = u142
                                    [21] = u1
                                    [22] = u113
                                    [23] = u2
                                    [24] = u141
                                    [25] = u101
                                    [26] = u63
                                    [27] = u112
                                    [28] = u137
                                    [29] = u139
                                    [30] = u140
                                    [31] = u143
                                    [32] = u144
                                --]]
                                local v147 = u4.calculateEmissionCFrame(u130, u131, {
                                    ["face"] = u118.face,
                                    ["spreadAngle"] = u118.spreadAngle,
                                    ["mirror"] = u118.mirror,
                                    ["mirrorRot"] = u118.mirrorRot,
                                    ["partial"] = u118.partial,
                                    ["emissionDirection"] = u118.emissionDirection
                                }, u120, u135, u132, u129:IsA("Attachment"))
                                local v148 = u136 or u4.createBezierWithEndpoint(u134, v147, u132, u133)
                                local u149 = u4.createPosGetter(v148, u134, v147, u132, true)
                                local u150 = table.create(u119.segments)
                                local u151 = table.create(u119.segments)
                                local u152 = u17(u119.segments)
                                local v153 = 1 / u119.segments
                                local u154 = table.create(u119.segments)
                                for v155 = 1, u119.segments do
                                    u154[v155] = {
                                        ["start"] = (v155 - 1) * v153,
                                        ["finish"] = v155 * v153
                                    }
                                end
                                if u8 then
                                    local v156 = u119.fillTransparencyStart < 1 and true or u119.fillTransparencyEnd < 1
                                    local u157, u158
                                    if v156 then
                                        u157 = Instance.new("Model")
                                        u157.Name = "LightningContainer"
                                        u157.Parent = workspace.Terrain
                                        u158 = Instance.new("Highlight")
                                        u158.Adornee = u157
                                        u158.FillColor = u4.getColorWithEasingOklab(u119.fillColorSequence, 0, u138)
                                        u158.FillTransparency = u119.fillTransparencyStart
                                        u158.OutlineTransparency = 1
                                        u158.DepthMode = Enum.HighlightDepthMode[u119.fillDepthMode]
                                        u158.Parent = u157
                                    else
                                        u157 = nil
                                        u158 = nil
                                    end
                                    local u159
                                    if u119.nestedEffectMode == "None" then
                                        u159 = nil
                                    else
                                        u159 = u115.effects.prepareEmitOnFinish(u114, u115)
                                    end
                                    local u160 = {}
                                    local v161 = {}
                                    for v162 = 1, u119.segments do
                                        local v163 = u3.getRandomId()
                                        local v164 = u8:get(v163)._getReal()
                                        u3.copyProperties(u114, v164, u3.COPY_PART_PROPERTIES)
                                        local v165 = u119.widthStart
                                        local v166 = u119.widthStart
                                        v164.Size = Vector3.new(v165, v166, 1)
                                        v164.Anchored = true
                                        v164.CanQuery = false
                                        v164.CanTouch = false
                                        v164.CanCollide = false
                                        if v156 and u157 then
                                            v164.Parent = u157
                                        end
                                        local v167 = u119.nestedEffectMode
                                        local v168
                                        if v167 == "All" then
                                            v168 = true
                                        elseif v167 == "Head" then
                                            v168 = v162 == u119.segments
                                        elseif v167 == "Tail" then
                                            v168 = v162 == 1
                                        else
                                            v168 = false
                                        end
                                        if v168 then
                                            local v169 = u114:Clone()
                                            for _, v170 in v169:GetChildren() do
                                                v170.Parent = v164
                                                if u119.nestedEffectMode == "Head" then
                                                    table.insert(u160, v170)
                                                end
                                            end
                                            v169:Destroy()
                                            table.insert(v161, v162)
                                        end
                                        u150[v162] = v164
                                        u151[v162] = v163
                                    end
                                    local u171
                                    if u119.nestedEffectMode == "Head" and #u160 > 0 then
                                        for _, v172 in u160 do
                                            v172.Parent = u150[1]
                                        end
                                        u171 = 1
                                    else
                                        u171 = nil
                                    end
                                    local v173 = u115
                                    local function v175() --[[ Line: 513 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u8
                                            [2] = u119
                                            [3] = u151
                                            [4] = u157
                                        --]]
                                        if u8 then
                                            for v174 = 1, u119.segments do
                                                u8:free(u151[v174])
                                            end
                                            if u157 then
                                                u157:Destroy()
                                            end
                                        end
                                    end
                                    table.insert(v173, v175)
                                    local u176 = u157 or u114
                                    local u177 = u118.speedStart
                                    local u178 = u119.widthStart
                                    local u179 = u119.lengthStart
                                    local u180 = u119.transparencyStart
                                    local u181 = u119.fillTransparencyStart
                                    local u182 = u40(u135, u119.segments, u149, u119.jaggedness, u119.offsetScale)
                                    local u183 = false
                                    local u184 = 0
                                    local u185 = 0
                                    local u186 = 0
                                    for _, v187 in v161 do
                                        local v188 = u119.nestedEffectMode == "Head" and 1 or v187
                                        local v189 = u142
                                        local v190 = u115.effects.emitNested(u150[v188], u115.depth + 1).Finished
                                        table.insert(v189, v190)
                                    end
                                    local u191 = Vector3.new(0, 0, 0)
                                    local u192 = Vector3.new(0, 0, 0)
                                    local u193 = 0
                                    local u194 = false
                                    local u195 = 0
                                    local u196 = 0
                                    local u197 = 0
                                    local u198 = u119.widthStart
                                    local u199 = u130
                                    local u200 = nil
                                    local u201 = nil
                                    local u202 = nil
                                    local u203 = nil
                                    local u204
                                    if u118.speedStart == u118.speedEnd or u1.getState(u113, "SpeedOverride", nil) then
                                        u204 = nil
                                    else
                                        u204 = u2.fromParams(u1.get(u113, "Speed_Curve", u3.default_bezier), u1.get(u113, "Speed_Duration", 0.1), function(p205, p206) --[[ Line: 578 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u177
                                                [2] = u3
                                                [3] = u118
                                            --]]
                                            u177 = u3.lerp(u118.speedStart, u118.speedEnd, p205)
                                            return p206
                                        end)
                                        local v207 = u115
                                        table.insert(v207, u204)
                                    end
                                    local function v208() --[[ Line: 587 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u1
                                            [2] = u113
                                            [3] = u177
                                        --]]
                                        return u1.getState(u113, "SpeedOverride", u177)
                                    end
                                    local function u213() --[[ Line: 631 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u201
                                            [2] = u202
                                            [3] = u200
                                            [4] = u203
                                            [5] = u182
                                            [6] = u101
                                            [7] = u135
                                            [8] = u119
                                            [9] = u149
                                            [10] = u63
                                            [11] = u40
                                        --]]
                                        if u201 and (u202 and u200) then
                                            if u203 then
                                                local v209 = u203
                                                if v209.distanceTraveled < v209.boltLength + v209.transitionBuffer then
                                                    local v210 = u203
                                                    local v211, v212 = u101(u135, u119.segments, u149, u202, u201, u119.jaggedness, u119.offsetScale, u200, u203)
                                                    u182 = v211
                                                    v210.jaggedOffsets = v212
                                                    return
                                                end
                                            end
                                            u182 = u63(u135, u119.segments, u202, u201, u119.jaggedness, u119.offsetScale, u200)
                                            if u203 then
                                                u203.jaggedOffsets = nil
                                                return
                                            end
                                        else
                                            u182 = u40(u135, u119.segments, u149, u119.jaggedness, u119.offsetScale)
                                        end
                                    end
                                    local function u221(p214) --[[ Line: 666 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u203
                                            [2] = u182
                                            [3] = u112
                                            [4] = u119
                                            [5] = u149
                                            [6] = u202
                                            [7] = u201
                                            [8] = u101
                                            [9] = u135
                                            [10] = u200
                                            [11] = u118
                                        --]]
                                        if u203 then
                                            local v215 = u203
                                            if v215.distanceTraveled < v215.boltLength + v215.transitionBuffer then
                                                if u203.jaggedOffsets then
                                                    u182 = u112(u119.segments, u149, u202, u201, u203)
                                                else
                                                    local v216 = u203
                                                    local v217, v218 = u101(u135, u119.segments, u149, u202, u201, u119.jaggedness, u119.offsetScale, u200, u203)
                                                    u182 = v217
                                                    v216.jaggedOffsets = v218
                                                end
                                            end
                                        end
                                        local v219 = u200 * u118.projectileSpeed * p214
                                        for v220 = 1, #u182 do
                                            u182[v220] = u182[v220] + v219
                                        end
                                    end
                                    local function u260(p222, p223, p224, p225, p226) --[[ Line: 700 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u195
                                            [2] = u179
                                            [3] = u178
                                            [4] = u119
                                            [5] = u185
                                            [6] = u213
                                            [7] = u152
                                            [8] = u154
                                            [9] = u150
                                            [10] = u180
                                            [11] = u4
                                            [12] = u186
                                            [13] = u137
                                            [14] = u193
                                            [15] = u139
                                            [16] = u3
                                            [17] = u194
                                            [18] = u196
                                            [19] = u140
                                            [20] = u182
                                            [21] = u158
                                            [22] = u184
                                            [23] = u138
                                            [24] = u181
                                            [25] = u171
                                            [26] = u160
                                            [27] = u149
                                            [28] = u191
                                            [29] = u192
                                        --]]
                                        local v227 = os.clock()
                                        u195 = p222
                                        if not p223 then
                                            local v228 = p222 - u179
                                            p223 = math.max(0, v228)
                                        end
                                        local v229 = p226 or u178
                                        if p225 ~= false and u119.refreshRate > 0 then
                                            local v230 = 1 / u119.refreshRate
                                            u185 = u185 + p224
                                            if v230 <= u185 then
                                                u213()
                                                u185 = 0
                                            end
                                        end
                                        for v231 = 1, u119.segments do
                                            local v232 = u152[v231]
                                            local v233 = u154[v231]
                                            local v234 = u150[v231]
                                            local v235 = v233.start
                                            local v236 = v233.finish
                                            local v237
                                            if p223 < v236 then
                                                v237 = v235 < p222
                                            else
                                                v237 = false
                                            end
                                            if v237 then
                                                if not v232.wasVisible then
                                                    v232.wasVisible = true
                                                    v232.birthTime = v227
                                                    v232.initialWidth = u178
                                                    v232.initialTransparency = u180
                                                end
                                                v234.Color = u4.getColorWithEasingOklab(u119.colorSequence, u186, u137)
                                                local v238
                                                if u119.independentSegments and v232.initialTransparency then
                                                    v238 = v232.initialTransparency
                                                else
                                                    v238 = u180
                                                end
                                                local v239
                                                if u119.fadeInDuration > 0 then
                                                    local v240 = u193 / u119.fadeInDuration
                                                    v239 = math.clamp(v240, 0, 1)
                                                else
                                                    v239 = 1
                                                end
                                                local v241 = 1 - u139:getEase(v239).y
                                                local v242 = u3.lerp(u119.fadeInStart, v238, v241)
                                                local v243
                                                if u194 and u119.fadeOutDuration > 0 then
                                                    local v244 = u196 / u119.fadeOutDuration
                                                    local v245 = 1 - u140:getEase((math.clamp(v244, 0, 1))).y
                                                    v243 = u3.lerp(v238, u119.fadeOutEnd, v245)
                                                else
                                                    v243 = v238
                                                end
                                                if v239 < 1 then
                                                    v238 = v242
                                                elseif u194 then
                                                    v238 = v243
                                                end
                                                v234.Transparency = v238
                                                local v246
                                                if p226 then
                                                    local v247
                                                    if u119.independentSegments and v232.initialWidth then
                                                        v247 = v232.initialWidth
                                                    else
                                                        v247 = u178
                                                    end
                                                    v246 = v247 * (u178 <= 0 and 0 or p226 / u178)
                                                elseif u119.independentSegments and v232.initialWidth then
                                                    v246 = v232.initialWidth
                                                else
                                                    v246 = v229
                                                end
                                                local v248 = u182[v231]
                                                local v249 = u182[v231 + 1]
                                                if v248 and v249 then
                                                    local v250
                                                    if v235 < p223 then
                                                        v250 = v248:Lerp(v249, (p223 - v235) / (v236 - v235))
                                                    else
                                                        v250 = v248
                                                    end
                                                    if p222 < v236 then
                                                        v249 = v248:Lerp(v249, (p222 - v235) / (v236 - v235))
                                                    end
                                                    local v251 = (v250 + v249) / 2
                                                    local v252 = (v249 - v250).Magnitude
                                                    if v252 > 0.001 then
                                                        v234.Size = Vector3.new(v246, v246, v252)
                                                        v234.CFrame = CFrame.lookAt(v251, v249)
                                                    end
                                                end
                                            else
                                                v234.Transparency = 1
                                                if v232.wasVisible then
                                                    v232.wasVisible = false
                                                    v232.birthTime = nil
                                                    v232.initialWidth = nil
                                                    v232.initialTransparency = nil
                                                end
                                            end
                                        end
                                        if u158 then
                                            u158.FillColor = u4.getColorWithEasingOklab(u119.fillColorSequence, u184, u138)
                                            u158.FillTransparency = u181
                                        end
                                        if u171 then
                                            local v253 = u195 * u119.segments
                                            local v254 = math.ceil(v253)
                                            local v255 = u119.segments
                                            local v256 = math.clamp(v254, 1, v255)
                                            if v256 ~= u171 then
                                                local v257 = u150[v256]
                                                for _, v258 in u160 do
                                                    v258.Parent = v257
                                                end
                                                u171 = v256
                                            end
                                        end
                                        local v259 = u149((math.min(p222, 1)))
                                        if p224 > 0 then
                                            u191 = (v259 - u192) / p224
                                        end
                                        u192 = v259
                                    end
                                    u4.createPropertyTween(u115, u113, "Width", u143, u119.widthStart, u119.widthEnd, function(p261) --[[ Line: 860 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u178
                                        --]]
                                        u178 = p261
                                    end, v208, u204)
                                    u4.createPropertyTween(u115, u113, "Transparency", u143, u119.transparencyStart, u119.transparencyEnd, function(p262) --[[ Line: 871 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u180
                                        --]]
                                        u180 = p262
                                    end, v208, u204)
                                    u4.createPropertyTween(u115, u113, "Length", u143, u119.lengthStart, u119.lengthEnd, function(p263) --[[ Line: 885 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u179
                                        --]]
                                        u179 = p263
                                    end, v208, u204)
                                    if v156 then
                                        u4.createPropertyTween(u115, u113, "FillTransparency", u119.fillColorDuration, u119.fillTransparencyStart, u119.fillTransparencyEnd, function(p264) --[[ Line: 900 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u181
                                            --]]
                                            u181 = p264
                                        end, v208, u204)
                                    end
                                    local function u294() --[[ Line: 942 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u194
                                            [2] = u183
                                            [3] = u195
                                            [4] = u159
                                            [5] = u115
                                            [6] = u176
                                            [7] = u146
                                            [8] = u119
                                            [9] = u179
                                            [10] = u178
                                            [11] = u197
                                            [12] = u198
                                            [13] = u2
                                            [14] = u196
                                            [15] = u1
                                            [16] = u113
                                            [17] = u177
                                            [18] = u193
                                            [19] = u186
                                            [20] = u184
                                            [21] = u3
                                            [22] = u260
                                            [23] = u204
                                        --]]
                                        if u194 or u183 then
                                            return
                                        else
                                            local u265 = u195
                                            local u266
                                            if u159 then
                                                u266 = u115.effects.emitOnFinish(u159, u176, u115.depth + 1)
                                            else
                                                u266 = nil
                                            end
                                            local function v267() --[[ Line: 953 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u183
                                                    [2] = u266
                                                    [3] = u146
                                                --]]
                                                if u183 then
                                                    return
                                                else
                                                    u183 = true
                                                    if u266 then
                                                        u266.Finished:finally(function() --[[ Line: 961 ]]
                                                            --[[
                                                            Upvalues:
                                                                [1] = u146
                                                            --]]
                                                            u146()
                                                        end)
                                                    else
                                                        u146()
                                                    end
                                                end
                                            end
                                            if u119.dissipateMode == "None" then
                                                if u119.fadeOutDuration > 0 then
                                                    local v268 = u265 - u179
                                                    local v269 = math.max(0, v268)
                                                    local v270 = u178
                                                    local v271 = u119.fadeOutCurveData
                                                    local v272 = u119.fadeOutDuration
                                                    u194 = true
                                                    u197 = v269
                                                    u198 = v270
                                                    local u273 = "None"
                                                    u2.fromParams(v271, v272, function(p274, p275, p276) --[[ Line: 922 ]]
                                                        --[[
                                                        Upvalues:
                                                            [1] = u196
                                                            [2] = u1
                                                            [3] = u113
                                                            [4] = u177
                                                            [5] = u193
                                                            [6] = u119
                                                            [7] = u186
                                                            [8] = u184
                                                            [9] = u273
                                                            [10] = u3
                                                            [11] = u197
                                                            [12] = u265
                                                            [13] = u198
                                                            [14] = u260
                                                        --]]
                                                        u196 = p276
                                                        local v277 = p275 * u1.getState(u113, "SpeedOverride", u177)
                                                        u193 = u193 + v277
                                                        if u119.refreshDuringDissipate then
                                                            u186 = (u186 + v277 / u119.colorDuration) % 1
                                                            u184 = (u184 + v277 / u119.fillColorDuration) % 1
                                                        end
                                                        local v278
                                                        if u273 == "Retract" then
                                                            v278 = u3.lerp(u197, u265, p274)
                                                        else
                                                            v278 = nil
                                                        end
                                                        local v279
                                                        if u273 == "Scale" then
                                                            v279 = u3.lerp(u198, 0, p274)
                                                        else
                                                            v279 = nil
                                                        end
                                                        u260(u265, v278, v277, u119.refreshDuringDissipate, v279)
                                                        local v280 = u1.getState(u113, "SpeedOverride", u177)
                                                        u177 = v280
                                                        if v280 > 0 then
                                                            return p275 * v280
                                                        else
                                                            return p275 * v280
                                                        end
                                                    end, u204, v267, true, u3.RENDER_PRIORITY + u115.depth)
                                                    return
                                                elseif u183 then
                                                    return
                                                else
                                                    u183 = true
                                                    if u266 then
                                                        u266.Finished:finally(function() --[[ Line: 961 ]]
                                                            --[[
                                                            Upvalues:
                                                                [1] = u146
                                                            --]]
                                                            u146()
                                                        end)
                                                    else
                                                        u146()
                                                    end
                                                end
                                            else
                                                local v281 = u265 - u179
                                                local v282 = math.max(0, v281)
                                                local v283 = u178
                                                local v284 = u119.dissipateCurveData
                                                local v285 = u119.dissipateDuration
                                                local u286 = u119.dissipateMode
                                                u194 = true
                                                u197 = v282
                                                u198 = v283
                                                u2.fromParams(v284, v285, function(p287, p288, p289) --[[ Line: 922 ]]
                                                    --[[
                                                    Upvalues:
                                                        [1] = u196
                                                        [2] = u1
                                                        [3] = u113
                                                        [4] = u177
                                                        [5] = u193
                                                        [6] = u119
                                                        [7] = u186
                                                        [8] = u184
                                                        [9] = u286
                                                        [10] = u3
                                                        [11] = u197
                                                        [12] = u265
                                                        [13] = u198
                                                        [14] = u260
                                                    --]]
                                                    u196 = p289
                                                    local v290 = p288 * u1.getState(u113, "SpeedOverride", u177)
                                                    u193 = u193 + v290
                                                    if u119.refreshDuringDissipate then
                                                        u186 = (u186 + v290 / u119.colorDuration) % 1
                                                        u184 = (u184 + v290 / u119.fillColorDuration) % 1
                                                    end
                                                    local v291
                                                    if u286 == "Retract" then
                                                        v291 = u3.lerp(u197, u265, p287)
                                                    else
                                                        v291 = nil
                                                    end
                                                    local v292
                                                    if u286 == "Scale" then
                                                        v292 = u3.lerp(u198, 0, p287)
                                                    else
                                                        v292 = nil
                                                    end
                                                    u260(u265, v291, v290, u119.refreshDuringDissipate, v292)
                                                    local v293 = u1.getState(u113, "SpeedOverride", u177)
                                                    u177 = v293
                                                    if v293 > 0 then
                                                        return p288 * v293
                                                    else
                                                        return p288 * v293
                                                    end
                                                end, u204, v267, true, u3.RENDER_PRIORITY + u115.depth)
                                                return
                                            end
                                        end
                                    end
                                    local v295 = u115
                                    local v296 = u2.fromParams
                                    local v297 = u1.get(u113, "Easing_Curve", u3.linear_bezier)
                                    local v298 = u143
                                    local function v314(p299, p300, _) --[[ Line: 1000 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u1
                                            [2] = u113
                                            [3] = u177
                                            [4] = u193
                                            [5] = u186
                                            [6] = u119
                                            [7] = u184
                                            [8] = u118
                                            [9] = u3
                                            [10] = u129
                                            [11] = u199
                                            [12] = u182
                                            [13] = u260
                                            [14] = u150
                                            [15] = u195
                                            [16] = u141
                                            [17] = u294
                                            [18] = u204
                                            [19] = u143
                                            [20] = u144
                                        --]]
                                        local v301 = p300 * u1.getState(u113, "SpeedOverride", u177)
                                        u193 = u193 + v301
                                        u186 = (u186 + v301 / u119.colorDuration) % 1
                                        u184 = (u184 + v301 / u119.fillColorDuration) % 1
                                        if u118.syncPosition then
                                            local v302 = u3.getTransformedOriginExtents(u129)
                                            local v303 = v302 * u199:Inverse()
                                            for v304 = 1, #u182 do
                                                u182[v304] = v303:PointToWorldSpace(u199:PointToObjectSpace(u182[v304]))
                                            end
                                            u199 = v302
                                        end
                                        u260(p299, nil, v301)
                                        local v305
                                        if u118.hitboxEnabled then
                                            local v306 = u150
                                            local v307 = u195 * u119.segments
                                            local v308 = math.ceil(v307)
                                            local v309 = u119.segments
                                            local v310 = v306[math.clamp(v308, 1, v309)]
                                            v305 = v310 and (v310.Transparency < 1 and workspace:GetPartsInPart(v310, u141)[1]) and true or false
                                        else
                                            v305 = false
                                        end
                                        if v305 then
                                            u294()
                                            return nil
                                        end
                                        local v311 = u1.getState(u113, "SpeedOverride", u177)
                                        u177 = v311
                                        local v312
                                        if v311 > 0 then
                                            v312 = p300 * v311
                                        else
                                            local v313
                                            if u204 then
                                                v313 = u204.Connected
                                            else
                                                v313 = u1.getState(u113, "SpeedTweening", false)
                                            end
                                            if v313 then
                                                v312 = p300 * v311
                                            else
                                                v312 = nil
                                            end
                                        end
                                        if v312 == nil then
                                            return nil
                                        end
                                        if u118.projectileEnabled and p299 * u143 < u144 or not u118.projectileEnabled then
                                            return v312
                                        end
                                        u294()
                                        return nil
                                    end
                                    local v315 = u204
                                    local function v352() --[[ Line: 1040 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u194
                                            [2] = u183
                                            [3] = u118
                                            [4] = u2
                                            [5] = u3
                                            [6] = u1
                                            [7] = u113
                                            [8] = u177
                                            [9] = u193
                                            [10] = u186
                                            [11] = u119
                                            [12] = u184
                                            [13] = u260
                                            [14] = u150
                                            [15] = u195
                                            [16] = u141
                                            [17] = u294
                                            [18] = u204
                                            [19] = u115
                                            [20] = u132
                                            [21] = u191
                                            [22] = u149
                                            [23] = u179
                                            [24] = u182
                                            [25] = u203
                                            [26] = u144
                                            [27] = u201
                                            [28] = u202
                                            [29] = u200
                                            [30] = u185
                                            [31] = u213
                                            [32] = u221
                                        --]]
                                        if u194 or u183 then
                                            return
                                        elseif u118.projectileEnabled then
                                            local v316
                                            if u118.projectileMatchEnd and u132 then
                                                v316 = u132.WorldCFrame.LookVector
                                            else
                                                v316 = u191.Unit
                                            end
                                            local u317 = (v316 ~= v316 or v316.Magnitude < 0.001) and Vector3.new(0, 0, 1) or v316.Unit
                                            local u318 = u149(1)
                                            local v319 = u149
                                            local v320 = 1 - u179
                                            local u321 = (u318 - v319((math.max(0, v320)))).Magnitude
                                            local v322 = 1 - u179
                                            local v323 = math.max(0, v322)
                                            local v324 = 1 - v323
                                            local v325 = u321 * 0.3
                                            local v326 = table.create(u119.segments + 1)
                                            for v327 = 0, u119.segments do
                                                local v328 = u149(v323 + v327 / u119.segments * v324)
                                                v326[v327 + 1] = u182[v327 + 1] - v328
                                            end
                                            local u329 = {
                                                ["curvedTailT"] = v323,
                                                ["curvedLengthT"] = v324,
                                                ["boltLength"] = u321,
                                                ["transitionBuffer"] = v325,
                                                ["distanceTraveled"] = 0,
                                                ["jaggedOffsets"] = v326
                                            }
                                            u203 = u329
                                            u2.timer(u144, function(p330, p331) --[[ Line: 1124 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u1
                                                    [2] = u113
                                                    [3] = u177
                                                    [4] = u193
                                                    [5] = u186
                                                    [6] = u119
                                                    [7] = u184
                                                    [8] = u118
                                                    [9] = u329
                                                    [10] = u318
                                                    [11] = u317
                                                    [12] = u321
                                                    [13] = u201
                                                    [14] = u202
                                                    [15] = u200
                                                    [16] = u185
                                                    [17] = u213
                                                    [18] = u221
                                                    [19] = u260
                                                    [20] = u150
                                                    [21] = u195
                                                    [22] = u141
                                                    [23] = u294
                                                    [24] = u144
                                                --]]
                                                local v332 = p330 * u1.getState(u113, "SpeedOverride", u177)
                                                u193 = u193 + v332
                                                u186 = (u186 + v332 / u119.colorDuration) % 1
                                                u184 = (u184 + v332 / u119.fillColorDuration) % 1
                                                local v333 = p331 * u118.projectileSpeed
                                                u329.distanceTraveled = v333
                                                local v334 = u318 + u317 * v333
                                                local v335 = v334 - u317 * u321
                                                u201 = v334
                                                u202 = v335
                                                u200 = u317
                                                if u119.refreshRate > 0 then
                                                    u185 = u185 + v332
                                                    if u185 >= 1 / u119.refreshRate then
                                                        u213()
                                                        u185 = 0
                                                    else
                                                        u221(p330)
                                                    end
                                                else
                                                    u221(p330)
                                                end
                                                u260(1, nil, v332, false)
                                                local v336
                                                if u118.hitboxEnabled then
                                                    local v337 = u150
                                                    local v338 = u195 * u119.segments
                                                    local v339 = math.ceil(v338)
                                                    local v340 = u119.segments
                                                    local v341 = v337[math.clamp(v339, 1, v340)]
                                                    v336 = v341 and (v341.Transparency < 1 and workspace:GetPartsInPart(v341, u141)[1]) and true or false
                                                else
                                                    v336 = false
                                                end
                                                if v336 then
                                                    u294()
                                                    return nil
                                                elseif u144 <= p331 then
                                                    return nil
                                                else
                                                    local v342 = u1.getState(u113, "SpeedOverride", u177)
                                                    u177 = v342
                                                    if v342 > 0 then
                                                        return p330 * v342
                                                    else
                                                        return p330 * v342
                                                    end
                                                end
                                            end, u204, u115, u3.RENDER_PRIORITY + u115.depth)
                                            u294()
                                            return
                                        elseif u118.destroyDelay > 0 then
                                            u2.fromParams(u3.linear_bezier, u118.destroyDelay, function(_, p343) --[[ Line: 1051 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u1
                                                    [2] = u113
                                                    [3] = u177
                                                    [4] = u193
                                                    [5] = u186
                                                    [6] = u119
                                                    [7] = u184
                                                    [8] = u260
                                                    [9] = u118
                                                    [10] = u150
                                                    [11] = u195
                                                    [12] = u141
                                                    [13] = u294
                                                --]]
                                                local v344 = p343 * u1.getState(u113, "SpeedOverride", u177)
                                                u193 = u193 + v344
                                                u186 = (u186 + v344 / u119.colorDuration) % 1
                                                u184 = (u184 + v344 / u119.fillColorDuration) % 1
                                                u260(1, nil, v344, true)
                                                local v345
                                                if u118.hitboxEnabled then
                                                    local v346 = u150
                                                    local v347 = u195 * u119.segments
                                                    local v348 = math.ceil(v347)
                                                    local v349 = u119.segments
                                                    local v350 = v346[math.clamp(v348, 1, v349)]
                                                    v345 = v350 and (v350.Transparency < 1 and workspace:GetPartsInPart(v350, u141)[1]) and true or false
                                                else
                                                    v345 = false
                                                end
                                                if v345 then
                                                    u294()
                                                    return nil
                                                else
                                                    local v351 = u1.getState(u113, "SpeedOverride", u177)
                                                    u177 = v351
                                                    if v351 > 0 then
                                                        return p343 * v351
                                                    else
                                                        return p343 * v351
                                                    end
                                                end
                                            end, u204, function() --[[ Line: 1068 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u294
                                                --]]
                                                u294()
                                            end, true, u3.RENDER_PRIORITY + u115.depth)
                                        else
                                            u294()
                                        end
                                    end
                                    local v353 = u3.RENDER_PRIORITY + u115.depth
                                    table.insert(v295, v296(v297, v298, v314, v315, v352, true, v353))
                                else
                                    u146()
                                end
                            end
                            table.insert(u142, v145(v354))
                        end
                        u6.all(u142):await()
                    end
                else
                    return
                end
            end
        else
            return
        end
    else
        return
    end
end
return v7