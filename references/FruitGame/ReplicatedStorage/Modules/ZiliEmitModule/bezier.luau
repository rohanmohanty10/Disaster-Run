 

local u1 = game:GetService("HttpService")
local u2 = game:GetService("CollectionService")
local u3 = require("./mod/tween")
local u4 = require("./mod/shape")
local u5 = require("./mod/utility")
local u6 = require("./obj/Bezier")
require("./obj/ObjectCache")
local u7 = require(script.Parent.obj.Promise)
local u38 = {
    ["Box"] = {
        ["Volume"] = u4.getPointWithinBox,
        ["Surface"] = u4.getPointOnBox
    },
    ["Cylinder"] = {
        ["Volume"] = function(p8, p9, p10, p11, p12) --[[ Name: Volume, Line 20 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            return u4.getPointWithinCylinder(p8, 0, p12, p9, p10, p11)
        end,
        ["Surface"] = function(p13, p14, p15, p16, p17) --[[ Name: Surface, Line 24 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            return u4.getPointWithinCylinder(p13, 1, p17, p14, p15, p16)
        end
    },
    ["Sphere"] = {
        ["Volume"] = function(p18, p19, p20, p21, p22) --[[ Name: Volume, Line 30 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            return u4.getPointWithinSphere(p18, 0, p22, p19, p20, p21)
        end,
        ["Surface"] = function(p23, p24, p25, p26, p27) --[[ Name: Surface, Line 34 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            return u4.getPointWithinSphere(p23, 1, p27, p24, p25, p26)
        end
    },
    ["Disc"] = {
        ["Volume"] = function(p28, p29, p30, p31, p32) --[[ Name: Volume, Line 40 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            return u4.getPointWithinDisc(p28, 0, p32, p29, p30, p31)
        end,
        ["Surface"] = function(p33, p34, p35, p36, p37) --[[ Name: Surface, Line 44 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            return u4.getPointWithinDisc(p33, 1, p37, p34, p35, p36)
        end
    }
}
local v39 = {}
local u40 = nil
function v39.init(p41) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u40
    --]]
    u40 = p41
end
function v39.deinit() --[[ Line: 58 ]]
    --[[
    Upvalues:
        [1] = u40
    --]]
    u40 = nil
end
function v39.emit(u42, u43, u44, p45) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u40
        [2] = u5
        [3] = u38
        [4] = u3
        [5] = u6
        [6] = u2
        [7] = u7
        [8] = u1
    --]]
    local v46 = u42:FindFirstChild("Points")
    if v46 and (v46:IsA("Attachment") and u40) then
        local v47 = u5.getAttribute(u42, "EmitDelay", 0)
        local v48 = u5.getAttribute(u42, "EmitCount", 1)
        local v49 = u5.getAttribute(u42, "EmitDuration", 0)
        local v50 = u5.getAttribute(u42, "DestroyDelay", 0)
        local v51 = u5.getRangeAttribute(u42, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)))
        local u52 = u5.getEnumAttribute(u42, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" })
        local u53 = u5.getAttribute(u42, "SpreadAngle", Vector3.new(0, 0, 0))
        local u54 = u5.getAttribute(u42, "SyncPosition", false)
        local u55 = u5.getAttribute(u42, "MirrorPaths", true)
        local u56 = u5.getAttribute(u42, "MirrorRotation", Vector3.new(0, 0, 180))
        local u57 = u5.getAttribute(u42, "FacePath", false)
        local u58 = u5.getAttribute(u42, "ArcSpace", false)
        local u59 = u5.getAttribute(u42, "ShapePartial", 1)
        local v60 = u5.getEnumAttribute(u42, "Shape", "Box", {
            "Box",
            "Cylinder",
            "Sphere",
            "Disc"
        })
        local v61 = u5.getEnumAttribute(u42, "ShapeStyle", "Volume", { "Volume", "Surface" })
        local u62 = Enum.NormalId[u5.getEnumAttribute(u42, "EmissionDirection", "Top", {
            "Top",
            "Bottom",
            "Left",
            "Right",
            "Front",
            "Back"
        })]
        local u63 = u5.getAttribute(u42, "ProjectileEnabled", false)
        local u64 = u5.getAttribute(u42, "MatchEndDirection", false)
        local u65 = u5.getAttribute(u42, "ProjectileSpeed", 30)
        local v66 = u5.getRangeAttribute(u42, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)))
        local u67 = u5.getAttribute(u42, "HitboxEnabled", false)
        local v68 = u5.getAttribute(u42, "HitboxCollisionGroup", "Default")
        local v69 = u5.getAttribute(u42, "HitboxFilterTag", "")
        local v70 = u5.getAttribute(u42, "HitboxFilterType", "Exclude")
        local v71 = u5.getAttribute(u42, "HitboxIgnoreCanCollide", false)
        local v72 = u5.getRangeAttribute(u42, "RotSpeed_Start", NumberRange.new(0, 0))
        local v73 = u5.getRangeAttribute(u42, "RotSpeed_End", NumberRange.new(0, 0))
        local v74 = u5.getAttribute(u42, "MinInitRot", Vector3.new(0, 0, 0))
        local v75 = u5.getAttribute(u42, "MaxInitRot", Vector3.new(0, 0, 0))
        local u76 = u5.getAttribute(u42, "Speed_Start", 1)
        local u77 = u5.getAttribute(u42, "Speed_End", 1)
        local u78 = u38[v60]
        if u78 then
            u78 = u38[v60][v61]
        end
        if u78 then
            local u79 = {}
            local v80 = v49 > 0
            task.wait(v47)
            if v80 and not p45 then
                u42:SetAttribute("Enabled", true)
                if u76 ~= u77 then
                    u42:SetAttribute("SpeedTweening", true)
                    local v81 = u3.fromParams
                    local v82 = u5.getAttribute(u42, "Speed_Curve", u5.default_bezier)
                    local v83 = u5.getAttribute(u42, "Speed_Duration", 0.1)
                    local function v86(p84, p85) --[[ Line: 145 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                            [2] = u5
                            [3] = u76
                            [4] = u77
                        --]]
                        u42:SetAttribute("SpeedOverride", u5.lerp(u76, u77, p84))
                        return p85
                    end
                    table.insert(u44, v81(v82, v83, v86, nil, function() --[[ Line: 150 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                        --]]
                        u42:SetAttribute("SpeedTweening", nil)
                    end))
                end
                task.wait(v49)
                u42:SetAttribute("Enabled", false)
                u42:SetAttribute("SpeedOverride", nil)
            elseif v48 > 0 then
                local u87 = nil
                local u88 = nil
                local u89 = u42.Parent
                if not u89 then
                    return
                end
                if not (u89:IsA("BasePart") or u89:IsA("Attachment")) then
                    u89 = u42
                end
                if u89:IsA("BasePart") then
                    u87 = u89.Size
                    u88 = u89.CFrame
                elseif u89:IsA("Attachment") then
                    u88 = u89.WorldCFrame
                    u87 = Vector3.new(0, 0, 0)
                end
                if not u88 then
                    return
                end
                local u90 = u42:FindFirstChild("End")
                u90 = u90
                local u91
                if u90 then
                    u91 = u90:FindFirstChild("T1")
                end
                if u90 and not u90:IsA("Attachment") then
                    u90 = nil
                end
                if u91 and not u91:IsA("Attachment") then
                    u91 = nil
                end
                local u92 = u5.getBezierPoints(v46)
                local u93 = Random.new()
                local u94 = not u90
                if u94 then
                    u94 = u6.new(u92)
                end
                local u95 = OverlapParams.new()
                u95.MaxParts = 1
                u95.FilterType = Enum.RaycastFilterType[v70]
                u95.CollisionGroup = v68
                u95.RespectCanCollide = not v71
                u95:AddToFilter(u2:GetTagged(v69))
                if v70 == "Exclude" then
                    u95:AddToFilter({ workspace.Terrain, u89, v46:FindFirstAncestorOfClass("Part") })
                end
                for _ = 1, v48 do
                    local u96 = u93:NextNumber(v72.Min, v72.Max)
                    local u97 = u93:NextNumber(v73.Min, v73.Max)
                    local v98 = u93:NextNumber(v74.x, v75.x)
                    local v99 = u93:NextNumber(v74.y, v75.y)
                    local v100 = v74.z
                    local v101 = v75.z
                    local u102 = vector.create(v98, v99, u93:NextNumber(v100, v101))
                    local u103 = u93:NextNumber(v51.Min, v51.Max)
                    local u104
                    if u63 then
                        u104 = u93:NextNumber(v66.Min, v66.Max)
                    else
                        u104 = u63
                    end
                    local v105 = u7.new
                    local function v189(u106) --[[ Line: 232 ]]
                        --[[
                        Upvalues:
                            [1] = u89
                            [2] = u88
                            [3] = u62
                            [4] = u78
                            [5] = u87
                            [6] = u59
                            [7] = u93
                            [8] = u53
                            [9] = u52
                            [10] = u90
                            [11] = u55
                            [12] = u56
                            [13] = u5
                            [14] = u94
                            [15] = u92
                            [16] = u91
                            [17] = u6
                            [18] = u58
                            [19] = u1
                            [20] = u40
                            [21] = u43
                            [22] = u79
                            [23] = u44
                            [24] = u67
                            [25] = u95
                            [26] = u76
                            [27] = u96
                            [28] = u102
                            [29] = u77
                            [30] = u42
                            [31] = u3
                            [32] = u97
                            [33] = u103
                            [34] = u57
                            [35] = u54
                            [36] = u63
                            [37] = u104
                            [38] = u64
                            [39] = u65
                        --]]
                        local v107
                        if u89:IsA("Attachment") then
                            v107 = u88 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(u62)).Rotation
                        else
                            v107 = u78(nil, u88, u87, u62, u59)
                        end
                        local v108 = Vector3.FromNormalId(u62)
                        local v109 = v108:Cross(u88.LookVector)
                        if v109.Magnitude < 0.001 then
                            v109 = v108:Cross(u88.UpVector)
                        end
                        local v110 = CFrame.fromAxisAngle
                        local v111 = u93:NextNumber(-u53.x, u53.x)
                        local v112 = v110(v108, (math.rad(v111)))
                        local v113 = CFrame.fromAxisAngle
                        local v114 = u93:NextNumber(-u53.y, u53.y)
                        local u115 = v107 * (v112 * v113(v109, (math.rad(v114))))
                        if u52 == "Inward" or u52 == "InAndOut" and u93:NextInteger(0, 1) == 1 then
                            u115 = u115 * CFrame.fromOrientation(0, 3.141592653589793, 0)
                        end
                        if u90 and (u55 and (u115.Position - u90.WorldPosition).Unit:Dot(u115.RightVector) >= 0) then
                            local v116 = u56 * u5.DEG_TO_RAD
                            u115 = u115 * CFrame.fromOrientation(v116.x, v116.y, v116.z)
                        end
                        local u117 = u94
                        if u90 then
                            local v118 = {}
                            for v119, v120 in u92 do
                                local v121
                                if v119 == #u92 - 1 then
                                    v121 = u91 and u91.WorldPosition or u90.WorldPosition
                                elseif v119 == #u92 then
                                    v121 = u90.WorldPosition
                                else
                                    v121 = u115 * (v120 - u92[1])
                                end
                                table.insert(v118, v121)
                            end
                            u117 = u6.new(v118)
                        end
                        local u122 = u1:GenerateGUID(false)
                        if u40 then
                            local u123 = u40:get(u122)
                            local v124 = CFrame.new
                            local v125 = u58 and u117:getPositionArcSpace(0) or u117:getPosition(0)
                            if not u90 then
                                v125 = u115 * (v125 - u92[1])
                            end
                            u123.CFrame = v124(v125)
                            local u126 = u123._getReal()
                            u5.copyProperties(u43, u126, u5.COPY_PART_PROPERTIES)
                            u5.copyProperties(u43, u126, u5.COPY_EXTENDED_PART_PROPERTIES)
                            local v127 = u43:Clone()
                            for _, v128 in v127:GetChildren() do
                                v128.Parent = u126
                            end
                            v127:Destroy()
                            local u129 = u126:FindFirstChild("EmitOnFinish")
                            if u129 then
                                u129.Parent = nil
                            end
                            if shared.vfx and #u126:GetChildren() ~= 0 then
                                local v130 = u79
                                local v131 = shared.vfx.emit(u126).Finished
                                table.insert(v130, v131)
                            end
                            local v132 = u44
                            local function v133() --[[ Line: 322 ]]
                                --[[
                                Upvalues:
                                    [1] = u40
                                    [2] = u122
                                --]]
                                if u40 then
                                    u40:free(u122)
                                end
                            end
                            table.insert(v132, v133)
                            local u134 = Vector3.new(0, 0, 0)
                            local u135 = Vector3.new(0, 0, 0)
                            local u136 = false
                            local function u139() --[[ Line: 333 ]]
                                --[[
                                Upvalues:
                                    [1] = u136
                                    [2] = u129
                                    [3] = u126
                                    [4] = u106
                                --]]
                                if u136 then
                                    return
                                else
                                    u136 = true
                                    local v137 = u129
                                    if v137 then
                                        v137 = u129:GetChildren()
                                    end
                                    if v137 and #v137 ~= 0 then
                                        for _, v138 in v137 do
                                            v138.Parent = u126
                                        end
                                        shared.vfx.emit(table.unpack(v137)).Finished:finally(function() --[[ Line: 349 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u106
                                            --]]
                                            u106()
                                        end)
                                    else
                                        u106()
                                    end
                                end
                            end
                            local u140 = false
                            local u141 = CFrame.identity
                            local u142 = u76
                            local u143 = u96
                            local u144 = CFrame.fromOrientation(u102.x, u102.y, u102.z)
                            local u145
                            if u76 == u77 or u42:GetAttribute("SpeedOverride") then
                                u145 = nil
                            else
                                u145 = u3.fromParams(u5.getAttribute(u42, "Speed_Curve", u5.default_bezier), u5.getAttribute(u42, "Speed_Duration", 0.1), function(p146, p147) --[[ Line: 397 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u142
                                        [2] = u5
                                        [3] = u76
                                        [4] = u77
                                    --]]
                                    u142 = u5.lerp(u76, u77, p146)
                                    return p147
                                end)
                                local v148 = u44
                                table.insert(v148, u145)
                            end
                            if u96 ~= u97 then
                                local v149 = u44
                                local v150 = u3.fromParams
                                local v151 = u5.getAttribute(u42, "RotSpeed_Curve", u5.default_bezier)
                                local v152 = u103
                                local function v155(p153, p154) --[[ Line: 412 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u143
                                        [2] = u5
                                        [3] = u96
                                        [4] = u97
                                        [5] = u42
                                        [6] = u142
                                    --]]
                                    u143 = u5.lerp(u96, u97, p153)
                                    return p154 * (u42:GetAttribute("SpeedOverride") or u142)
                                end
                                table.insert(v149, v150(v151, v152, v155, u145))
                            end
                            local v156 = u44
                            local v157 = u3.fromParams
                            local v158 = u5.getAttribute(u42, "Easing_Curve", u5.linear_bezier)
                            local v159 = u103
                            local function v175(p160, p161, p162) --[[ Line: 426 ]]
                                --[[
                                Upvalues:
                                    [1] = u58
                                    [2] = u117
                                    [3] = u90
                                    [4] = u115
                                    [5] = u92
                                    [6] = u57
                                    [7] = u103
                                    [8] = u141
                                    [9] = u102
                                    [10] = u143
                                    [11] = u5
                                    [12] = u144
                                    [13] = u54
                                    [14] = u123
                                    [15] = u88
                                    [16] = u89
                                    [17] = u135
                                    [18] = u134
                                    [19] = u67
                                    [20] = u126
                                    [21] = u95
                                    [22] = u139
                                    [23] = u140
                                    [24] = u42
                                    [25] = u142
                                    [26] = u145
                                    [27] = u63
                                    [28] = u104
                                --]]
                                local v163 = u58 and u117:getPositionArcSpace(p160) or u117:getPosition(p160)
                                if not u90 then
                                    v163 = u115 * (v163 - u92[1])
                                end
                                local v164 = CFrame.new(v163)
                                if u57 then
                                    local v165 = (p162 + 0.016666666666666666) / u103
                                    local v166 = math.clamp(v165, 0, 1)
                                    local v167 = u58 and u117:getPositionArcSpace(v166) or u117:getPosition(v166)
                                    if not u90 then
                                        v167 = u115 * (v167 - u92[1])
                                    end
                                    if v163 == v167 then
                                        v164 = v164 * u141.Rotation
                                    else
                                        v164 = CFrame.lookAt(v163, v167)
                                    end
                                end
                                local v168 = u102:Sign() * u143 * u5.DEG_TO_RAD * p161
                                u144 = u144 * CFrame.fromOrientation(v168.x, v168.y, v168.z)
                                u141 = v164
                                local v169 = v164 * u144
                                if u54 then
                                    local v170 = u123
                                    local v171 = u88
                                    if u89:IsA("BasePart") then
                                        v171 = u89.CFrame
                                    elseif u89:IsA("Attachment") then
                                        v171 = u89.WorldCFrame
                                    end
                                    v170.CFrame = v171 * u88:ToObjectSpace(v169)
                                else
                                    u123.CFrame = v169
                                end
                                u135 = (v163 - u134) / p161
                                u134 = v163
                                local v172
                                if u67 then
                                    v172 = workspace:GetPartsInPart(u126, u95)[1] and true or false
                                else
                                    v172 = nil
                                end
                                if v172 then
                                    u139()
                                    u140 = true
                                    return nil
                                end
                                local v173 = u42:GetAttribute("SpeedOverride") or u142
                                u142 = v173
                                if v173 == 0 then
                                    local v174
                                    if u145 then
                                        v174 = not u145.Connected
                                    else
                                        v174 = not u42:GetAttribute("SpeedTweening")
                                    end
                                    if v174 then
                                        return nil
                                    end
                                end
                                if u63 and p160 * u103 < u104 or not u63 then
                                    return p161 * v173
                                end
                                u139()
                                return nil
                            end
                            local function v187(p176) --[[ Line: 486 ]]
                                --[[
                                Upvalues:
                                    [1] = u63
                                    [2] = u140
                                    [3] = u139
                                    [4] = u64
                                    [5] = u90
                                    [6] = u135
                                    [7] = u65
                                    [8] = u126
                                    [9] = u88
                                    [10] = u89
                                    [11] = u3
                                    [12] = u104
                                    [13] = u54
                                    [14] = u123
                                    [15] = u67
                                    [16] = u95
                                    [17] = u42
                                    [18] = u142
                                    [19] = u145
                                    [20] = u44
                                    [21] = u5
                                --]]
                                if u63 and not u140 then
                                    local v177
                                    if u64 and u90 then
                                        v177 = u90.WorldCFrame.LookVector
                                    else
                                        v177 = u135.Unit
                                    end
                                    u135 = (v177 ~= v177 and Vector3.new(0, 0, 0) or v177) * u65
                                    local u178 = u126.Position
                                    local u179 = u88
                                    if u89:IsA("BasePart") then
                                        u179 = u89.CFrame
                                    elseif u89:IsA("Attachment") then
                                        u179 = u89.WorldCFrame
                                    end
                                    u3.timer(u104, function(p180, p181) --[[ Line: 506 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u54
                                            [2] = u123
                                            [3] = u88
                                            [4] = u89
                                            [5] = u179
                                            [6] = u178
                                            [7] = u135
                                            [8] = u126
                                            [9] = u67
                                            [10] = u95
                                            [11] = u139
                                            [12] = u140
                                            [13] = u42
                                            [14] = u142
                                            [15] = u145
                                        --]]
                                        if u54 then
                                            local v182 = u123
                                            local v183 = u88
                                            if u89:IsA("BasePart") then
                                                v183 = u89.CFrame
                                            elseif u89:IsA("Attachment") then
                                                v183 = u89.WorldCFrame
                                            end
                                            v182.CFrame = v183 * u179:ToObjectSpace(CFrame.new(u178 + u135 * p181))
                                        else
                                            u123.CFrame = CFrame.new(u178 + u135 * p181) * u126.CFrame.Rotation
                                        end
                                        local v184
                                        if u67 then
                                            v184 = workspace:GetPartsInPart(u126, u95)[1] and true or false
                                        else
                                            v184 = nil
                                        end
                                        if v184 then
                                            u139()
                                            u140 = true
                                            return nil
                                        end
                                        local v185 = u42:GetAttribute("SpeedOverride") or u142
                                        u142 = v185
                                        if v185 > 0 then
                                            ::l18::
                                            return p180 * v185
                                        else
                                            if p181 > 0 then
                                                local v186
                                                if u145 then
                                                    v186 = u145.Connected
                                                else
                                                    v186 = u42:GetAttribute("SpeedTweening")
                                                end
                                                if v186 then
                                                    goto l18
                                                end
                                            end
                                            return nil
                                        end
                                    end, u145, u44, u5.RENDER_PRIORITY + u44.depth)
                                    if not u140 then
                                        u139()
                                    end
                                elseif p176 then
                                    u139()
                                end
                            end
                            local v188 = u5.RENDER_PRIORITY + u44.depth
                            table.insert(v156, v157(v158, v159, v175, u145, v187, true, v188))
                        else
                            u106()
                        end
                    end
                    table.insert(u79, v105(v189))
                end
                u7.all(u79):await()
                task.wait(v50)
            end
        else
            return
        end
    else
        return
    end
end
return v39