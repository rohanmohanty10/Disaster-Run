 

local u1 = game:GetService("HttpService")
local u2 = require(script.Parent:WaitForChild("Config"))
local u3 = require(script.Parent:WaitForChild("DefaultObjectSettings"))
local u4 = {
    ["Block"] = "Box",
    ["Ball"] = "Sphere",
    ["Capsule"] = "Capsule",
    ["Sphere"] = "Sphere",
    ["Box"] = "Box",
    ["Cylinder"] = "Cylinder"
}
local u104 = {
    ["LogIndent"] = 0,
    ["WaitForChildOfClass"] = function(p5, p6, p7) --[[ Name: WaitForChildOfClass, Line 25 ]]
        local v8 = os.clock()
        local v9 = p7 or 10
        repeat
            task.wait()
        until p5:FindFirstChildOfClass(p6) or v9 < os.clock() - v8
        return p5:FindFirstChildOfClass(p6)
    end,
    ["GetRotationBetween"] = function(p10, p11) --[[ Name: GetRotationBetween, Line 34 ]]
        local v12 = p10:Dot(p11)
        local v13 = p10:Cross(p11).Magnitude
        local v14 = math.atan2(v13, v12)
        local v15 = p10:Cross(p11)
        local v16 = v15.Magnitude <= 1e-6 and Vector3.new(-0, -1, -0) or v15.Unit
        if v13 >= 1e-6 then
            return CFrame.fromAxisAngle(v16, v14)
        end
        if v12 > 0 then
            return CFrame.new()
        end
        local v17 = p10.X
        local v18 = math.abs(v17)
        local v19 = p10.Z
        if math.abs(v19) < v18 then
            local v20 = -p10.Y
            local v21 = p10.X
            v24 = Vector3.new(v20, v21, 0)
            if v24 then
                ::l10::
                return CFrame.fromAxisAngle(v24.Unit, 3.141592653589793)
            end
        end
        local v22 = -p10.Z
        local v23 = p10.Y
        local v24 = Vector3.new(0, v22, v23)
        goto l10
    end,
    ["GetCFrameAxis"] = function(p25, p26) --[[ Name: GetCFrameAxis, Line 53 ]]
        local v27, v28, v29 = p25:ToEulerAnglesXYZ()
        if p26 == "X" then
            return v27
        elseif p26 == "Y" then
            return v28
        elseif p26 == "Z" then
            return v29
        else
            return nil
        end
    end,
    ["GatherObjectSettings"] = function(p30) --[[ Name: GatherObjectSettings, Line 65 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v31 = {}
        for v32, v33 in u3 do
            local v34 = p30:GetAttribute(v32)
            if v34 ~= nil then
                local v35 = typeof(v33)
                local v36
                if typeof(v34) == v35 then
                    v36 = true
                else
                    warn((("[SmartBone][Object] Expected attribute %* on %* to be of type %*, got type %*"):format(v32, p30.Name, v35, (typeof(v34)))))
                    v36 = false
                end
                if not v36 then
                    v34 = nil
                end
            end
            v31[v32] = v34 == nil and v33 and v33 or v34
        end
        return v31
    end,
    ["GatherBoneSettings"] = function(p37) --[[ Name: GatherBoneSettings, Line 92 ]]
        local v38 = p37:GetAttribute("XAxisLocked") or false
        local v39 = p37:GetAttribute("YAxisLocked") or false
        local v40 = p37:GetAttribute("ZAxisLocked") or false
        local v41 = p37:GetAttribute("XAxisLimits") or NumberRange.new((-1 / 0), (1 / 0))
        local v42 = p37:GetAttribute("YAxisLimits") or NumberRange.new((-1 / 0), (1 / 0))
        local v43 = p37:GetAttribute("ZAxisLimits") or NumberRange.new((-1 / 0), (1 / 0))
        local v44 = p37:GetAttribute("Radius") or 0.25
        local v45 = p37:GetAttribute("RotationLimit") or 180
        local v46 = p37:GetAttribute("Force") or "\194\172"
        local v47 = p37:GetAttribute("Gravity") or "\194\172"
        if typeof(v38) ~= "boolean" then
            warn((("[SmartBone][Bone] Expected attribute XAxisLocked on %* to be of type boolean, got type %*"):format(p37.Name, (typeof(v38)))))
        end
        if typeof(v39) ~= "boolean" then
            warn((("[SmartBone][Bone] Expected attribute YAxisLocked on %* to be of type boolean, got type %*"):format(p37.Name, (typeof(v39)))))
        end
        if typeof(v40) ~= "boolean" then
            warn((("[SmartBone][Bone] Expected attribute ZAxisLocked on %* to be of type boolean, got type %*"):format(p37.Name, (typeof(v40)))))
        end
        if typeof(v41) ~= "NumberRange" then
            warn((("[SmartBone][Bone] Expected attribute XAxisLimits on %* to be of type NumberRange, got type %*"):format(p37.Name, (typeof(v41)))))
        end
        if typeof(v42) ~= "NumberRange" then
            warn((("[SmartBone][Bone] Expected attribute YAxisLimits on %* to be of type NumberRange, got type %*"):format(p37.Name, (typeof(v42)))))
        end
        if typeof(v43) ~= "NumberRange" then
            warn((("[SmartBone][Bone] Expected attribute ZAxisLimits on %* to be of type NumberRange, got type %*"):format(p37.Name, (typeof(v43)))))
        end
        if typeof(v44) ~= "number" then
            warn((("[SmartBone][Bone] Expected attribute Radius on %* to be of type number, got type %*"):format(p37.Name, (typeof(v44)))))
        end
        if typeof(v45) ~= "number" then
            warn((("[SmartBone][Bone] Expected attribute RotationLimit on %* to be of type number, got type %*"):format(p37.Name, (typeof(v45)))))
        end
        if v46 ~= "\194\172" and typeof(v46) ~= "Vector3" then
            warn((("[SmartBone][Bone] Expected attribute Force on %* to be of type Vector3, got type %*"):format(p37.Name, (typeof(v46)))))
        end
        if v46 ~= "\194\172" and typeof(v47) ~= "Vector3" then
            warn((("[SmartBone][Bone] Expected attribute Gravity on %* to be of type Vector3, got type %*"):format(p37.Name, (typeof(v47)))))
        end
        return {
            ["AxisLocked"] = { v38, v39, v40 },
            ["XAxisLimits"] = v41,
            ["YAxisLimits"] = v42,
            ["ZAxisLimits"] = v43,
            ["RotationLimit"] = v45,
            ["Radius"] = v44,
            ["Force"] = v46,
            ["Gravity"] = v47
        }
    end,
    ["ClosestPointOnLine"] = function(p48, p49, p50, p51) --[[ Name: ClosestPointOnLine, Line 151 ]]
        local v52 = (p51 - p48):Dot(p49)
        local v53 = -p50
        return p48 + p49 * math.clamp(v52, v53, p50)
    end,
    ["ClosestPointInBox"] = function(p54, p55, p56) --[[ Name: ClosestPointInBox, Line 159 ]]
        local v57 = p54:PointToObjectSpace(p56)
        local v58 = p55.X
        local v59 = p55.X
        local v60 = p55.Z
        local v61 = v57.X
        local v62 = v57.Y
        local v63 = v57.Z
        if v57 == v57 and p55 == p55 then
            local v64 = -v58 * 0.5
            local v65 = v58 * 0.5
            local v66 = math.clamp(v61, v64, v65)
            local v67 = -v59 * 0.5
            local v68 = v59 * 0.5
            local v69 = math.clamp(v62, v67, v68)
            local v70 = -v60 * 0.5
            local v71 = v60 * 0.5
            local v72 = math.clamp(v63, v70, v71)
            if v66 == v61 and (v69 == v62 and v72 == v63) then
                local v73 = v61 - v58 * 0.5
                local v74 = v62 - v59 * 0.5
                local v75 = v63 - v60 * 0.5
                local v76 = -v61 - v58 * 0.5
                local v77 = -v62 - v59 * 0.5
                local v78 = -v63 - v60 * 0.5
                local v79 = math.max(v73, v74, v75, v76, v77, v78)
                if v79 == v73 then
                    local v80 = v58 * 0.5
                    return true, p54 * Vector3.new(v80, v62, v63), p54.XVector
                elseif v79 == v74 then
                    local v81 = v59 * 0.5
                    return true, p54 * Vector3.new(v61, v81, v63), p54.YVector
                elseif v79 == v75 then
                    local v82 = v60 * 0.5
                    return true, p54 * Vector3.new(v61, v62, v82), p54.ZVector
                elseif v79 == v76 then
                    local v83 = -v58 * 0.5
                    return true, p54 * Vector3.new(v83, v62, v63), -p54.XVector
                elseif v79 == v77 then
                    local v84 = -v59 * 0.5
                    return true, p54 * Vector3.new(v61, v84, v63), -p54.YVector
                elseif v79 == v78 then
                    local v85 = -v60 * 0.5
                    return true, p54 * Vector3.new(v61, v62, v85), -p54.ZVector
                else
                    warn("CLOSEST POINT ON BOX FAIL")
                    return false, Vector3.new(0, 0, 0), Vector3.new(0, 1, 0)
                end
            else
                local v86 = p54 * Vector3.new(v66, v69, v72)
                return false, v86, (p56 - v86).unit
            end
        else
            return false, p54.Position, Vector3.new(0, 1, 0)
        end
    end,
    ["GetCollider"] = function(p87) --[[ Name: GetCollider, Line 214 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u4
        --]]
        local v88 = p87:FindFirstChild("self.Collider")
        local v89
        if v88 and v88:IsA("ModuleScript") then
            local u90 = require(v88)
            local u91 = nil
            pcall(function() --[[ Line: 223 ]]
                --[[
                Upvalues:
                    [1] = u91
                    [2] = u1
                    [3] = u90
                --]]
                u91 = u1:JSONDecode(u90)
            end)
            v89 = u91
        else
            v89 = nil
        end
        return v89 or {
            {
                ["Type"] = u4[p87:GetAttribute("ColliderShape") or (not p87:IsA("Part") and "Box" or p87.Shape.Name)] or "Box",
                ["ScaleX"] = 1,
                ["ScaleY"] = 1,
                ["ScaleZ"] = 1,
                ["OffsetX"] = 0,
                ["OffsetY"] = 0,
                ["OffsetZ"] = 0,
                ["RotationX"] = 0,
                ["RotationY"] = 0,
                ["RotationZ"] = 0
            }
        }
    end,
    ["SB_INDENT_LOG"] = function() --[[ Name: SB_INDENT_LOG, Line 270 ]]
        --[[
        Upvalues:
            [1] = u104
        --]]
        local v92 = u104
        v92.LogIndent = v92.LogIndent + 1
    end,
    ["SB_UNINDENT_LOG"] = function() --[[ Name: SB_UNINDENT_LOG, Line 274 ]]
        --[[
        Upvalues:
            [1] = u104
        --]]
        local v93 = u104
        v93.LogIndent = v93.LogIndent - 1
        local v94 = u104
        local v95 = u104.LogIndent
        v94.LogIndent = math.max(v95, 0)
    end,
    ["SB_ASSERT_CB"] = function(p96, p97, ...) --[[ Name: SB_ASSERT_CB, Line 279 ]]
        if p96 == false or p96 == nil then
            p97(...)
        end
    end,
    ["SB_VERBOSE_LOG"] = function(p98) --[[ Name: SB_VERBOSE_LOG, Line 285 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u104
        --]]
        if u2.LOG_VERBOSE then
            local v99 = string.rep("    ", u104.LogIndent)
            print((("%*[SmartBone][Log]: %*"):format(v99, p98)))
        end
    end,
    ["SB_VERBOSE_WARN"] = function(p100) --[[ Name: SB_VERBOSE_WARN, Line 295 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u104
        --]]
        if u2.LOG_VERBOSE then
            local v101 = string.rep("    ", u104.LogIndent)
            warn((("%*[SmartBone][Warn]: %*"):format(v101, p100)))
        end
    end,
    ["SB_VERBOSE_ERROR"] = function(p102) --[[ Name: SB_VERBOSE_ERROR, Line 305 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u104
        --]]
        if u2.LOG_VERBOSE then
            local v103 = string.rep("    ", u104.LogIndent)
            error((("%*[SmartBone][Error]: %*"):format(v103, p102)))
        end
    end
}
return u104