 

local v1 = script.Parent.Parent:WaitForChild("Dependencies")
local u2 = require(v1:WaitForChild("Config"))
local u3 = require(v1:WaitForChild("Debug"):WaitForChild("Gizmo"))
local u4 = require(v1:WaitForChild("Utilities"))
local v5 = script.Parent:WaitForChild("Constraints")
local u6 = require(v5:WaitForChild("AxisConstraint"))
local u7 = require(v5:WaitForChild("CollisionConstraint"))
local u8 = require(v5:WaitForChild("DistanceConstraint"))
local u9 = require(v5:WaitForChild("FrictionConstraint"))
local u10 = require(v5:WaitForChild("RopeConstraint"))
local u11 = require(v5:WaitForChild("RotationConstraint"))
local u12 = require(v5:WaitForChild("SpringConstraint"))
local u13 = u4.SB_ASSERT_CB
local u14 = math.sin
local u15 = math.cos
local u16 = math.abs
local u17 = math.min
local u18 = math.max
local u19 = math.clamp
local _ = math.atan2
local u20 = math.noise
local _ = math.rad
local u21 = os.clock
local u22 = CFrame.new
local _ = CFrame.fromAxisAngle
local _ = CFrame.identity
local u23 = Vector3.new
local u24 = {}
local u25 = {}
local function u30(p26) --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u25
        [3] = u30
    --]]
    if u24[p26] == shared.FrameCounter then
        return u25[p26]
    end
    local v27 = p26.Parent
    local v28
    if v27:IsA("Bone") then
        v28 = u30(v27)
    else
        v28 = v27.CFrame
    end
    local v29 = v28 * p26.TransformedCFrame
    u24[p26] = shared.FrameCounter
    u25[p26] = v29
    return v29
end
local function u39(p31, p32) --[[ Line: 140 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u25
        [3] = u30
        [4] = u39
    --]]
    p32.SolvedAnimatedCFrame = true
    local v33 = p32.ParentIndex
    local v34 = p32.Bone
    if v33 >= 1 then
        local v35 = p31.Bones[v33]
        if not v35.SolvedAnimatedCFrame then
            v35.AnimatedWorldCFrame = u39(p31, v35)
        end
        return v35.AnimatedWorldCFrame * v34.TransformedCFrame
    end
    if u24[v34] == shared.FrameCounter then
        return u25[v34]
    end
    local v36 = v34.Parent
    local v37
    if v36:IsA("Bone") then
        v37 = u30(v36)
    else
        v37 = v36.CFrame
    end
    local v38 = v37 * v34.TransformedCFrame
    u24[v34] = shared.FrameCounter
    u25[v34] = v38
    return v38
end
local function u53(_, p40, p41, p42, p43, p44, p45) --[[ Line: 214 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u19
        [3] = u23
    --]]
    local v46 = p40 ^ 0.8
    local v47 = p41 * 2 + p44
    local v48 = u19(u20(v46, 0, p43), -1, 1)
    if p45 then
        v48 = v48 ^ 2
    end
    local v49 = v48 * v47
    local v50 = u19(u20(0, v46, p43), -1, 1)
    if p45 then
        v50 = v50 ^ 2
    end
    local v51 = v50 * v47
    local v52 = u19(u20(p43, 0, v46), -1, 1)
    if p45 then
        v52 = v52 ^ 2
    end
    return p42 * u23(v49, v51, v52 * v47)
end
local function u97(p54, p55, p56) --[[ Line: 225 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u16
        [3] = u17
        [4] = u18
        [5] = u14
        [6] = u15
        [7] = u53
        [8] = u19
    --]]
    local v57 = p55.Settings
    local v58 = v57.WindType
    if v58 ~= "Sine" and (v58 ~= "Noise" and v58 ~= "Hybrid") then
        return Vector3.new(0, 0, 0)
    end
    local v59 = v57.WindSpeed
    local v60 = v57.WindStrength
    if v59 <= 1e-6 or v60 <= 1e-6 then
        return Vector3.new(0, 0, 0)
    end
    local v61 = p55.WindOffset + (u21() - p54.HeirarchyLength * 0.2 + (p54.TransformOffset.Position - p55.Root.WorldPosition).Magnitude * 0.2) * v57.WindInfluence
    local v62 = v57.WindDirection
    local v63 = (p56.Magnitude == 0 and Vector3.new(0, 0, 0) or p56.Unit):Dot(v62)
    local v64 = 1 - u16(v63)
    if v59 > 0 then
        if v63 > 0 then
            v64 = v64 * u16(1 - p56.Magnitude / v59)
        else
            v64 = v64 * (1 + p56.Magnitude / v59)
        end
    end
    local v65 = v59 * v64
    local v66 = p56.Magnitude
    local v67 = v66 < 100 and v66 and v66 or 100
    local v68 = u17(v67 == 0 and 0 or 2 ^ (v67 * 10 - 10), 100)
    local v69 = v61 * u18(v68, 1)
    local v70
    if v65 < 1 then
        v70 = v65 * v68
    else
        local v71 = v68 * 0.5
        v70 = v65 * (v71 > 1 and v71 and v71 or 1)
    end
    local v72 = u14(v69) * 0.3 + 0.7
    local v73
    if v58 == "Sine" then
        local v74 = v60 ^ 0.8
        local v75 = v70 * 2
        local v76 = v69 * v74
        local v77 = u14(v76)
        local v78 = u15(v76 * 0.1)
        local v79 = u14(v76 * 2)
        local v80 = u15(v76 * 3)
        local v81 = (v77 + v78 + v79 + v80) * 0.25
        local v82 = v81 * 0.5 + 0.5
        local v83 = v81 * v75
        local v84 = v82 * v75
        if v83 < v84 then
            v83 = v84 or v83
        end
        v73 = v62 * v83 * v72
    elseif v58 == "Noise" then
        v73 = u53(v69, v60, v70, v62, p55.WindOffset, 0, true) * v72
    else
        local v85 = v60 ^ 0.8
        local v86 = v70 * 2
        local v87 = v69 * v85
        local v88 = u14(v87)
        local v89 = u15(v87 * 0.1)
        local v90 = u14(v87 * 2)
        local v91 = u15(v87 * 3)
        local v92 = (v88 + v89 + v90 + v91) * 0.25
        local v93 = v92 * 0.5 + 0.5
        local v94 = v92 * v86
        local v95 = v93 * v86
        if v94 < v95 then
            v94 = v95 or v94
        end
        v73 = (v62 * v94 * v72 + u53(v69, v60, v70, v62, p55.WindOffset, 0.5, true) * v72) * 0.5
    end
    local v96 = p54.FreeLength
    return v73 / (v96 < 0.01 and 0.01 or v96) * (v57.WindInfluence * (v60 * 0.01) * (u19(p54.HeirarchyLength, 1, 10) * 0.1)) * p54.Weight
end
local u98 = {}
u98.__index = u98
function u98.new(u99, p100, p101) --[[ Line: 428 ]]
    --[[
    Upvalues:
        [1] = u98
        [2] = u4
    --]]
    local v102 = u99.Parent:IsA("Bone") and u99.Parent.TransformedWorldCFrame or p101.CFrame
    local v103 = {
        ["Bone"] = u99,
        ["FreeLength"] = -1,
        ["Weight"] = 0.7,
        ["ParentIndex"] = -1,
        ["HeirarchyLength"] = 0,
        ["Transform"] = u99.TransformedWorldCFrame:ToObjectSpace(v102):Inverse(),
        ["LocalTransform"] = u99.TransformedCFrame:ToObjectSpace(p100.TransformedCFrame):Inverse(),
        ["RootPart"] = p101,
        ["RootBone"] = p100,
        ["Radius"] = 0,
        ["Friction"] = 0,
        ["RotationLimit"] = 0,
        ["Force"] = nil,
        ["Gravity"] = nil,
        ["SolvedAnimatedCFrame"] = false,
        ["HasChild"] = false,
        ["AnimatedWorldCFrame"] = u99.TransformedWorldCFrame,
        ["StartingCFrame"] = u99.TransformedCFrame,
        ["TransformOffset"] = CFrame.identity,
        ["LocalTransformOffset"] = CFrame.identity,
        ["RestPosition"] = Vector3.new(0, 0, 0),
        ["CalculatedWorldCFrame"] = u99.TransformedWorldCFrame,
        ["Position"] = u99.TransformedWorldCFrame.Position,
        ["LastPosition"] = u99.TransformedWorldCFrame.Position,
        ["WeldPosition"] = Vector3.new(0, 0, 0),
        ["WeldCFrame"] = CFrame.identity,
        ["ActiveWeld"] = false,
        ["RigidWeld"] = false,
        ["Anchored"] = false,
        ["AxisLocked"] = table.create(3, false),
        ["XAxisLimits"] = NumberRange.new((-1 / 0), (1 / 0)),
        ["YAxisLimits"] = NumberRange.new((-1 / 0), (1 / 0)),
        ["ZAxisLimits"] = NumberRange.new((-1 / 0), (1 / 0)),
        ["IsSkippingUpdates"] = false,
        ["CollisionHits"] = {},
        ["_collisionClosestPoints"] = table.create(8),
        ["_collisionNormals"] = table.create(8),
        ["_collisionCount"] = 0
    }
    local v104 = u98
    local u105 = setmetatable(v103, v104)
    u105.AttributeConnection = u99.AttributeChanged:Connect(function(_) --[[ Line: 483 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u99
            [3] = u105
        --]]
        for v106, v109 in u4.GatherBoneSettings(u99) do
            local v108 = u105
            if v109 == "\194\172" or not v109 then
                local v109 = nil
            end
            v108[v106] = v109
        end
    end)
    return u105
end
function u98.ClipVelocity(p110, p111, p112) --[[ Line: 500 ]]
    p110.LastPosition = p110.LastPosition * (Vector3.new(1, 1, 1) - p112) + p111 * p112
end
function u98.PreUpdate(p113, p114) --[[ Line: 506 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u25
        [3] = u30
        [4] = u39
    --]]
    local v115 = p113.ParentIndex
    p113.SolvedAnimatedCFrame = true
    local v116 = p113.ParentIndex
    local v117 = p113.Bone
    local v118
    if v116 < 1 then
        if u24[v117] == shared.FrameCounter then
            v118 = u25[v117]
        else
            local v119 = v117.Parent
            local v120
            if v119:IsA("Bone") then
                v120 = u30(v119)
            else
                v120 = v119.CFrame
            end
            v118 = v120 * v117.TransformedCFrame
            u24[v117] = shared.FrameCounter
            u25[v117] = v118
        end
    else
        local v121 = p114.Bones[v116]
        if not v121.SolvedAnimatedCFrame then
            v121.AnimatedWorldCFrame = u39(p114, v121)
        end
        v118 = v121.AnimatedWorldCFrame * v117.TransformedCFrame
    end
    p113.AnimatedWorldCFrame = v118
    local v122 = p113.Bone:FindFirstChild("SmartWeld")
    p113.ActiveWeld = false
    if v122 and v122:IsA("ObjectValue") then
        local v123 = v122.Value
        p113.RigidWeld = v122:GetAttribute("Rigid") == true
        if v123 then
            if v123:IsA("Attachment") then
                p113.WeldPosition = v123.WorldPosition
                p113.WeldCFrame = v123.WorldCFrame
                p113.ActiveWeld = true
            elseif v123:IsA("BasePart") then
                p113.WeldPosition = v123.Position
                p113.WeldCFrame = v123.CFrame
                p113.ActiveWeld = true
            end
        end
    end
    if v115 < 1 then
        p113.Anchored = true
    end
    if p113.Bone ~= p113.RootBone then
        p113.TransformOffset = p114.Bones[v115].AnimatedWorldCFrame * p113.Transform
        goto l33
    end
    local v124 = p113.Bone.Parent
    if v124:IsA("Bone") then
        if u24[v124] == shared.FrameCounter then
            v127 = u25[v124]
        else
            local v125 = v124.Parent
            local v126
            if v125:IsA("Bone") then
                v126 = u30(v125)
            else
                v126 = v125.CFrame
            end
            v127 = v126 * v124.TransformedCFrame
            u24[v124] = shared.FrameCounter
            u25[v124] = v127
        end
        if v127 then
            ::l32::
            p113.TransformOffset = v127 * p113.Transform
            ::l33::
            p113.LocalTransformOffset = p114._cachedRootBoneCFrame * p113.LocalTransform
            return
        end
    end
    local v127 = p114._cachedRootPartCFrame
    goto l32
end
function u98.StepPhysics(p128, p129, p130, p131) --[[ Line: 552 ]]
    --[[
    Upvalues:
        [1] = u97
    --]]
    if p128.Anchored then
        local v132 = p128.AnimatedWorldCFrame.Position
        p128.LastPosition = v132
        p128.Position = v132
    else
        if p128.Force or p128.Gravity then
            p130 = (p128.Gravity or p129.Settings.Gravity) + (p128.Force or p129.Settings.Force)
        end
        local v133 = p129.Settings
        local v134 = p128.Position
        local v135 = (v134 - p128.LastPosition) / p131
        if v135.Magnitude > 50 then
            v135 = v135.Unit * 50
        end
        local v136 = u97(p128, p129, v135)
        p128.LastPosition = v134
        p128.Position = v134 + v135 * (1 - v133.Damping) * p131 + (p130 + p129.ObjectAcceleration * v133.Inertia) * (p131 * p131) + v136
    end
end
function u98.Constrain(p137, p138, p139, p140) --[[ Line: 584 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u7
        [3] = u12
        [4] = u8
        [5] = u10
        [6] = u6
        [7] = u11
    --]]
    if not p137.Anchored then
        local v141 = p137.Position
        local v142 = p138._cachedRootPartCFrame
        local v143 = p137.LastPosition
        local v144 = u9(p137, v141, v143)
        if #p139 ~= 0 then
            v144 = u7(p137, v144, p139)
        end
        local v145 = p138.Settings.Constraint
        local v146
        if v145 == "Spring" then
            v146 = u12(p137, v144, nil, p138, p140)
        elseif v145 == "Distance" then
            v146 = u8(p137, v144, p138)
        elseif v145 == "Rope" then
            v146 = u10(p137, v144, p138)
        else
            v146 = p137.AnimatedWorldCFrame.Position
        end
        local v147 = u11(p137, u6(p137, v146, v143, v142), p138)
        if p137.ActiveWeld then
            if p137.RigidWeld then
                v147 = p137.WeldPosition
            else
                v147 = u12(p137, v147, p137.WeldPosition, p138, p140)
            end
        end
        p137.Friction = 0
        local v148 = p137.CollisionHits
        for v149 = 1, #v148 do
            local v150 = p137.RootPart
            local v151 = v148[v149]
            local v152 = v150.CurrentPhysicalProperties
            local v153 = v151.CurrentPhysicalProperties
            local v154 = v152.Friction
            local v155 = v152.FrictionWeight
            local v156 = v153.Friction
            local v157 = v153.FrictionWeight
            local v158 = (v154 * v155 + v156 * v157) / (v155 + v157)
            if p137.Friction < v158 then
                p137.Friction = v158
            end
        end
        p137.Position = v147
    end
end
function u98.SkipUpdate(p159) --[[ Line: 638 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v160 = p159.AnimatedWorldCFrame.Position
    if not p159.IsSkippingUpdates and u2.RESET_TRANSFORM_ON_SKIP then
        p159.CalculatedWorldCFrame = p159.AnimatedWorldCFrame
        p159.IsSkippingUpdates = true
    end
    p159.LastPosition = v160 + (p159.LastPosition - p159.Position)
    p159.Position = v160
end
function u98.SolveTransform(p161, p162, p163) --[[ Line: 653 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u22
        [3] = u17
        [4] = u13
    --]]
    local v164 = p161.ParentIndex
    if v164 >= 1 then
        p161.IsSkippingUpdates = false
        local v165 = p162.Bones[v164]
        local v166 = v165.Bone
        if v165 and v166 then
            local v167 = v165.TransformOffset
            local v168 = u4.GetRotationBetween(v167.UpVector, p161.Position - v165.Position).Rotation * v167.Rotation
            if v165.ActiveWeld and v165.RigidWeld then
                v165.CalculatedWorldCFrame = v165.WeldCFrame
            else
                v165.CalculatedWorldCFrame = v166.WorldCFrame:Lerp(u22(v165.Position) * v168, (u17(1 - 0.00001 ^ p163, 1)))
            end
            local v169 = u13
            local v170 = v165.CalculatedWorldCFrame.Position
            v169(v170 == v170, warn, "If you see this report this as a bug, (NaN Calc world cframe)")
        end
    end
end
function u98.ApplyTransform(p171, p172) --[[ Line: 681 ]]
    p171.SolvedAnimatedCFrame = false
    if p171.ParentIndex >= 1 then
        local v173 = p172.Bones[p171.ParentIndex]
        local v174 = v173.Bone
        if v173 and v174 then
            if v173.Anchored and not p172.Settings.AnchorsRotate then
                v174.WorldCFrame = v173.TransformOffset
                return
            end
            if v173.Anchored then
                v174.WorldCFrame = CFrame.new(v173.Position) * v173.CalculatedWorldCFrame.Rotation
                return
            end
            v174.WorldCFrame = v173.CalculatedWorldCFrame
        end
    end
end
function u98.DrawDebug(p175, p176, p177, p178, p179, p180, p181) --[[ Line: 722 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v182 = Color3.fromRGB(255, 0, 0)
    local v183 = Color3.fromRGB(255, 94, 0)
    local v184 = Color3.fromRGB(234, 1, 255)
    local v185 = Color3.fromRGB(0, 255, 255)
    local v186 = Color3.fromRGB(255, 0, 0)
    local v187 = Color3.fromRGB(0, 255, 0)
    local v188 = Color3.fromRGB(0, 0, 255)
    local v189 = Color3.fromRGB(0, 183, 255)
    local v190 = Color3.fromRGB(255, 0, 0)
    local v191 = Color3.fromRGB(0, 255, 0)
    local v192 = Color3.fromRGB(0, 0, 255)
    local v193 = Color3.fromRGB(28, 41, 224)
    local v194 = Color3.fromRGB(255, 27, 27)
    local v195 = 1
    local v196 = p175.AnimatedWorldCFrame
    local v197 = v196.Position
    local v198 = CFrame.new(p175.Position)
    local v199 = CFrame.new(p175.LastPosition)
    if p179 then
        u3.PushProperty("AlwaysOnTop", false)
        u3.PushProperty("Color3", v182)
        u3.Sphere:Draw(v198, p175.Radius, 10, 360)
        u3.PushProperty("Color3", v183)
        u3.Sphere:Draw(v199, p175.Radius, 10, 360)
        u3.PushProperty("Color3", v184)
        u3.Ray:Draw(p175.Position, p175.LastPosition)
    end
    if p180 and not p175.Anchored then
        local v200 = p175.AxisLocked[1]
        local v201 = p175.AxisLocked[2]
        local v202 = p175.AxisLocked[3]
        local v203 = p175.RootPart
        local v204 = v203.CFrame:PointToObjectSpace(v197)
        local v205 = v203.CFrame.RightVector
        local v206 = v203.CFrame.UpVector
        local v207 = v203.CFrame.LookVector
        if not v200 then
            u3.PushProperty("Color3", v190)
            u3.Arrow:Draw(v197 - v205 * 2, v197 + v205 * 2, 0.05, 0.15, 9)
            local v208 = p175.XAxisLimits.Min - v204.X
            local v209 = p175.XAxisLimits.Max - v204.X
            u3.Plane:Draw(v197 + v205 * v208, v205, Vector3.new(5, 5, 0))
            u3.Plane:Draw(v197 + v205 * v209, v205, Vector3.new(5, 5, 0))
        end
        if not v201 then
            u3.PushProperty("Color3", v191)
            u3.Arrow:Draw(v197 - v206 * 2, v197 + v206 * 2, 0.05, 0.15, 9)
            local v210 = p175.YAxisLimits.Min - v204.Y
            local v211 = p175.YAxisLimits.Max - v204.Y
            u3.Plane:Draw(v197 + v206 * v210, v206, Vector3.new(5, 5, 0))
            u3.Plane:Draw(v197 + v206 * v211, v206, Vector3.new(5, 5, 0))
        end
        if not v202 then
            u3.PushProperty("Color3", v192)
            u3.Arrow:Draw(v197 - v207 * 2, v197 + v207 * 2, 0.05, 0.15, 9)
            local v212 = p175.ZAxisLimits.Min - v204.Z
            local v213 = p175.ZAxisLimits.Max - v204.Z
            u3.Plane:Draw(v197 - v207 * v212, v207, Vector3.new(5, 5, 0))
            u3.Plane:Draw(v197 - v207 * v213, v207, Vector3.new(5, 5, 0))
        end
    end
    if p178 then
        u3.PushProperty("Color3", v185)
        u3.Sphere:Draw(v196, 0.08, 5, 360)
        u3.PushProperty("Color3", v186)
        u3.VolumeArrow:Draw(v197, v197 + v196.LookVector * 0.25, 0.005, 0.015, 0.05, true)
        u3.PushProperty("Color3", v187)
        u3.VolumeArrow:Draw(v197, v197 + v196.UpVector * 0.25, 0.005, 0.015, 0.05, true)
        u3.PushProperty("Color3", v188)
        u3.VolumeArrow:Draw(v197, v197 + v196.RightVector * 0.25, 0.005, 0.015, 0.05, true)
    end
    if p177 and not p175.Anchored then
        local v214 = p175._collisionClosestPoints
        local v215 = p175._collisionNormals
        for v216 = 1, p175._collisionCount do
            u3.PushProperty("Color3", v193)
            u3.Sphere:Draw(CFrame.new(v214[v216]), 0.08, 5, 360)
            u3.PushProperty("Color3", v194)
            u3.Arrow:Draw(v214[v216], v214[v216] + v215[v216] * 0.5, 0.05, 0.15, 9)
        end
    end
    if p181 and (p175.RotationLimit < 180 and (p175.RotationLimit > 0 and (p175.ParentIndex > 0 and p175.HasChild))) then
        local v217 = 1
        local v218
        if p175.RotationLimit < 89.5 then
            local v219 = p175.RotationLimit
            local v220 = math.rad(v219)
            v218 = v195 * math.tan(v220)
        elseif p175.RotationLimit > 90 then
            local v221 = 180 - p175.RotationLimit
            local v222 = math.rad(v221)
            v218 = v195 * math.tan(v222)
            v217 = -1
        else
            v218 = 5
            v195 = 0
        end
        local v223 = math.min(v218, 5)
        local v224 = v223 == 5 and 0 or v195
        local v225 = (p175.Position - p176.Bones[p175.ParentIndex].Position).Unit * v217
        local v226 = CFrame.lookAt(v197 + v225 * (v224 * 0.5), v197 + -v225 * 500, v196.LookVector)
        u3.PushProperty("Color3", v189)
        u3.Cone:Draw(v226, v223, v224, 8 + v223 * 2)
    end
end
function u98.DrawOverlay(p227, p228) --[[ Line: 915 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    p228.Text((("Bone: %*"):format(p227.Bone.Name)))
    if u2.DEBUG_OVERLAY_BONE_INFO or u2.DEBUG_OVERLAY_BONE_NUMERICS then
        p228.Text((("Free Length: %*"):format(p227.FreeLength)))
        p228.Text((("Weight: %*"):format(p227.Weight)))
        p228.Text((("Parent Index: %*"):format(p227.ParentIndex)))
        p228.Text((("Heirarchy Length: %*"):format(p227.HeirarchyLength)))
        p228.Text((("Radius: %*"):format(p227.Radius)))
        p228.Text((("Friction: %*"):format(p227.Friction)))
        p228.Text((("Rotation Limit: %*"):format(p227.RotationLimit)))
    end
    if u2.DEBUG_OVERLAY_BONE_INFO or u2.DEBUG_OVERLAY_BONE_CONSTRAIN then
        p228.Text((("Anchored: %*"):format(p227.Anchored)))
        p228.Text((("Axis Locked: %*, %*, %*"):format(p227.AxisLocked[1], p227.AxisLocked[2], p227.AxisLocked[3])))
        p228.Text((("X Axis Limit: %*"):format(p227.XAxisLimits)))
        p228.Text((("Y Axis Limit: %*"):format(p227.YAxisLimits)))
        p228.Text((("Z Axis Limit: %*"):format(p227.ZAxisLimits)))
    end
    if u2.DEBUG_OVERLAY_BONE_INFO or u2.DEBUG_OVERLAY_BONE_WELD then
        p228.Text((("Active Weld: %*"):format(p227.ActiveWeld)))
        p228.Text((("Rigid Weld: %*"):format(p227.RigidWeld)))
        p228.Text((("Weld Position: %*"):format((string.format("%.3f, %.3f, %.3f", p227.WeldPosition.X, p227.WeldPosition.Y, p227.WeldPosition.Z)))))
    end
    if u2.DEBUG_OVERLAY_BONE_INFO or u2.DEBUG_OVERLAY_BONE_FORCES then
        local v229 = p227.Force and (string.format("%.3f, %.3f, %.3f", p227.Force.X, p227.Force.Y, p227.Force.Z) or "-, -, -") or "-, -, -"
        local v230 = p227.Gravity and string.format("%.3f, %.3f, %.3f", p227.Gravity.X, p227.Gravity.Y, p227.Gravity.Z) or "-, -, -"
        p228.Text((("Force: %*"):format(v229)))
        p228.Text((("Gravity: %*"):format(v230)))
    end
end
function u98.Destroy(p231) --[[ Line: 951 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u24
        [3] = u25
    --]]
    if u2.RESET_BONE_ON_DESTROY then
        task.synchronize()
        p231.Bone.CFrame = p231.StartingCFrame
    end
    p231.AttributeConnection:Disconnect()
    local v232 = p231.Bone
    u24[v232] = nil
    u25[v232] = nil
    table.clear(p231)
    setmetatable(p231, nil)
end
return u98