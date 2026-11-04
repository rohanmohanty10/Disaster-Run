 

local v1 = game.Players.LocalPlayer
local u2 = game.ReplicatedStorage:WaitForChild("Stats" .. v1.Name).Settings
local u3 = require(script.Graph)
local u4 = require(script.Range)
local u5 = require(script.Particles)
local u6 = require(script.Flipbook)
local u7 = script.Parent.Parent
local u8 = game:GetService("RunService")
local u9 = {
    ["Beam"] = {},
    ["EnabledParts"] = {}
}
_G.Part_Icles = _G.Part_Icles or {}
_G.Part_Icles.EnableAllowed = _G.Part_Icles.EnableAllowed or true
local u10 = u9.Beam
local u11 = {
    [Enum.NormalId.Top] = {
        ["vector"] = "UpVector",
        ["multiplier"] = 1
    },
    [Enum.NormalId.Bottom] = {
        ["vector"] = "UpVector",
        ["multiplier"] = -1
    },
    [Enum.NormalId.Front] = {
        ["vector"] = "LookVector",
        ["multiplier"] = 1
    },
    [Enum.NormalId.Back] = {
        ["vector"] = "LookVector",
        ["multiplier"] = -1
    },
    [Enum.NormalId.Left] = {
        ["vector"] = "RightVector",
        ["multiplier"] = -1
    },
    [Enum.NormalId.Right] = {
        ["vector"] = "RightVector",
        ["multiplier"] = 1
    }
}
local u53 = {
    [Enum.ParticleEmitterShape.Box] = function(p12, _) --[[ Line: 47 ]]
        local v13 = (math.random() * 2 - 1) * p12.Size.X / 2
        local v14 = (math.random() * 2 - 1) * p12.Size.Y / 2
        local v15 = (math.random() * 2 - 1) * p12.Size.Z / 2
        return Vector3.new(v13, v14, v15)
    end,
    [Enum.ParticleEmitterShape.Sphere] = function(p16, p17) --[[ Line: 53 ]]
        local v18 = p16.Size.X / 2
        local v19 = v18 * p17.ShapePartial
        local v20 = (math.random() * (v18 ^ 3 - v19 ^ 3) + v19 ^ 3) ^ 0.3333333333333333
        local v21 = math.random() * 2 * 3.141592653589793
        local v22 = math.random() * 2 - 1
        local v23 = math.acos(v22)
        local v24 = math.sin(v23) * math.cos(v21)
        local v25 = math.sin(v23) * math.sin(v21)
        local v26 = math.cos(v23)
        local v27 = Vector3.new(v24, v25, v26)
        return v27 * v20, CFrame.lookAt(Vector3.new(), -v27)
    end,
    [Enum.ParticleEmitterShape.Cylinder] = function(p28, p29) --[[ Line: 68 ]]
        local v30 = p28.Size.X / 2
        local v31 = p28.Size.Y
        local v32 = p29.ShapePartial
        local v33 = math.random()
        local v34 = math.sqrt(v33) * (1 - v32) + v32
        local v35 = math.random() * 2 * 3.141592653589793
        local v36 = v34 * v30 * math.cos(v35)
        local v37 = (math.random() * 2 - 1) * (v31 / 2)
        local v38 = v34 * v30 * math.sin(v35)
        local v39 = Vector3.new(v36, v37, v38)
        local v40
        if math.abs(v37) > v31 / 2 - 0.01 then
            local v41 = math.sign(v37)
            v40 = Vector3.new(0, v41, 0)
        else
            v40 = Vector3.new(v36, 0, v38).Unit
        end
        return v39, CFrame.lookAt(Vector3.new(), -v40)
    end,
    [Enum.ParticleEmitterShape.Disc] = function(p42, p43) --[[ Line: 87 ]]
        local v44 = p42.Size.X / 2
        local v45 = p43.ShapePartial
        local v46 = math.random()
        local v47 = math.sqrt(v46) * (1 - v45) + v45
        local v48 = math.random() * 2 * 3.141592653589793
        local v49 = v47 * v44 * math.cos(v48)
        local v50 = v47 * v44 * math.sin(v48)
        local v51 = Vector3.new(v49, 0, v50)
        local v52 = v51.Unit
        return v51, CFrame.lookAt(Vector3.new(), -v52)
    end
}
function u9.GetFolder(_) --[[ Line: 101 ]]
    if workspace.Terrain:FindFirstChild("EmittedPartsUsingPart_icle") then
        return workspace.Terrain.EmittedPartsUsingPart_icle
    end
    local v54 = Instance.new("Folder")
    v54.Name = "EmittedPartsUsingPart_icle"
    v54.Parent = workspace.Terrain
    return v54
end
function u10.Emit(_, p55) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u8
    --]]
    if p55:IsA("Beam") and p55:GetAttribute("Transformed") then
        local v56 = p55:FindFirstChild("Factors")
        if not v56 then
            return
        end
        local v57
        if workspace.Terrain:FindFirstChild("EmittedPartsUsingPart_icle") then
            v57 = workspace.Terrain.EmittedPartsUsingPart_icle
        else
            v57 = Instance.new("Folder")
            v57.Name = "EmittedPartsUsingPart_icle"
            v57.Parent = workspace.Terrain
        end
        local v58 = v56:FindFirstChild("Properties")
        local v59 = v56:FindFirstChild("GraphBlender")
        local u60 = v56:FindFirstChild("TotalKeyFrames")
        local v61 = v56:FindFirstChild("LifeTime")
        local u62 = p55:Clone()
        local v63 = {
            ["Brightness"] = v58:FindFirstChild("Brightness"),
            ["CurveSize0"] = v58:FindFirstChild("CurveSize0"),
            ["CurveSize1"] = v58:FindFirstChild("CurveSize1"),
            ["Width0"] = v58:FindFirstChild("Width0"),
            ["Width1"] = v58:FindFirstChild("Width1"),
            ["LightEmission"] = v58:FindFirstChild("LightEmission"),
            ["Segments"] = v58:FindFirstChild("Segments"),
            ["TextureLength"] = v58:FindFirstChild("TextureLength"),
            ["TextureSpeed"] = v58:FindFirstChild("TextureSpeed")
        }
        local u64 = {}
        for v65, v66 in pairs(v63) do
            if v66 then
                local v67 = v66.Size
                if not v67 or #v67.Keypoints <= 1 then
                    local v68 = u62[v65]
                    if v67 and #v67.Keypoints ~= 0 then
                        v68 = v67.Keypoints[1].Value
                    end
                    u62[v65] = v68
                    print(v65, ": is now", u62[v65], "or", v68)
                else
                    u64[v65] = {
                        ["Sequence"] = v67,
                        ["Seed"] = u3.GenerateSeeds(v67, 20)[math.random(1, 20)]
                    }
                end
            end
        end
        local v69 = v59:FindFirstChild("ColorGraphs")
        local v70 = v59:FindFirstChild("TransparencyGraphs")
        local u71 = u4.RandomValueFromRange(v61.Lifetime)
        local u72 = {}
        local u73 = {}
        for _, v74 in pairs(v70:GetChildren()) do
            table.insert(u72, v74)
        end
        for _, v75 in pairs(v69:GetChildren()) do
            table.insert(u73, v75)
        end
        table.sort(u72, function(p76, p77) --[[ Line: 195 ]]
            return p76.Name < p77.Name
        end)
        table.sort(u73, function(p78, p79) --[[ Line: 196 ]]
            return p78.Name < p79.Name
        end)
        local u80 = 1
        local u81 = u73[u80]
        local u82 = 1
        local u83 = u72[u82]
        u62.Enabled = true
        u62.Parent = v57
        task.spawn(function() --[[ Line: 211 ]]
            --[[
            Upvalues:
                [1] = u60
                [2] = u8
                [3] = u71
                [4] = u62
                [5] = u83
                [6] = u72
                [7] = u82
                [8] = u81
                [9] = u73
                [10] = u80
                [11] = u3
                [12] = u64
            --]]
            local u84 = tick()
            local u85 = 0
            local u86 = 0
            local u87 = 0
            local u88 = (not u60 or u60.Value <= 0) and 100 or u60.Value
            local u89 = nil
            u89 = u8.Heartbeat:Connect(function() --[[ Line: 224 ]]
                --[[
                Upvalues:
                    [1] = u84
                    [2] = u71
                    [3] = u62
                    [4] = u89
                    [5] = u88
                    [6] = u85
                    [7] = u83
                    [8] = u87
                    [9] = u72
                    [10] = u82
                    [11] = u81
                    [12] = u86
                    [13] = u73
                    [14] = u80
                    [15] = u3
                    [16] = u64
                --]]
                local v90 = tick() - u84
                local v91 = v90 / u71
                if v91 > 1 or not u62.Parent then
                    u89:Disconnect()
                    if u62 and u62.Parent then
                        u62:Destroy()
                    end
                else
                    local v92 = v91 * u88
                    local v93 = math.floor(v92)
                    if u85 < v93 then
                        u85 = v93
                        local v94 = u85 / u88
                        if u83 and u83.DurationOfBlend then
                            local v95 = u83.DurationOfBlend.Value
                            if u87 + v95 < v90 and u72[u82 + 1] then
                                u87 = u87 + v95
                                u82 = u82 + 1
                                u83 = u72[u82]
                            end
                            local v96 = u81.DurationOfBlend.Value
                            if u86 + v96 < v90 and u73[u80 + 1] then
                                u86 = u86 + v96
                                u80 = u80 + 1
                                u81 = u73[u80]
                            end
                            local v97 = u83.Transparency.Transparency
                            local v98 = u83.BlendSpeed.Transparency
                            u62.Transparency = u3.BlendGraphWithTime(u62.Transparency, v97, v98, v94)
                            local v99 = u81.Color.Color
                            local v100 = u81.BlendSpeed.Transparency
                            u62.Color = u3.BlendColorGraphWithTime(u62.Color, v99, v100, v94)
                        end
                        for v101, v102 in pairs(u64) do
                            u62[v101] = u3.QueryPointsWithTime(v94, v102.Sequence, v102.Seed)
                        end
                    end
                end
            end)
        end)
    end
end
function u10.EnableEmit(_, u103) --[[ Line: 281 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    if u103:IsA("Beam") and u103:GetAttribute("EmitDelay") then
        task.delay(u103:GetAttribute("EmitDelay"), function() --[[ Line: 284 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u103
            --]]
            u10:Emit(u103)
        end)
    end
end
function u9.Transform(_, p104) --[[ Line: 290 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p104:IsA("Beam") then
        u7.Layouts.Beam.Factors:Clone().Parent = p104
        p104:SetAttribute("Transformed", true)
        p104:SetAttribute("EmitCount", 1)
        p104:SetAttribute("EmitDuration", 0)
        p104:SetAttribute("EmitDelay", 0)
        p104:SetAttribute("IsEmitter", true)
    elseif p104:IsA("Part") or p104:IsA("MeshPart") then
        u7.Layouts.Part.Factors:Clone().Parent = p104
        p104:SetAttribute("Transformed", true)
        p104:SetAttribute("EmitCount", 0)
        p104:SetAttribute("EmitDuration", 0)
        p104:SetAttribute("EmitDelay", 0)
        p104:SetAttribute("IsEmitter", true)
    end
end
function u9.Emit(_, u105, u106) --[[ Line: 309 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u6
        [5] = u53
        [6] = u11
        [7] = u8
    --]]
    if u105:FindFirstChild("Factors") then
        local v107 = {
            [Enum.NormalId.Top] = u105.CFrame.UpVector,
            [Enum.NormalId.Bottom] = -u105.CFrame.UpVector,
            [Enum.NormalId.Front] = u105.CFrame.LookVector,
            [Enum.NormalId.Back] = -u105.CFrame.LookVector,
            [Enum.NormalId.Left] = -u105.CFrame.RightVector,
            [Enum.NormalId.Right] = u105.CFrame.RightVector
        }
        local u108 = u105:FindFirstChildOfClass("SpecialMesh")
        local u109 = u105:FindFirstChildOfClass("Decal")
        local u110 = u105:FindFirstChild("Factors")
        local u111 = u110:FindFirstChild("TotalKeyFrames")
        local v112 = u110:FindFirstChild("MeshFlipbooks")
        local u113 = u110:FindFirstChild("Main")
        local u114 = u110:FindFirstChild("VelocityVectored")
        local u115 = u110:FindFirstChild("Main")
        local v116 = u110:FindFirstChild("Size")
        local u117 = v116:FindFirstChild("X")
        local u118 = v116:FindFirstChild("Y")
        local u119 = v116:FindFirstChild("Z")
        local v120 = u110:FindFirstChild("Rotation")
        local v121 = v120:FindFirstChild("X")
        local v122 = v120:FindFirstChild("Y")
        local v123 = v120:FindFirstChild("Z")
        local v124 = u110:FindFirstChild("RotationSpeed")
        local u125 = v124:FindFirstChild("X")
        local u126 = v124:FindFirstChild("Y")
        local u127 = v124:FindFirstChild("Z")
        local u128 = u110:FindFirstChild("Main")
        local v129 = u3.GenerateSeeds(u115.Size, 20)
        local v130 = u3.GenerateSeeds(u117.Size, 20)
        local v131 = u3.GenerateSeeds(u118.Size, 20)
        local v132 = u3.GenerateSeeds(u119.Size, 20)
        local v133 = u3.GenerateSeeds(u125.Squash, 20)
        local v134 = u3.GenerateSeeds(u126.Squash, 20)
        local v135 = u3.GenerateSeeds(u127.Squash, 20)
        local v136 = u3.GenerateSeeds(u128.Squash, 20)
        local v137 = u3.GenerateSeeds(u113.Transparency, 20)
        local v138 = math.random(1, 20)
        local u139 = v129[v138]
        local u140 = v130[v138]
        local u141 = v131[v138]
        local u142 = v132[v138]
        local u143 = v133[v138]
        local u144 = v134[v138]
        local u145 = v135[v138]
        local u146 = v136[v138]
        local u147 = v137[v138]
        local u148 = u4.RandomValueFromRange(u113.Lifetime)
        local v149 = u4.RandomValueFromRange(v121.Rotation)
        local v150 = u4.RandomValueFromRange(v122.Rotation)
        local v151 = u4.RandomValueFromRange(v123.Rotation)
        u105.Locked = true
        u105:SetAttribute("IsEmitter", false)
        for _, v152 in u105:GetDescendants() do
            if v152:IsA("ParticleEmitter") then
                v152.Enabled = false
            end
        end
        for _, v153 in u105:GetChildren() do
            if v153:IsA("Attachment") then
                u5.EnableEmitChildrenAndRepeatForAttachments(v153)
            end
            u5.EnableEmitSingle(v153)
        end
        if u109 then
            u6.Flip(u113, v112, u109, u148)
        end
        local v154 = u113.ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut and u53[u113.Shape]
        if v154 then
            local v155, v156 = v154(u105, u113)
            if typeof(v156) == "CFrame" and u113.ShapeStyle == Enum.ParticleEmitterShapeStyle.Surface then
                local v157, v158, v159 = u105.CFrame:ToEulerAnglesXYZ()
                u105:PivotTo(CFrame.new((u105.CFrame * CFrame.new(v155)).Position) * v156 * CFrame.Angles(v157, v158, v159))
            else
                u105:PivotTo(CFrame.new((u105.CFrame * CFrame.new(v155)).Position) * u105.CFrame.Rotation)
            end
        end
        if u108 then
            u108.Scale = Vector3.new(0, 0, 0)
        else
            u105.Size = Vector3.new(0, 0, 0)
        end
        u105.CFrame = u105.CFrame * CFrame.Angles(math.rad(v149), math.rad(v150), (math.rad(v151)))
        local u160 = u105.Position
        local u161 = u113.EmissionDirection
        local u162
        if u114.Value == false then
            u162 = v107[u161]
        else
            local v163 = u11[u161] or u11[Enum.NormalId.Top]
            u162 = u105.CFrame[v163.vector] * v163.multiplier
        end
        local v164 = u113.SpreadAngle
        local v165, v166
        if v164.X > 0 or v164.Y > 0 then
            v165 = (math.random() * 2 - 1) * v164.X
            v166 = (math.random() * 2 - 1) * v164.Y
            u162 = (CFrame.lookAt(Vector3.new(), u162) * CFrame.Angles(math.rad(v165), math.rad(v166), 0)).LookVector
        else
            v165 = 0
            v166 = 0
        end
        local u167 = CFrame.Angles(math.rad(v165), math.rad(v166), 0)
        local _ = u162 * u3.QueryPointsWithTime(0.1, u128.Squash, u146)
        local u168 = u113.Acceleration
        local u169 = u106 and (u106 and u106.CFrame or CFrame.new()):ToObjectSpace(u105.CFrame) or u105.CFrame
        task.spawn(function() --[[ Line: 461 ]]
            --[[
            Upvalues:
                [1] = u111
                [2] = u8
                [3] = u148
                [4] = u110
                [5] = u105
                [6] = u3
                [7] = u115
                [8] = u139
                [9] = u117
                [10] = u140
                [11] = u118
                [12] = u141
                [13] = u119
                [14] = u142
                [15] = u125
                [16] = u143
                [17] = u126
                [18] = u144
                [19] = u127
                [20] = u145
                [21] = u128
                [22] = u146
                [23] = u113
                [24] = u147
                [25] = u168
                [26] = u160
                [27] = u162
                [28] = u106
                [29] = u169
                [30] = u108
                [31] = u109
                [32] = u114
                [33] = u167
                [34] = u11
                [35] = u161
            --]]
            local u170 = tick()
            local u171 = 0
            local u172 = (not u111 or (not u111.Value or u111.Value <= 0)) and 100 or u111.Value
            local u173 = nil
            u173 = u8.Heartbeat:Connect(function(u174) --[[ Line: 470 ]]
                --[[
                Upvalues:
                    [1] = u170
                    [2] = u148
                    [3] = u171
                    [4] = u172
                    [5] = u110
                    [6] = u105
                    [7] = u173
                    [8] = u3
                    [9] = u115
                    [10] = u139
                    [11] = u117
                    [12] = u140
                    [13] = u118
                    [14] = u141
                    [15] = u119
                    [16] = u142
                    [17] = u125
                    [18] = u143
                    [19] = u126
                    [20] = u144
                    [21] = u127
                    [22] = u145
                    [23] = u128
                    [24] = u146
                    [25] = u113
                    [26] = u147
                    [27] = u168
                    [28] = u160
                    [29] = u162
                    [30] = u106
                    [31] = u169
                    [32] = u108
                    [33] = u109
                    [34] = u114
                    [35] = u167
                    [36] = u11
                    [37] = u161
                --]]
                local u175 = (tick() - u170) / u148
                if u175 >= 1 or u172 <= u171 then
                    if u110:FindFirstChild("PartLife") == nil then
                        u105:Destroy()
                    else
                        task.delay(u110.PartLife.Value or 0, function() --[[ Line: 477 ]]
                            --[[
                            Upvalues:
                                [1] = u105
                            --]]
                            u105:Destroy()
                        end)
                    end
                    u173:Disconnect()
                else
                    local v176 = u175 * u172
                    local v177 = math.floor(v176)
                    if u171 < v177 then
                        u171 = v177
                        task.spawn(function() --[[ Line: 490 ]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u175
                                [3] = u115
                                [4] = u139
                                [5] = u117
                                [6] = u140
                                [7] = u118
                                [8] = u141
                                [9] = u119
                                [10] = u142
                                [11] = u125
                                [12] = u143
                                [13] = u126
                                [14] = u144
                                [15] = u127
                                [16] = u145
                                [17] = u128
                                [18] = u146
                                [19] = u113
                                [20] = u147
                                [21] = u168
                                [22] = u160
                                [23] = u162
                                [24] = u174
                                [25] = u106
                                [26] = u169
                                [27] = u105
                                [28] = u108
                                [29] = u109
                                [30] = u114
                                [31] = u167
                                [32] = u11
                                [33] = u161
                            --]]
                            local v178 = u3.QueryPointsWithTime(u175, u115.Size, u139)
                            local v179 = u3.QueryPointsWithTime(u175, u117.Size, u140)
                            local v180 = u3.QueryPointsWithTime(u175, u118.Size, u141)
                            local v181 = u3.QueryPointsWithTime(u175, u119.Size, u142)
                            local v182 = u3.QueryPointsWithTime(u175, u125.Squash, u143)
                            local v183 = u3.QueryPointsWithTime(u175, u126.Squash, u144)
                            local v184 = u3.QueryPointsWithTime(u175, u127.Squash, u145)
                            local v185 = u3.QueryPointsWithTime(u175, u128.Squash, u146)
                            local v186 = u3.QueryPointsWithTime(u175, u113.Transparency, u147)
                            local v187 = u3.QueryColorPointWithTime(u175, u113.Color)
                            local v188 = u175
                            local v189 = u168 * v188
                            local v190 = -u113.Drag * v188
                            local v191 = u160 + u162 * (v185 * math.exp(v190)) * (u174 * 10) + v189 * (u174 * 10)
                            local v192 = CFrame.Angles(math.rad(v182), math.rad(v183), (math.rad(v184)))
                            local v193 = v191 - u160
                            local v194 = u106 and u106.CFrame or CFrame.new()
                            local v195 = v194:VectorToObjectSpace(v193)
                            u169 = CFrame.new(v195) * u169
                            u105.CFrame = v194 * u169
                            u105.CFrame = u105.CFrame * v192
                            u160 = u105.Position
                            if u108 then
                                u108.Scale = Vector3.new(v179, v180, v181)
                            else
                                u105.Size = Vector3.new(v179, v180, v181)
                            end
                            if u109 then
                                u109.Transparency = v186
                                u109.Color3 = Color3.fromRGB(v187.R * 255 * v178, v187.G * 255 * v178, v187.B * 255 * v178)
                            else
                                u105.Transparency = v186
                                u105.Color = v187
                            end
                            if u114.Value == true then
                                local v196 = u105.CFrame * u167
                                local v197 = u11[u161] or u11[Enum.NormalId.Top]
                                u162 = v196[v197.vector] * v197.multiplier
                            end
                        end)
                    end
                end
            end)
        end)
    end
end
function u9.Enable(u198, u199, u200) --[[ Line: 569 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    if u199:FindFirstChild("Factors") then
        _G.Part_Icles.EnableAllowed = false
        local v201 = u199:FindFirstChild("Factors")
        local u202 = v201:FindFirstChild("Main")
        local u203 = v201:FindFirstChild("Enabled")
        local u204 = v201:FindFirstChild("EnableWithRespectToEnable")
        local u205 = u9:GetFolder()
        if u198.EnabledParts[u199] then
            task.cancel(u198.EnabledParts[u199])
            u198.EnabledParts[u199] = nil
        end
        u198.EnabledParts[u199] = task.spawn(function() --[[ Line: 585 ]]
            --[[
            Upvalues:
                [1] = u198
                [2] = u199
                [3] = u203
                [4] = u204
                [5] = u200
                [6] = u205
                [7] = u202
            --]]
            if u203.Value then
                if u204 and u204.Value == true then
                    while u203.Value == true do
                        u199 = u199:Clone()
                        u198:Emit(u199, u200)
                        u199.Parent = u205
                        task.wait(1 / u202.Rate)
                    end
                    _G.Part_Icles.EnableAllowed = true
                else
                    while u203.Value == true do
                        local v206 = u199:Clone()
                        u198:Emit(v206, u200)
                        v206.Parent = u205
                        task.wait(1 / u202.Rate)
                    end
                    _G.Part_Icles.EnableAllowed = true
                end
                _G.Part_Icles.EnableAllowed = true
                u198.EnabledParts[u199] = nil
            else
                _G.Part_Icles.EnableAllowed = true
                u198.EnabledParts[u199] = nil
            end
        end)
    else
        warn(u199.Name .. "- is not Transformed")
    end
end
function u9.EnableEmit(u207, u208) --[[ Line: 621 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
    --]]
    local v209 = u208:FindFirstChild("Factors")
    if v209 then
        if u208:IsA("Beam") then
            u10:EnableEmit(u208)
            return
        end
        local v210 = u208:GetAttribute("EmitCount") or 0
        local v211 = u208:GetAttribute("EmitDelay") or 0
        local u212 = u208:GetAttribute("EmitDuration") or 0
        local u213 = v209:FindFirstChild("Enabled")
        local u214 = u207:GetFolder()
        local u215 = {}
        if v210 > 0 then
            local v216 = v210 * u2.ParticleEmitRate.Value
            local v217 = math.min(v216, 1)
            v210 = math.ceil(v217)
        end
        for v218 = 1, v210 do
            u215[v218] = u208:Clone()
        end
        task.delay(v211, function() --[[ Line: 643 ]]
            --[[
            Upvalues:
                [1] = u215
                [2] = u207
                [3] = u214
                [4] = u212
                [5] = u213
                [6] = u208
            --]]
            for _, v219 in u215 do
                u207:Emit(v219)
                v219.Parent = u214
                u207:EnableEmitChildren(v219)
            end
            if u212 > 0 then
                u213.Value = true
                u207:Enable(u208)
                task.wait(u212)
                u213.Value = false
            end
        end)
    end
end
function u9.EnableEmitChildren(u220, u221) --[[ Line: 660 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
    --]]
    for _, u222 in u221:GetChildren() do
        if u222:GetAttribute("Transformed") then
            local v223 = u222:FindFirstChild("Factors")
            if v223 then
                if u222:IsA("Beam") then
                    u10:EnableEmit(u222)
                else
                    local v224 = (u222:GetAttribute("EmitCount") or 0) * u2.ParticleEmitRate.Value
                    local v225 = u222:GetAttribute("EmitDelay") or 0
                    local u226 = u222:GetAttribute("EmitDuration") or 0
                    local u227 = v223:FindFirstChild("Enabled")
                    local u228 = u220:GetFolder()
                    local u229 = {}
                    for v230 = 1, v224 do
                        u229[v230] = u222:Clone()
                    end
                    task.delay(v225, function() --[[ Line: 679 ]]
                        --[[
                        Upvalues:
                            [1] = u229
                            [2] = u220
                            [3] = u221
                            [4] = u222
                            [5] = u228
                            [6] = u226
                            [7] = u227
                            [8] = u222
                        --]]
                        for _, v231 in u229 do
                            u220:Emit(v231, u221)
                            u220:EnableEmitChildren(v231, u222)
                            v231.Parent = u228
                        end
                        if u226 > 0 then
                            u227.Value = true
                            u220:Enable(u222, u221)
                            task.wait(u226)
                            u227.Value = false
                        end
                    end)
                end
            end
        end
    end
end
function u9._RecurCheck(p232, p233) --[[ Line: 697 ]]
    for _, v234 in p233:GetChildren() do
        if v234:GetAttribute("Transformed") then
            p232:EnableEmit(v234)
        else
            p232:_RecurCheck(v234)
        end
    end
end
function u9.AbsoluteEmit(p235, p236) --[[ Line: 706 ]]
    if p236:GetAttribute("Transformed") then
        p235:EnableEmit(p236)
    else
        p235:_RecurCheck(p236)
    end
end
return u9