 

local u1 = game:GetService("CollectionService")
local u2 = require("../mod/attributes")
local u3 = require("../mod/tween")
require("../types")
local u4 = require("../mod/logger")
local u5 = require("../mod/utility")
local u6 = require("../obj/Bezier")
local u7 = require("../pkg/Promise")
require("../obj/ObjectCache")
local u8 = Random.new()
local v9 = {}
local u10 = nil
function v9.init(p11) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10 = p11
end
function v9.deinit() --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10 = nil
end
function v9.emit(u12, u13, u14) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
        [3] = u1
        [4] = u5
        [5] = u3
        [6] = u4
        [7] = u6
        [8] = u8
        [9] = u7
    --]]
    if u10 then
        local u15 = u2.get(u12, "RayDirection", Vector3.new(0, -50, 0))
        local v16 = u2.get(u12, "RayCollisionGroup", "Default")
        local v17 = u2.get(u12, "FilterTag", "")
        local v18 = u2.get(u12, "FilterType", "Exclude")
        local v19 = u2.get(u12, "IgnoreWater", true)
        local v20 = u2.get(u12, "IgnoreCanCollide", false)
        local u21 = RaycastParams.new()
        u21.CollisionGroup = v16
        u21.IgnoreWater = v19
        u21.RespectCanCollide = not v20
        u21.FilterType = Enum.RaycastFilterType[v18]
        u21.FilterDescendantsInstances = u1:GetTagged(v17)
        if v18 == "Exclude" then
            u21:AddToFilter({ workspace.Terrain })
        end
        local v22 = u2.get(u13, "EmitDelay", 0)
        local u23 = u2.get(u13, "Rate_Start", 30)
        local u24 = u2.get(u13, "Rate_End", 30)
        local v25 = u2.get(u13, "FixedAmount", 0)
        local u26 = u2.get(u13, "Scale_Start", 1)
        local u27 = u2.get(u13, "Scale_End", 1)
        local v28 = u2.get(u13, "Duration", 1)
        local v29 = u2.get(u13, "Direction", Vector3.new(0, 0, -1))
        local u30 = u2.get(u13, "Length", 50)
        local u31 = u2.getRange(u13, "Rotation", NumberRange.new(-180, 180))
        local v32 = u2.get(u13, "PartOffset", Vector3.new(0, 0, 0), true)
        local u33 = u2.get(u13, "BaseOffset", v32)
        local u34 = u2.get(u13, "Offset_Start", v32)
        local u35 = u2.get(u13, "Offset_End", v32)
        local u36 = u2.get(u13, "Offset_Start_Duration", 0.5)
        local u37 = u2.get(u13, "Offset_End_Duration", 0.5)
        local u38 = u2.getRange(u13, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
        local u39 = u2.get(u13, "SizeScaleStart", Vector3.new(0, 0, 0))
        local u40 = u2.get(u13, "SizeScaleEnd", Vector3.new(0, 0, 0))
        local u41 = u2.get(u13, "MinSize", Vector3.new(2, 1, 2))
        local u42 = u2.get(u13, "MaxSize", Vector3.new(3, 2, 3))
        local v43 = u2.get(u13, "Size_Curve", u5.default_bezier, true)
        local v44 = u2.get(u13, "Size_Duration", 0.5, true)
        local u45 = u2.get(u13, "Size_Start_Curve", v43)
        local u46 = u2.get(u13, "Size_End_Curve", v43)
        local u47 = u2.get(u13, "Size_Start_Duration", v44)
        local u48 = u2.get(u13, "Size_End_Duration", v44)
        local u49 = u2.get(u13, "Transparency_Duration", 0.5)
        local u50 = u2.get(u13, "Transparency_Start", 0)
        local u51 = u2.get(u13, "Transparency_End", 0)
        local u52 = u2.get(u13, "SyncPosition", false)
        local u53 = math.max(v28, 0.001)
        if v25 > 0 then
            u24 = v25 / u53
            u23 = u24
        end
        local v54 = v29.Unit
        local u55 = v54 ~= v54 and Vector3.new(-0, -0, -1) or v54
        task.wait(v22)
        local u56 = {}
        local u57 = u5.getTransformedOriginExtents(u12)
        local u58 = 0
        local u59 = 0
        local u60 = u26
        if u26 ~= u27 then
            local v61 = u3.fromParams
            local v62 = u2.get(u13, "Scale_Curve", u5.default_bezier)
            local function v65(p63, p64) --[[ Line: 131 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u5
                    [3] = u26
                    [4] = u27
                --]]
                u60 = u5.lerp(u26, u27, p63)
                return p64
            end
            table.insert(u14, v61(v62, u53, v65))
        end
        if u23 ~= u24 then
            local v66 = u3.fromParams
            local v67 = u2.get(u13, "Rate_Curve", u5.default_bezier)
            local function v70(p68, p69) --[[ Line: 141 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u5
                    [3] = u23
                    [4] = u24
                --]]
                u23 = u5.lerp(u23, u24, p68)
                return p69
            end
            table.insert(u14, v66(v67, u53, v70))
        end
        local u71 = u2.get(u13, "Path_Curve", u5.linear_bezier)
        local v72, v73 = pcall(function() --[[ Line: 150 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u71
            --]]
            return u5.deserializePath(u71)
        end)
        if not v72 then
            u4.error((("failed to decode bezier path data with error: %*"):format(v73)))
        end
        local u74 = u6.new(v73, 0)
        local v75 = u3.fromParams
        local v76 = u5.linear_bezier
        local function v140(_, p77) --[[ Line: 162 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u23
                [3] = u53
                [4] = u59
                [5] = u74
                [6] = u52
                [7] = u57
                [8] = u5
                [9] = u12
                [10] = u55
                [11] = u30
                [12] = u15
                [13] = u21
                [14] = u8
                [15] = u41
                [16] = u42
                [17] = u10
                [18] = u13
                [19] = u14
                [20] = u50
                [21] = u31
                [22] = u34
                [23] = u33
                [24] = u3
                [25] = u2
                [26] = u36
                [27] = u60
                [28] = u39
                [29] = u45
                [30] = u47
                [31] = u56
                [32] = u38
                [33] = u40
                [34] = u46
                [35] = u48
                [36] = u35
                [37] = u37
                [38] = u51
                [39] = u49
            --]]
            u58 = u58 + p77
            local v78 = 1 / u23
            local v79 = u53 * u23
            if u58 < v78 or v79 <= u59 then
                return p77
            end
            for _ = 1, u58 // v78 do
                if v79 > u59 then
                    u59 = u59 + 1
                    local v80 = u59 / v79
                    local v81 = 1 - u74:getEase((math.clamp(v80, 0, 1))).y
                    if u52 then
                        u57 = u5.getTransformedOriginExtents(u12)
                    end
                    local v82 = u5.getTransformedOriginExtents(u12)
                    local v83 = workspace:Raycast(u57.Position + u57:VectorToWorldSpace(u55) * u30 * v81, v82:VectorToWorldSpace(u15), u21)
                    if not v83 then
                        u58 = 0
                        return p77
                    end
                    local v84 = u8:NextNumber(u41.X, u42.X)
                    local v85 = u8:NextNumber(u41.Y, u42.Y)
                    local v86 = u8:NextNumber(u41.Z, u42.Z)
                    local u87 = u5.getRandomId()
                    local u88 = u10:get(u87)
                    local u89 = u88._getReal()
                    u5.copyProperties(u13, u89, u5.COPY_PART_PROPERTIES)
                    u5.copyProperties(u13, u89, u5.COPY_EXTENDED_PART_PROPERTIES)
                    if #u13:GetChildren() ~= 0 then
                        local v90 = u13:Clone()
                        for _, v91 in v90:GetChildren() do
                            v91.Parent = u89
                        end
                        v90:Destroy()
                    end
                    local u92 = u14.effects.prepareEmitOnFinish(u89, u14)
                    local v93 = u14
                    local function v94() --[[ Line: 226 ]]
                        --[[
                        Upvalues:
                            [1] = u10
                            [2] = u87
                        --]]
                        if u10 then
                            u10:free(u87)
                        end
                    end
                    table.insert(v93, v94)
                    u88.Color = v83.Instance.Color
                    u88.Material = v83.Material
                    u88.Transparency = v83.Instance.Transparency
                    if u88.Transparency == 0 then
                        u88.Transparency = u50
                    end
                    u88.Size = Vector3.new(0, 0, 0)
                    local v95 = u8:NextNumber(u31.Min, u31.Max)
                    local v96 = -math.cos(v95)
                    local v97 = -math.sin(v95)
                    local v98 = v82:VectorToWorldSpace((Vector3.new(v96, 0, v97))):Cross(v83.Normal).Unit
                    local v99 = CFrame.fromMatrix(v83.Position, v98, v83.Normal)
                    local v100 = CFrame.fromOrientation
                    local v101 = v85 / v86
                    local u102 = v99 * v100(-math.atan(v101), 0, 0)
                    u88.CFrame = CFrame.new(u34) * u102
                    local u103 = nil
                    local u104 = Vector3.new(0, 0, 0)
                    local u105
                    if u34 == u33 then
                        u105 = nil
                    else
                        u105 = u3.fromParams(u2.get(u13, "Offset_Start_Curve", u5.default_bezier), u36, function(p106, p107) --[[ Line: 264 ]]
                            --[[
                            Upvalues:
                                [1] = u104
                                [2] = u34
                                [3] = u33
                                [4] = u88
                                [5] = u102
                            --]]
                            u104 = u34:Lerp(u33, p106)
                            u88.CFrame = CFrame.new(u104) * u102
                            return p107
                        end)
                        local v108 = u14
                        table.insert(v108, u105)
                    end
                    local u109 = Vector3.new(v84, v85, v86) * u60
                    if u109 * u39 == u109 then
                        u88.Size = u109 * u39
                    else
                        u103 = u3.fromParams(u45, u47, function(p110, p111) --[[ Line: 277 ]]
                            --[[
                            Upvalues:
                                [1] = u88
                                [2] = u109
                                [3] = u39
                            --]]
                            u88.Size = (u109 * u39):Lerp(u109, p110)
                            return p111
                        end)
                        local v112 = u14
                        table.insert(v112, u103)
                    end
                    local v113 = u56
                    local v114 = u14.effects.emitNested(u89, u14.depth + 1).Finished
                    table.insert(v113, v114)
                    task.delay(u8:NextNumber(u38.Min, u38.Max), function() --[[ Line: 290 ]]
                        --[[
                        Upvalues:
                            [1] = u103
                            [2] = u105
                            [3] = u88
                            [4] = u109
                            [5] = u40
                            [6] = u14
                            [7] = u3
                            [8] = u46
                            [9] = u48
                            [10] = u104
                            [11] = u35
                            [12] = u2
                            [13] = u13
                            [14] = u5
                            [15] = u37
                            [16] = u102
                            [17] = u51
                            [18] = u49
                            [19] = u92
                            [20] = u89
                            [21] = u56
                        --]]
                        if u103 then
                            u103:Disconnect()
                        end
                        if u105 then
                            u105:Disconnect()
                        end
                        local u115 = u88.Size
                        local u116 = u88.Transparency
                        if u115 ~= u109 * u40 then
                            local v117 = u14
                            local v118 = u3.fromParams
                            local v119 = u46
                            local v120 = u48
                            local function v123(p121, p122) --[[ Line: 305 ]]
                                --[[
                                Upvalues:
                                    [1] = u88
                                    [2] = u115
                                    [3] = u109
                                    [4] = u40
                                --]]
                                u88.Size = u115:Lerp(u109 * u40, p121)
                                return p122
                            end
                            table.insert(v117, v118(v119, v120, v123))
                        end
                        if u104 ~= u35 then
                            local v124 = u14
                            local v125 = u3.fromParams
                            local v126 = u2.get(u13, "Offset_End_Curve", u5.default_bezier)
                            local v127 = u37
                            local function v130(p128, p129) --[[ Line: 318 ]]
                                --[[
                                Upvalues:
                                    [1] = u88
                                    [2] = u104
                                    [3] = u35
                                    [4] = u102
                                --]]
                                u88.CFrame = CFrame.new(u104:Lerp(u35, p128)) * u102
                                return p129
                            end
                            table.insert(v124, v125(v126, v127, v130))
                        end
                        if u116 ~= u51 then
                            local v131 = u14
                            local v132 = u3.fromParams
                            local v133 = u2.get(u13, "Transparency_Curve", u5.default_bezier)
                            local v134 = u49
                            local function v137(p135, p136) --[[ Line: 332 ]]
                                --[[
                                Upvalues:
                                    [1] = u88
                                    [2] = u5
                                    [3] = u116
                                    [4] = u51
                                --]]
                                u88.Transparency = u5.lerp(u116, u51, p135)
                                return p136
                            end
                            table.insert(v131, v132(v133, v134, v137))
                        end
                        local v138 = u56
                        local v139 = u14.effects.emitOnFinish(u92, u89, u14.depth + 1).Finished
                        table.insert(v138, v139)
                    end)
                end
            end
            u58 = u58 % v78
            return p77
        end
        local v141 = u5.RENDER_PRIORITY + u14.depth
        table.insert(u14, v75(v76, u53, v140, nil, nil, true, v141))
        task.wait(u38.Max + u53 + math.max(u48, u37))
        u7.all(u56):await()
    end
end
return v9