 

local u1 = game:GetService("CollectionService")
local u2 = require("../mod/attributes")
local u3 = require("../mod/tween")
require("../types")
local u4 = require("../mod/utility")
local u5 = require("../pkg/Promise")
require("../obj/ObjectCache")
local u6 = Random.new()
local v7 = {}
local u8 = nil
function v7.init(p9) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    u8 = p9
end
function v7.deinit() --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    u8 = nil
end
function v7.emit(p10, u11, u12) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u2
        [3] = u1
        [4] = u4
        [5] = u6
        [6] = u3
        [7] = u5
    --]]
    if u8 then
        local v13 = u2.get(p10, "RayDirection", Vector3.new(0, -50, 0))
        local v14 = u2.get(p10, "RayCollisionGroup", "Default")
        local v15 = u2.get(p10, "FilterTag", "")
        local v16 = u2.get(p10, "FilterType", "Exclude")
        local v17 = u2.get(p10, "IgnoreWater", true)
        local v18 = u2.get(p10, "IgnoreCanCollide", false)
        local v19 = RaycastParams.new()
        v19.CollisionGroup = v14
        v19.IgnoreWater = v17
        v19.RespectCanCollide = not v18
        v19.FilterType = Enum.RaycastFilterType[v16]
        v19.FilterDescendantsInstances = u1:GetTagged(v15)
        if v16 == "Exclude" then
            v19:AddToFilter({ workspace.Terrain })
        end
        local v20 = u2.get(u11, "EmitDelay", 0)
        local v21 = u2.get(u11, "Radius", 5)
        local v22 = u2.get(u11, "Segments", 7)
        local v23 = u2.getRange(u11, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
        local v24 = u2.get(u11, "PartOffset", Vector3.new(0, 0, 0), true)
        local u25 = u2.get(u11, "BaseOffset", v24)
        local u26 = u2.get(u11, "Offset_Start", v24)
        local u27 = u2.get(u11, "Offset_End", v24)
        local v28 = u2.get(u11, "Offset_Start_Duration", 0.5)
        local u29 = u2.get(u11, "Offset_End_Duration", 0.5)
        local u30 = u2.get(u11, "SizeScaleStart", Vector3.new(0, 0, 0))
        local u31 = u2.get(u11, "SizeScaleEnd", Vector3.new(0, 0, 0))
        local v32 = u2.get(u11, "MinSize", Vector3.new(2, 1, 2))
        local v33 = u2.get(u11, "MaxSize", Vector3.new(3, 2, 3))
        local v34 = u2.get(u11, "Size_Curve", u4.default_bezier, true)
        local v35 = u2.get(u11, "Size_Duration", 0.5, true)
        local v36 = u2.get(u11, "Size_Start_Curve", v34)
        local u37 = u2.get(u11, "Size_End_Curve", v34)
        local v38 = u2.get(u11, "Size_Start_Duration", v35)
        local u39 = u2.get(u11, "Size_End_Duration", v35)
        local u40 = u2.get(u11, "Transparency_Duration", 0.5)
        local v41 = u2.get(u11, "Transparency_Start", 0)
        local u42 = u2.get(u11, "Transparency_End", 0)
        task.wait(v20)
        local v43 = u4.getTransformedOriginExtents(p10)
        local u44 = {}
        for v45 = 0, v22 - 1 do
            local v46 = v45 / v22 * 3.141592653589793 * 2
            local v47 = v21 * math.cos(v46)
            local v48 = v21 * math.sin(v46)
            local v49 = workspace:Raycast((v43 * CFrame.new(v47, 0, v48)).Position, v43:VectorToWorldSpace(v13), v19)
            if v49 then
                local v50 = u6:NextNumber(v32.X, v33.X)
                local v51 = u6:NextNumber(v32.Y, v33.Y)
                local v52 = u6:NextNumber(v32.Z, v33.Z)
                local u53 = u4.getRandomId()
                local u54 = u8:get(u53)
                local v55 = u54._getReal()
                u4.copyProperties(u11, v55, u4.COPY_PART_PROPERTIES)
                u4.copyProperties(u11, v55, u4.COPY_EXTENDED_PART_PROPERTIES)
                if #u11:GetChildren() ~= 0 then
                    local v56 = u11:Clone()
                    for _, v57 in v56:GetChildren() do
                        v57.Parent = v55
                    end
                    v56:Destroy()
                end
                local u58 = u12.effects.prepareEmitOnFinish(u54, u12)
                local function v59() --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u53
                    --]]
                    if u8 then
                        u8:free(u53)
                    end
                end
                table.insert(u12, v59)
                u54.Color = v49.Instance.Color
                u54.Material = v49.Material
                u54.Transparency = v49.Instance.Transparency
                if u54.Transparency == 0 then
                    u54.Transparency = v41
                end
                u54.Size = Vector3.new(0, 0, 0)
                local v60 = -math.cos(v46)
                local v61 = -math.sin(v46)
                local v62 = v43:VectorToWorldSpace((Vector3.new(v60, 0, v61))):Cross(v49.Normal).Unit
                local v63 = CFrame.fromMatrix(v49.Position, v62, v49.Normal)
                local v64 = CFrame.fromOrientation
                local v65 = v51 / v52
                local u66 = v63 * v64(-math.atan(v65), 0, 0)
                u54.CFrame = CFrame.new(u26) * u66
                local u67 = nil
                local u68 = Vector3.new(0, 0, 0)
                local u69
                if u26 == u25 then
                    u69 = nil
                else
                    u69 = u3.fromParams(u2.get(u11, "Offset_Start_Curve", u4.default_bezier), v28, function(p70, p71) --[[ Line: 166 ]]
                        --[[
                        Upvalues:
                            [1] = u68
                            [2] = u26
                            [3] = u25
                            [4] = u54
                            [5] = u66
                        --]]
                        u68 = u26:Lerp(u25, p70)
                        u54.CFrame = CFrame.new(u68) * u66
                        return p71
                    end)
                    table.insert(u12, u67)
                end
                local u72 = Vector3.new(v50, v51, v52)
                if u72 * u30 == u72 then
                    u54.Size = u72 * u30
                else
                    u67 = u3.fromParams(v36, v38, function(p73, p74) --[[ Line: 179 ]]
                        --[[
                        Upvalues:
                            [1] = u54
                            [2] = u72
                            [3] = u30
                        --]]
                        u54.Size = (u72 * u30):Lerp(u72, p73)
                        return p74
                    end)
                    table.insert(u12, u67)
                end
                local v75 = u12.effects.emitNested(u54, u12.depth + 1).Finished
                table.insert(u44, v75)
                task.delay(u6:NextNumber(v23.Min, v23.Max), function() --[[ Line: 192 ]]
                    --[[
                    Upvalues:
                        [1] = u67
                        [2] = u69
                        [3] = u54
                        [4] = u72
                        [5] = u31
                        [6] = u12
                        [7] = u3
                        [8] = u37
                        [9] = u39
                        [10] = u68
                        [11] = u27
                        [12] = u2
                        [13] = u11
                        [14] = u4
                        [15] = u29
                        [16] = u66
                        [17] = u42
                        [18] = u40
                        [19] = u58
                        [20] = u44
                    --]]
                    if u67 then
                        u67:Disconnect()
                    end
                    if u69 then
                        u69:Disconnect()
                    end
                    local u76 = u54.Size
                    local u77 = u54.Transparency
                    if u76 ~= u72 * u31 then
                        local v78 = u12
                        local v79 = u3.fromParams
                        local v80 = u37
                        local v81 = u39
                        local function v84(p82, p83) --[[ Line: 207 ]]
                            --[[
                            Upvalues:
                                [1] = u54
                                [2] = u76
                                [3] = u72
                                [4] = u31
                            --]]
                            u54.Size = u76:Lerp(u72 * u31, p82)
                            return p83
                        end
                        table.insert(v78, v79(v80, v81, v84))
                    end
                    if u68 ~= u27 then
                        local v85 = u12
                        local v86 = u3.fromParams
                        local v87 = u2.get(u11, "Offset_End_Curve", u4.default_bezier)
                        local v88 = u29
                        local function v91(p89, p90) --[[ Line: 220 ]]
                            --[[
                            Upvalues:
                                [1] = u54
                                [2] = u68
                                [3] = u27
                                [4] = u66
                            --]]
                            u54.CFrame = CFrame.new(u68:Lerp(u27, p89)) * u66
                            return p90
                        end
                        table.insert(v85, v86(v87, v88, v91))
                    end
                    if u77 ~= u42 then
                        local v92 = u12
                        local v93 = u3.fromParams
                        local v94 = u2.get(u11, "Transparency_Curve", u4.default_bezier)
                        local v95 = u40
                        local function v98(p96, p97) --[[ Line: 234 ]]
                            --[[
                            Upvalues:
                                [1] = u54
                                [2] = u4
                                [3] = u77
                                [4] = u42
                            --]]
                            u54.Transparency = u4.lerp(u77, u42, p96)
                            return p97
                        end
                        table.insert(v92, v93(v94, v95, v98))
                    end
                    local v99 = u44
                    local v100 = u12.effects.emitOnFinish(u58, u54, u12.depth + 1).Finished
                    table.insert(v99, v100)
                end)
            end
        end
        task.wait(v23.Max + math.max(u39, u29))
        u5.all(u44):await()
    end
end
return v7