 

local u1 = game:GetService("RunService")
local u2 = require("../mod/attributes")
local u3 = require("../mod/tween")
require("../types")
local u4 = require("../mod/utility")
local u5 = require("../mod/common/bezier")
local u6 = require("../obj/Bezier")
local u7 = require("../pkg/Promise")
require("../obj/ObjectCache")
local v8 = {}
local u9 = nil
function v8.init(p10) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    u9 = p10
end
function v8.deinit() --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    u9 = nil
end
local function u12(p11) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    return {
        ["facePath"] = u2.get(p11, "FacePath", false),
        ["arcSpace"] = u2.get(p11, "ArcSpace", false),
        ["rotSpeedStart"] = u2.getRange(p11, "RotSpeed_Start", NumberRange.new(0, 0)),
        ["rotSpeedEnd"] = u2.getRange(p11, "RotSpeed_End", NumberRange.new(0, 0)),
        ["minInitRot"] = u2.get(p11, "MinInitRot", Vector3.new(0, 0, 0)),
        ["maxInitRot"] = u2.get(p11, "MaxInitRot", Vector3.new(0, 0, 0)),
        ["speedCurve"] = u2.get(p11, "Speed_Curve", u4.default_bezier),
        ["speedDuration"] = u2.get(p11, "Speed_Duration", 0.1),
        ["easingCurve"] = u2.get(p11, "Easing_Curve", u4.linear_bezier)
    }
end
function v8.emit(u13, u14, u15, p16) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u5
        [3] = u12
        [4] = u2
        [5] = u3
        [6] = u4
        [7] = u6
        [8] = u7
        [9] = u1
    --]]
    local v17 = u13:FindFirstChild("Points")
    if v17 and (v17:IsA("Attachment") and u9) then
        local u18 = u5.readCommonAttributes(u13)
        local u19 = u12(u13)
        local u20 = u5.drawFuncMap[u18.shapeType]
        if u20 then
            u20 = u5.drawFuncMap[u18.shapeType][u18.shapeStyle]
        end
        if u20 then
            local v21 = u18.emitDuration > 0
            task.wait(u18.emitDelay)
            if v21 and not p16 then
                u2.trigger(u13, "Enabled", true)
                if u18.speedStart ~= u18.speedEnd then
                    u2.setState(u13, "SpeedTweening", true)
                    local v22 = u3.fromParams
                    local v23 = u19.speedCurve
                    local v24 = u19.speedDuration
                    local function v27(p25, p26) --[[ Line: 77 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u13
                            [3] = u4
                            [4] = u18
                        --]]
                        u2.setState(u13, "SpeedOverride", u4.lerp(u18.speedStart, u18.speedEnd, p25))
                        return p26
                    end
                    local function v28() --[[ Line: 82 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u13
                        --]]
                        u2.setState(u13, "SpeedTweening", nil)
                    end
                    table.insert(u15, v22(v23, v24, v27, nil, v28))
                end
                task.wait(u18.emitDuration)
                u2.trigger(u13, "Enabled", false)
                u2.clearState(u13)
                return
            elseif u18.emitCount <= 0 then
                return
            else
                local u29 = u5.validateParent(u13)
                if u29 then
                    local u30, u31 = u4.getTransformedOriginExtents(u29)
                    if u30 then
                        local u32, u33 = u5.findEndAttachments(u13)
                        local u34 = u4.getBezierPoints(v17)
                        local u35 = Random.new()
                        local u36 = not u32
                        if u36 then
                            u36 = u6.new(u34)
                        end
                        local u37 = u5.createHitboxParams({
                            ["enabled"] = u18.hitboxEnabled,
                            ["collisionGroup"] = u18.hitboxCollisionGroup,
                            ["filterTag"] = u18.hitboxFilterTag,
                            ["filterType"] = u18.hitboxFilterType,
                            ["ignoreCanCollide"] = u18.hitboxIgnoreCanCollide
                        }, u29, v17)
                        local u38 = {}
                        for _ = 1, u18.emitCount do
                            local u39 = u35:NextNumber(u19.rotSpeedStart.Min, u19.rotSpeedStart.Max)
                            local u40 = u35:NextNumber(u19.rotSpeedEnd.Min, u19.rotSpeedEnd.Max)
                            local v41 = u35:NextNumber(u19.minInitRot.x, u19.maxInitRot.x)
                            local v42 = u35:NextNumber(u19.minInitRot.y, u19.maxInitRot.y)
                            local v43 = u19.minInitRot.z
                            local v44 = u19.maxInitRot.z
                            local u45 = vector.create(v41, v42, u35:NextNumber(v43, v44))
                            local u46 = u35:NextNumber(u18.duration.Min, u18.duration.Max)
                            local u47 = u18.projectileEnabled
                            if u47 then
                                u47 = u35:NextNumber(u18.projectileLifetime.Min, u18.projectileLifetime.Max)
                            end
                            local v48 = u7.new
                            local function v114(u49) --[[ Line: 146 ]]
                                --[[
                                Upvalues:
                                    [1] = u5
                                    [2] = u30
                                    [3] = u31
                                    [4] = u18
                                    [5] = u20
                                    [6] = u35
                                    [7] = u32
                                    [8] = u29
                                    [9] = u36
                                    [10] = u34
                                    [11] = u33
                                    [12] = u19
                                    [13] = u4
                                    [14] = u9
                                    [15] = u14
                                    [16] = u15
                                    [17] = u38
                                    [18] = u45
                                    [19] = u39
                                    [20] = u1
                                    [21] = u37
                                    [22] = u2
                                    [23] = u13
                                    [24] = u3
                                    [25] = u46
                                    [26] = u40
                                    [27] = u47
                                --]]
                                local v50 = u5.calculateEmissionCFrame(u30, u31, {
                                    ["face"] = u18.face,
                                    ["spreadAngle"] = u18.spreadAngle,
                                    ["mirror"] = u18.mirror,
                                    ["mirrorRot"] = u18.mirrorRot,
                                    ["partial"] = u18.partial,
                                    ["emissionDirection"] = u18.emissionDirection
                                }, u20, u35, u32, u29:IsA("Attachment"))
                                local v51 = u36 or u5.createBezierWithEndpoint(u34, v50, u32, u33)
                                local u52 = u5.createPosGetter(v51, u34, v50, u32, u19.arcSpace)
                                local u53 = u4.getRandomId()
                                if u9 then
                                    local u54 = u9:get(u53)
                                    u54.CFrame = CFrame.new(u52(0))
                                    local u55 = u54._getReal()
                                    u4.copyProperties(u14, u55, u4.COPY_PART_PROPERTIES)
                                    u4.copyProperties(u14, u55, u4.COPY_EXTENDED_PART_PROPERTIES)
                                    local v56 = u14:Clone()
                                    for _, v57 in v56:GetChildren() do
                                        v57.Parent = u55
                                    end
                                    v56:Destroy()
                                    local u58 = u15.effects.prepareEmitOnFinish(u55, u15)
                                    local v59 = u38
                                    local v60 = u15.effects.emitNested(u55, u15.depth + 1).Finished
                                    table.insert(v59, v60)
                                    local v61 = u15
                                    local function v62() --[[ Line: 191 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u9
                                            [2] = u53
                                        --]]
                                        if u9 then
                                            u9:free(u53)
                                        end
                                    end
                                    table.insert(v61, v62)
                                    local u63 = Vector3.new(0, 0, 0)
                                    local u64 = Vector3.new(0, 0, 0)
                                    local u65 = false
                                    local u66 = false
                                    local u67 = CFrame.identity
                                    local u68 = u18.speedStart
                                    local u69 = CFrame.fromOrientation(u45.x, u45.y, u45.z)
                                    local u70 = u39
                                    local function u77() --[[ Line: 210 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u66
                                            [2] = u18
                                            [3] = u4
                                            [4] = u29
                                            [5] = u54
                                            [6] = u1
                                            [7] = u15
                                            [8] = u58
                                            [9] = u55
                                            [10] = u49
                                        --]]
                                        if not u66 then
                                            if u18.syncPosition then
                                                local u71 = u4.getTransformedOriginExtents(u29)
                                                local u72 = u54.CFrame
                                                local function v73() --[[ Line: 219 ]]
                                                    --[[
                                                    Upvalues:
                                                        [1] = u54
                                                        [2] = u4
                                                        [3] = u29
                                                        [4] = u71
                                                        [5] = u72
                                                    --]]
                                                    u54.CFrame = u4.getTransformedOriginExtents(u29) * u71:ToObjectSpace(u72)
                                                end
                                                local u74 = u4.getRandomId()
                                                u1:BindToRenderStep(u74, u4.RENDER_PRIORITY + u15.depth, v73)
                                                local v75 = u15
                                                local function v76() --[[ Line: 227 ]]
                                                    --[[
                                                    Upvalues:
                                                        [1] = u1
                                                        [2] = u74
                                                    --]]
                                                    u1:UnbindFromRenderStep(u74)
                                                end
                                                table.insert(v75, v76)
                                            end
                                            u66 = true
                                            u15.effects.emitOnFinish(u58, u55, u15.depth + 1).Finished:finally(function() --[[ Line: 235 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u49
                                                --]]
                                                u49()
                                            end)
                                        end
                                    end
                                    local u78
                                    if u18.speedStart == u18.speedEnd or u2.getState(u13, "SpeedOverride", nil) then
                                        u78 = nil
                                    else
                                        u78 = u3.fromParams(u19.speedCurve, u19.speedDuration, function(p79, p80) --[[ Line: 253 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u68
                                                [2] = u4
                                                [3] = u18
                                            --]]
                                            u68 = u4.lerp(u18.speedStart, u18.speedEnd, p79)
                                            return p80
                                        end)
                                        local v81 = u15
                                        table.insert(v81, u78)
                                    end
                                    local function u82() --[[ Line: 261 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u2
                                            [2] = u13
                                            [3] = u68
                                        --]]
                                        return u2.getState(u13, "SpeedOverride", u68)
                                    end
                                    u5.createPropertyTween(u15, u13, "RotSpeed", u46, u39, u40, function(p83) --[[ Line: 270 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u70
                                        --]]
                                        u70 = p83
                                    end, function() --[[ Line: 272 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u82
                                        --]]
                                        return u82()
                                    end, u78)
                                    local v84 = u15
                                    local v85 = u3.fromParams
                                    local v86 = u19.easingCurve
                                    local v87 = u46
                                    local function v101(p88, p89, p90) --[[ Line: 282 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u52
                                            [2] = u19
                                            [3] = u46
                                            [4] = u67
                                            [5] = u45
                                            [6] = u70
                                            [7] = u4
                                            [8] = u69
                                            [9] = u18
                                            [10] = u54
                                            [11] = u29
                                            [12] = u30
                                            [13] = u64
                                            [14] = u63
                                            [15] = u55
                                            [16] = u37
                                            [17] = u77
                                            [18] = u65
                                            [19] = u2
                                            [20] = u13
                                            [21] = u68
                                            [22] = u78
                                            [23] = u47
                                        --]]
                                        local v91 = u52(p88)
                                        local v92 = CFrame.new(v91)
                                        if u19.facePath then
                                            local v93 = u52
                                            local v94 = (p90 + 0.016666666666666666) / u46
                                            local v95 = v93((math.clamp(v94, 0, 1)))
                                            if v91 == v95 then
                                                v92 = v92 * u67.Rotation
                                            else
                                                v92 = CFrame.lookAt(v91, v95)
                                            end
                                        end
                                        local v96 = u45:Sign() * u70 * u4.DEG_TO_RAD * p89
                                        u69 = u69 * CFrame.fromOrientation(v96.x, v96.y, v96.z)
                                        u67 = v92
                                        local v97 = v92 * u69
                                        if u18.syncPosition then
                                            u54.CFrame = u4.getTransformedOriginExtents(u29) * u30:ToObjectSpace(v97)
                                        else
                                            u54.CFrame = v97
                                        end
                                        u64 = (v91 - u63) / p89
                                        u63 = v91
                                        local v98
                                        if u18.hitboxEnabled then
                                            v98 = workspace:GetPartsInPart(u55, u37)[1] ~= nil
                                        else
                                            v98 = false
                                        end
                                        if v98 then
                                            u77()
                                            u65 = true
                                            return nil
                                        end
                                        local v99 = u2.getState(u13, "SpeedOverride", u68)
                                        u68 = v99
                                        if v99 == 0 then
                                            local v100
                                            if u78 then
                                                v100 = u78.Connected
                                            else
                                                v100 = u2.getState(u13, "SpeedTweening", false)
                                            end
                                            if not v100 then
                                                return nil
                                            end
                                        end
                                        if u18.projectileEnabled and p88 * u46 < u47 or not u18.projectileEnabled then
                                            return p89 * v99
                                        end
                                        u77()
                                        return nil
                                    end
                                    local v102 = u78
                                    local function v112(p103) --[[ Line: 333 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u18
                                            [2] = u65
                                            [3] = u77
                                            [4] = u32
                                            [5] = u64
                                            [6] = u55
                                            [7] = u4
                                            [8] = u29
                                            [9] = u3
                                            [10] = u47
                                            [11] = u54
                                            [12] = u37
                                            [13] = u2
                                            [14] = u13
                                            [15] = u68
                                            [16] = u78
                                            [17] = u15
                                        --]]
                                        if u18.projectileEnabled and not u65 then
                                            local v104
                                            if u18.projectileMatchEnd and u32 then
                                                v104 = u32.WorldCFrame.LookVector
                                            else
                                                v104 = u64.Unit
                                            end
                                            u64 = (v104 ~= v104 and Vector3.new(0, 0, 0) or v104) * u18.projectileSpeed
                                            local u105 = u55.Position
                                            local u106 = u4.getTransformedOriginExtents(u29)
                                            u3.timer(u47, function(p107, p108) --[[ Line: 355 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u18
                                                    [2] = u54
                                                    [3] = u4
                                                    [4] = u29
                                                    [5] = u106
                                                    [6] = u105
                                                    [7] = u64
                                                    [8] = u55
                                                    [9] = u37
                                                    [10] = u77
                                                    [11] = u65
                                                    [12] = u2
                                                    [13] = u13
                                                    [14] = u68
                                                    [15] = u78
                                                --]]
                                                if u18.syncPosition then
                                                    u54.CFrame = u4.getTransformedOriginExtents(u29) * u106:ToObjectSpace(CFrame.new(u105 + u64 * p108))
                                                else
                                                    u54.CFrame = CFrame.new(u105 + u64 * p108) * u55.CFrame.Rotation
                                                end
                                                local v109
                                                if u18.hitboxEnabled then
                                                    v109 = workspace:GetPartsInPart(u55, u37)[1] ~= nil
                                                else
                                                    v109 = false
                                                end
                                                if v109 then
                                                    u77()
                                                    u65 = true
                                                    return nil
                                                end
                                                local v110 = u2.getState(u13, "SpeedOverride", u68)
                                                u68 = v110
                                                if v110 > 0 then
                                                    ::l12::
                                                    return p107 * v110
                                                else
                                                    if p108 > 0 then
                                                        local v111
                                                        if u78 then
                                                            v111 = u78.Connected
                                                        else
                                                            v111 = u2.getState(u13, "SpeedTweening", false)
                                                        end
                                                        if v111 then
                                                            goto l12
                                                        end
                                                    end
                                                    return nil
                                                end
                                            end, u78, u15, u4.RENDER_PRIORITY + u15.depth)
                                            if not u65 then
                                                u77()
                                            end
                                        elseif p103 then
                                            u77()
                                        end
                                    end
                                    local v113 = u4.RENDER_PRIORITY + u15.depth
                                    table.insert(v84, v85(v86, v87, v101, v102, v112, true, v113))
                                else
                                    u49()
                                end
                            end
                            table.insert(u38, v48(v114))
                        end
                        u7.all(u38):await()
                        task.wait(u18.destroyDelay)
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
return v8