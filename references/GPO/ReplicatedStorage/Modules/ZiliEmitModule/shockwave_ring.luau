 

local u1 = game:GetService("CollectionService")
local u2 = require("./mod/tween")
local u3 = require("./mod/utility")
local u4 = require(script.Parent.obj.Promise)
require("./obj/ObjectCache")
local u5 = Random.new()
local v6 = {}
local u7 = nil
function v6.init(p8) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    u7 = p8
end
function v6.deinit() --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    u7 = nil
end
function v6.emit(p9, u10, u11) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u3
        [3] = u1
        [4] = u5
        [5] = u2
        [6] = u4
    --]]
    if u7 then
        local v12 = u3.getAttribute(p9, "RayDirection", Vector3.new(0, -50, 0))
        local v13 = u3.getAttribute(p9, "RayCollisionGroup", "Default")
        local v14 = u3.getAttribute(p9, "FilterTag", "")
        local v15 = u3.getAttribute(p9, "FilterType", "Exclude")
        local v16 = u3.getAttribute(p9, "IgnoreWater", true)
        local v17 = u3.getAttribute(p9, "IgnoreCanCollide", false)
        local v18 = RaycastParams.new()
        v18.CollisionGroup = v13
        v18.IgnoreWater = v16
        v18.RespectCanCollide = not v17
        v18.FilterType = Enum.RaycastFilterType[v15]
        v18.FilterDescendantsInstances = u1:GetTagged(v14)
        if v15 == "Exclude" then
            v18:AddToFilter({ workspace.Terrain })
        end
        local v19 = u3.getAttribute(u10, "EmitDelay", 0)
        local v20 = u3.getAttribute(u10, "Radius", 5)
        local v21 = u3.getAttribute(u10, "Segments", 7)
        local v22 = u3.getRangeAttribute(u10, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
        local v23 = u3.getAttribute(u10, "PartOffset", Vector3.new(0, 0, 0), true)
        local u24 = u3.getAttribute(u10, "BaseOffset", v23)
        local u25 = u3.getAttribute(u10, "Offset_Start", v23)
        local u26 = u3.getAttribute(u10, "Offset_End", v23)
        local v27 = u3.getAttribute(u10, "Offset_Start_Duration", 0.5)
        local u28 = u3.getAttribute(u10, "Offset_End_Duration", 0.5)
        local u29 = u3.getAttribute(u10, "SizeScaleStart", Vector3.new(0, 0, 0))
        local u30 = u3.getAttribute(u10, "SizeScaleEnd", Vector3.new(0, 0, 0))
        local v31 = u3.getAttribute(u10, "MinSize", Vector3.new(2, 1, 2))
        local v32 = u3.getAttribute(u10, "MaxSize", Vector3.new(3, 2, 3))
        local v33 = u3.getAttribute(u10, "Size_Curve", u3.default_bezier, true)
        local v34 = u3.getAttribute(u10, "Size_Duration", 0.5, true)
        local v35 = u3.getAttribute(u10, "Size_Start_Curve", v33)
        local u36 = u3.getAttribute(u10, "Size_End_Curve", v33)
        local v37 = u3.getAttribute(u10, "Size_Start_Duration", v34)
        local u38 = u3.getAttribute(u10, "Size_End_Duration", v34)
        local u39 = u3.getAttribute(u10, "Transparency_Duration", 0.5)
        local v40 = u3.getAttribute(u10, "Transparency_Start", 0)
        local u41 = u3.getAttribute(u10, "Transparency_End", 0)
        task.wait(v19)
        local v42 = {}
        for v43 = 0, v21 - 1 do
            local v44 = v43 / v21 * 3.141592653589793 * 2
            local v45 = v20 * math.cos(v44)
            local v46 = v20 * math.sin(v44)
            local v47 = workspace:Raycast((p9.WorldCFrame * CFrame.new(v45, 0, v46)).Position, p9.WorldCFrame:VectorToWorldSpace(v12), v18)
            if v47 then
                local v48 = u5:NextNumber(v31.X, v32.X)
                local v49 = u5:NextNumber(v31.Y, v32.Y)
                local v50 = u5:NextNumber(v31.Z, v32.Z)
                local u51 = u3.getRanomId()
                local u52 = u7:get(u51)
                local v53 = u52._getReal()
                u3.copyProperties(u10, v53, u3.COPY_PART_PROPERTIES)
                u3.copyProperties(u10, v53, u3.COPY_EXTENDED_PART_PROPERTIES)
                if #u10:GetChildren() ~= 0 then
                    local v54 = u10:Clone()
                    for _, v55 in v54:GetChildren() do
                        v55.Parent = v53
                    end
                    v54:Destroy()
                end
                local function v56() --[[ Line: 128 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u51
                    --]]
                    if u7 then
                        u7:free(u51)
                    end
                end
                table.insert(u11, v56)
                u52.Color = v47.Instance.Color
                u52.Material = v47.Material
                u52.Transparency = v47.Instance.Transparency
                if u52.Transparency == 0 then
                    u52.Transparency = v40
                end
                u52.Size = Vector3.new(0, 0, 0)
                local v57 = -math.cos(v44)
                local v58 = -math.sin(v44)
                local v59 = p9.WorldCFrame:VectorToWorldSpace((Vector3.new(v57, 0, v58))):Cross(v47.Normal).Unit
                local v60 = CFrame.fromMatrix(v47.Position, v59, v47.Normal)
                local v61 = CFrame.fromOrientation
                local v62 = v49 / v50
                local u63 = v60 * v61(-math.atan(v62), 0, 0)
                u52.CFrame = CFrame.new(u25) * u63
                local u64 = nil
                local u65 = Vector3.new(0, 0, 0)
                local u66
                if u25 == u24 then
                    u66 = nil
                else
                    u66 = u2.fromParams(u3.getAttribute(u10, "Offset_Start_Curve", u3.default_bezier), v27, function(p67, p68) --[[ Line: 164 ]]
                        --[[
                        Upvalues:
                            [1] = u65
                            [2] = u25
                            [3] = u24
                            [4] = u52
                            [5] = u63
                        --]]
                        u65 = u25:Lerp(u24, p67)
                        u52.CFrame = CFrame.new(u65) * u63
                        return p68
                    end)
                    table.insert(u11, u64)
                end
                local u69 = Vector3.new(v48, v49, v50)
                if u69 * u29 == u69 then
                    u52.Size = u69 * u29
                else
                    u64 = u2.fromParams(v35, v37, function(p70, p71) --[[ Line: 177 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                            [2] = u69
                            [3] = u29
                        --]]
                        u52.Size = (u69 * u29):Lerp(u69, p70)
                        return p71
                    end)
                    table.insert(u11, u64)
                end
                if shared.vfx and #u52:GetChildren() ~= 0 then
                    local v72 = shared.vfx.emit(u52).Finished
                    table.insert(v42, v72)
                end
                task.delay(u5:NextNumber(v22.Min, v22.Max), function() --[[ Line: 192 ]]
                    --[[
                    Upvalues:
                        [1] = u64
                        [2] = u66
                        [3] = u52
                        [4] = u69
                        [5] = u30
                        [6] = u11
                        [7] = u2
                        [8] = u36
                        [9] = u38
                        [10] = u65
                        [11] = u26
                        [12] = u3
                        [13] = u10
                        [14] = u28
                        [15] = u63
                        [16] = u41
                        [17] = u39
                    --]]
                    if u64 then
                        u64:Disconnect()
                    end
                    if u66 then
                        u66:Disconnect()
                    end
                    local u73 = u52.Size
                    local u74 = u52.Transparency
                    if u73 ~= u69 * u30 then
                        local v75 = u11
                        local v76 = u2.fromParams
                        local v77 = u36
                        local v78 = u38
                        local function v81(p79, p80) --[[ Line: 207 ]]
                            --[[
                            Upvalues:
                                [1] = u52
                                [2] = u73
                                [3] = u69
                                [4] = u30
                            --]]
                            u52.Size = u73:Lerp(u69 * u30, p79)
                            return p80
                        end
                        table.insert(v75, v76(v77, v78, v81))
                    end
                    if u65 ~= u26 then
                        local v82 = u11
                        local v83 = u2.fromParams
                        local v84 = u3.getAttribute(u10, "Offset_End_Curve", u3.default_bezier)
                        local v85 = u28
                        local function v88(p86, p87) --[[ Line: 220 ]]
                            --[[
                            Upvalues:
                                [1] = u52
                                [2] = u65
                                [3] = u26
                                [4] = u63
                            --]]
                            u52.CFrame = CFrame.new(u65:Lerp(u26, p86)) * u63
                            return p87
                        end
                        table.insert(v82, v83(v84, v85, v88))
                    end
                    if u74 == u41 then
                        u52.Transparency = u74
                    else
                        local v89 = u11
                        local v90 = u2.fromParams
                        local v91 = u3.getAttribute(u10, "Transparency_Curve", u3.default_bezier)
                        local v92 = u39
                        local function v95(p93, p94) --[[ Line: 234 ]]
                            --[[
                            Upvalues:
                                [1] = u52
                                [2] = u3
                                [3] = u74
                                [4] = u41
                            --]]
                            u52.Transparency = u3.lerp(u74, u41, p93)
                            return p94
                        end
                        table.insert(v89, v90(v91, v92, v95))
                    end
                end)
            end
        end
        task.wait(v22.Max + math.max(u38, u28))
        u4.all(v42):await()
    end
end
return v6