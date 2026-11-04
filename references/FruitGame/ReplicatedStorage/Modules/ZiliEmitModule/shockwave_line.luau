 

local u1 = game:GetService("CollectionService")
local u2 = require("./mod/tween")
local u3 = require("./mod/logger")
local u4 = require("./mod/utility")
local u5 = require("./obj/Bezier")
require("./obj/ObjectCache")
local u6 = require(script.Parent.obj.Promise)
local u7 = Random.new()
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
function v8.emit(u11, u12, u13) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u4
        [3] = u1
        [4] = u2
        [5] = u3
        [6] = u5
        [7] = u7
        [8] = u6
    --]]
    if u9 then
        local u14 = u4.getAttribute(u11, "RayDirection", Vector3.new(0, -50, 0))
        local v15 = u4.getAttribute(u11, "RayCollisionGroup", "Default")
        local v16 = u4.getAttribute(u11, "FilterTag", "")
        local v17 = u4.getAttribute(u11, "FilterType", "Exclude")
        local v18 = u4.getAttribute(u11, "IgnoreWater", true)
        local v19 = u4.getAttribute(u11, "IgnoreCanCollide", false)
        local u20 = RaycastParams.new()
        u20.CollisionGroup = v15
        u20.IgnoreWater = v18
        u20.RespectCanCollide = not v19
        u20.FilterType = Enum.RaycastFilterType[v17]
        u20.FilterDescendantsInstances = u1:GetTagged(v16)
        if v17 == "Exclude" then
            u20:AddToFilter({ workspace.Terrain })
        end
        local v21 = u4.getAttribute(u12, "EmitDelay", 0)
        local u22 = u4.getAttribute(u12, "Rate_Start", 30)
        local u23 = u4.getAttribute(u12, "Rate_End", 30)
        local v24 = u4.getAttribute(u12, "FixedAmount", 0)
        local u25 = u4.getAttribute(u12, "Scale_Start", 1)
        local u26 = u4.getAttribute(u12, "Scale_End", 1)
        local v27 = u4.getAttribute(u12, "Duration", 1)
        local v28 = u4.getAttribute(u12, "Direction", Vector3.new(0, 0, -1))
        local u29 = u4.getAttribute(u12, "Length", 50)
        local u30 = u4.getRangeAttribute(u12, "Rotation", NumberRange.new(-180, 180))
        local v31 = u4.getAttribute(u12, "PartOffset", Vector3.new(0, 0, 0), true)
        local u32 = u4.getAttribute(u12, "BaseOffset", v31)
        local u33 = u4.getAttribute(u12, "Offset_Start", v31)
        local u34 = u4.getAttribute(u12, "Offset_End", v31)
        local u35 = u4.getAttribute(u12, "Offset_Start_Duration", 0.5)
        local u36 = u4.getAttribute(u12, "Offset_End_Duration", 0.5)
        local u37 = u4.getRangeAttribute(u12, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
        local u38 = u4.getAttribute(u12, "SizeScaleStart", Vector3.new(0, 0, 0))
        local u39 = u4.getAttribute(u12, "SizeScaleEnd", Vector3.new(0, 0, 0))
        local u40 = u4.getAttribute(u12, "MinSize", Vector3.new(2, 1, 2))
        local u41 = u4.getAttribute(u12, "MaxSize", Vector3.new(3, 2, 3))
        local v42 = u4.getAttribute(u12, "Size_Curve", u4.default_bezier, true)
        local v43 = u4.getAttribute(u12, "Size_Duration", 0.5, true)
        local u44 = u4.getAttribute(u12, "Size_Start_Curve", v42)
        local u45 = u4.getAttribute(u12, "Size_End_Curve", v42)
        local u46 = u4.getAttribute(u12, "Size_Start_Duration", v43)
        local u47 = u4.getAttribute(u12, "Size_End_Duration", v43)
        local u48 = u4.getAttribute(u12, "Transparency_Duration", 0.5)
        local u49 = u4.getAttribute(u12, "Transparency_Start", 0)
        local u50 = u4.getAttribute(u12, "Transparency_End", 0)
        local u51 = u4.getAttribute(u12, "SyncPosition", false)
        local u52 = math.max(v27, 0.001)
        if v24 > 0 then
            u23 = v24 / u52
            u22 = u23
        end
        local v53 = v28.Unit
        local u54 = v53 ~= v53 and Vector3.new(-0, -0, -1) or v53
        task.wait(v21)
        local u55 = {}
        local u56 = u11.WorldCFrame
        local u57 = 0
        local u58 = 0
        local u59 = u25
        if u25 ~= u26 then
            local v60 = u2.fromParams
            local v61 = u4.getAttribute(u12, "Scale_Curve", u4.default_bezier)
            local function v64(p62, p63) --[[ Line: 133 ]]
                --[[
                Upvalues:
                    [1] = u59
                    [2] = u4
                    [3] = u25
                    [4] = u26
                --]]
                u59 = u4.lerp(u25, u26, p62)
                return p63
            end
            table.insert(u13, v60(v61, u52, v64))
        end
        if u22 ~= u23 then
            local v65 = u2.fromParams
            local v66 = u4.getAttribute(u12, "Rate_Curve", u4.default_bezier)
            local function v69(p67, p68) --[[ Line: 147 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u4
                    [3] = u22
                    [4] = u23
                --]]
                u22 = u4.lerp(u22, u23, p67)
                return p68
            end
            table.insert(u13, v65(v66, u52, v69))
        end
        local u70 = u4.getAttribute(u12, "Path_Curve", u4.linear_bezier)
        local v71, v72 = pcall(function() --[[ Line: 157 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u70
            --]]
            return u4.deserializePath(u70)
        end)
        if not v71 then
            u3.error((("failed to decode bezier path data with error: %*"):format(v72)))
        end
        local u73 = u5.new(v72, 0)
        local v74 = u2.fromParams
        local v75 = u4.linear_bezier
        local function v135(_, p76) --[[ Line: 169 ]]
            --[[
            Upvalues:
                [1] = u57
                [2] = u22
                [3] = u52
                [4] = u58
                [5] = u73
                [6] = u51
                [7] = u56
                [8] = u11
                [9] = u54
                [10] = u29
                [11] = u14
                [12] = u20
                [13] = u7
                [14] = u40
                [15] = u41
                [16] = u4
                [17] = u9
                [18] = u12
                [19] = u13
                [20] = u49
                [21] = u30
                [22] = u33
                [23] = u32
                [24] = u2
                [25] = u35
                [26] = u59
                [27] = u38
                [28] = u44
                [29] = u46
                [30] = u55
                [31] = u37
                [32] = u39
                [33] = u45
                [34] = u47
                [35] = u34
                [36] = u36
                [37] = u50
                [38] = u48
            --]]
            u57 = u57 + p76
            local v77 = 1 / u22
            local v78 = u52 * u22
            if u57 < v77 or v78 <= u58 then
                return p76
            end
            for _ = 1, u57 // v77 do
                if v78 > u58 then
                    u58 = u58 + 1
                    local v79 = u58 / v78
                    local v80 = 1 - u73:getEase((math.clamp(v79, 0, 1))).y
                    if u51 then
                        u56 = u11.WorldCFrame
                    end
                    local v81 = workspace:Raycast(u56.Position + u56:VectorToWorldSpace(u54) * u29 * v80, u11.WorldCFrame:VectorToWorldSpace(u14), u20)
                    if not v81 then
                        u57 = 0
                        return p76
                    end
                    local v82 = u7:NextNumber(u40.X, u41.X)
                    local v83 = u7:NextNumber(u40.Y, u41.Y)
                    local v84 = u7:NextNumber(u40.Z, u41.Z)
                    local u85 = u4.getRanomId()
                    local u86 = u9:get(u85)
                    local v87 = u86._getReal()
                    u4.copyProperties(u12, v87, u4.COPY_PART_PROPERTIES)
                    u4.copyProperties(u12, v87, u4.COPY_EXTENDED_PART_PROPERTIES)
                    if #u12:GetChildren() ~= 0 then
                        local v88 = u12:Clone()
                        for _, v89 in v88:GetChildren() do
                            v89.Parent = v87
                        end
                        v88:Destroy()
                    end
                    local v90 = u13
                    local function v91() --[[ Line: 230 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u85
                        --]]
                        if u9 then
                            u9:free(u85)
                        end
                    end
                    table.insert(v90, v91)
                    u86.Color = v81.Instance.Color
                    u86.Material = v81.Material
                    u86.Transparency = v81.Instance.Transparency
                    if u86.Transparency == 0 then
                        u86.Transparency = u49
                    end
                    u86.Size = Vector3.new(0, 0, 0)
                    local v92 = u7:NextNumber(u30.Min, u30.Max)
                    local v93 = -math.cos(v92)
                    local v94 = -math.sin(v92)
                    local v95 = u11.WorldCFrame:VectorToWorldSpace((Vector3.new(v93, 0, v94))):Cross(v81.Normal).Unit
                    local v96 = CFrame.fromMatrix(v81.Position, v95, v81.Normal)
                    local v97 = CFrame.fromOrientation
                    local v98 = v83 / v84
                    local u99 = v96 * v97(-math.atan(v98), 0, 0)
                    u86.CFrame = CFrame.new(u33) * u99
                    local u100 = nil
                    local u101 = Vector3.new(0, 0, 0)
                    local u102
                    if u33 == u32 then
                        u102 = nil
                    else
                        u102 = u2.fromParams(u4.getAttribute(u12, "Offset_Start_Curve", u4.default_bezier), u35, function(p103, p104) --[[ Line: 268 ]]
                            --[[
                            Upvalues:
                                [1] = u101
                                [2] = u33
                                [3] = u32
                                [4] = u86
                                [5] = u99
                            --]]
                            u101 = u33:Lerp(u32, p103)
                            u86.CFrame = CFrame.new(u101) * u99
                            return p104
                        end)
                        local v105 = u13
                        table.insert(v105, u102)
                    end
                    local u106 = Vector3.new(v82, v83, v84) * u59
                    if u106 * u38 == u106 then
                        u86.Size = u106 * u38
                    else
                        u100 = u2.fromParams(u44, u46, function(p107, p108) --[[ Line: 281 ]]
                            --[[
                            Upvalues:
                                [1] = u86
                                [2] = u106
                                [3] = u38
                            --]]
                            u86.Size = (u106 * u38):Lerp(u106, p107)
                            return p108
                        end)
                        local v109 = u13
                        table.insert(v109, u100)
                    end
                    if shared.vfx and #u86:GetChildren() ~= 0 then
                        local v110 = u55
                        local v111 = shared.vfx.emit(v87).Finished
                        table.insert(v110, v111)
                    end
                    task.delay(u7:NextNumber(u37.Min, u37.Max), function() --[[ Line: 296 ]]
                        --[[
                        Upvalues:
                            [1] = u100
                            [2] = u102
                            [3] = u86
                            [4] = u106
                            [5] = u39
                            [6] = u13
                            [7] = u2
                            [8] = u45
                            [9] = u47
                            [10] = u101
                            [11] = u34
                            [12] = u4
                            [13] = u12
                            [14] = u36
                            [15] = u99
                            [16] = u50
                            [17] = u48
                        --]]
                        if u100 then
                            u100:Disconnect()
                        end
                        if u102 then
                            u102:Disconnect()
                        end
                        local u112 = u86.Size
                        local u113 = u86.Transparency
                        if u112 ~= u106 * u39 then
                            local v114 = u13
                            local v115 = u2.fromParams
                            local v116 = u45
                            local v117 = u47
                            local function v120(p118, p119) --[[ Line: 311 ]]
                                --[[
                                Upvalues:
                                    [1] = u86
                                    [2] = u112
                                    [3] = u106
                                    [4] = u39
                                --]]
                                u86.Size = u112:Lerp(u106 * u39, p118)
                                return p119
                            end
                            table.insert(v114, v115(v116, v117, v120))
                        end
                        if u101 ~= u34 then
                            local v121 = u13
                            local v122 = u2.fromParams
                            local v123 = u4.getAttribute(u12, "Offset_End_Curve", u4.default_bezier)
                            local v124 = u36
                            local function v127(p125, p126) --[[ Line: 324 ]]
                                --[[
                                Upvalues:
                                    [1] = u86
                                    [2] = u101
                                    [3] = u34
                                    [4] = u99
                                --]]
                                u86.CFrame = CFrame.new(u101:Lerp(u34, p125)) * u99
                                return p126
                            end
                            table.insert(v121, v122(v123, v124, v127))
                        end
                        if u113 == u50 then
                            u86.Transparency = u113
                        else
                            local v128 = u13
                            local v129 = u2.fromParams
                            local v130 = u4.getAttribute(u12, "Transparency_Curve", u4.default_bezier)
                            local v131 = u48
                            local function v134(p132, p133) --[[ Line: 338 ]]
                                --[[
                                Upvalues:
                                    [1] = u86
                                    [2] = u4
                                    [3] = u113
                                    [4] = u50
                                --]]
                                u86.Transparency = u4.lerp(u113, u50, p132)
                                return p133
                            end
                            table.insert(v128, v129(v130, v131, v134))
                        end
                    end)
                end
            end
            u57 = u57 % v77
            return p76
        end
        local v136 = u4.RENDER_PRIORITY + u13.depth
        table.insert(u13, v74(v75, u52, v135, nil, nil, true, v136))
        task.wait(u37.Max + u52 + math.max(u47, u36))
        u6.all(u55):await()
    end
end
return v8