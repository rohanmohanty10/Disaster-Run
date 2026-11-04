 

game:FindService("Lighting")
local u1 = game:GetService("CollectionService")
local v2 = script:WaitForChild("Dependencies")
local v3 = script:WaitForChild("Components")
local v4 = require(v2.Config)
local u5 = require(v2:WaitForChild("UnitConversion"))
local u6 = require(v2:WaitForChild("DefaultSettings"))
local u7 = require(v3:WaitForChild("ParticleTree"))
local u8 = require(v3:WaitForChild("Particle"))
local u9 = require(v2:WaitForChild("SettingsMath"))
local u10 = require(v2:WaitForChild("Utilities"))
local u11 = Random.new()
local u12 = v4.Debug
local u13
if u12 then
    u13 = Instance.new("Model")
    u13.Name = "SMARTBONE_DEBUGFOLDER"
    local v14 = Instance.new("Highlight")
    v14.FillColor = Color3.new(1, 0, 0)
    v14.OutlineTransparency = 1
    v14.FillTransparency = 0
    v14.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    v14.Enabled = true
    v14.Parent = u13
    u13.Parent = workspace
else
    u13 = nil
end
local u15 = u1:GetTagged("SmartBone")
local u16 = {}
local u17 = {}
u17.__index = u17
function u17.new(p18, p19) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u5
        [3] = u17
        [4] = u6
    --]]
    local v20 = {
        ["ID"] = u11:NextInteger(1, 10000000),
        ["RootPart"] = p18,
        ["Time"] = 0,
        ["ParticleTrees"] = {},
        ["Connections"] = {},
        ["RootList"] = p19
    }
    local v21 = u5.Convert
    local v22 = p18.Size.X
    v20.ObjectScale = v21(math.abs(v22), "Millimeter")
    v20.WindPreviousPosition = Vector3.new(0, 0, 0)
    v20.Removed = false
    v20.RemovedEvent = Instance.new("BindableEvent")
    v20.InRange = false
    v20.Settings = {}
    v20.BoxColliders = {}
    local v23 = u17
    local v24 = setmetatable(v20, v23)
    for v25, v26 in u6 do
        v24.Settings[v25] = p18:GetAttribute(v25) or v26
    end
    v24.Settings.BlendWeight = 1
    local v27 = v24.Settings
    local v28 = v24.Settings.UpdateRate + 0.1
    v27.UpdateRate = math.floor(v28)
    v24:Init()
    v24:UpdateParameters(v24.Settings)
    if not p18:GetAttribute("IgnoreCollisions") then
        v24:DetermineCharacterBoxes()
    end
    return v24
end
function u17.DetermineCharacterBoxes(p29) --[[ Line: 148 ]]
    if not p29.BoxColliders then
        return
    end
    table.clear(p29.BoxColliders)
    local v30 = p29.RootPart
    if not v30 then
        return
    end
    local v31 = nil
    while v30 ~= workspace do
        v30 = v30.Parent
        if not v30 then
            break
        end
        if v30:FindFirstChild("Humanoid") then
            v31 = v30.Humanoid
            break
        end
    end
    if v31 then
        for _, v32 in v30:GetChildren() do
            if v32:IsA("Part") and v32.Name ~= "HumanoidRootPart" then
                local v33 = p29.BoxColliders
                table.insert(v33, v32)
            end
        end
    end
end
function u17.Init(u34) --[[ Line: 180 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    local v35 = u34.RootPart
    u16[u34.ID] = u34
    local function v37() --[[ Line: 183 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        local v36 = workspace.GlobalWind.Unit
        u34:UpdateParameters("WindDirection", (v36.X ~= v36.X or (v36.X < -1024 or v36.X > 1024)) and Vector3.new(0, 0, 0) or v36)
        u34:UpdateParameters("WindSpeed", workspace.GlobalWind.Magnitude)
    end
    v37()
    u34.Connections.WindDirectionChange = workspace:GetPropertyChangedSignal("GlobalWind"):ConnectParallel(v37)
    for _, v38 in v35:GetDescendants() do
        if v38:IsA("Bone") and (v38.Parent:IsA("Bone") and #v38:GetChildren() == 0) then
            local v39 = v38.WorldCFrame + v38.WorldCFrame.UpVector.Unit * (v38.WorldPosition - v38.Parent.WorldPosition).Magnitude
            local v40 = Instance.new("Bone")
            v40.Name = v38.Name .. "_Tail"
            v40.Parent = v38
            v40.WorldCFrame = v39
        end
    end
    for _, v41 in u34.RootList do
        u34:AppendParticleTree(v41)
    end
    for _, v42 in u34.ParticleTrees do
        u34:AppendParticles(v42, v42.Root, 0, 0)
    end
end
function u17.AppendParticleTree(p43, p44) --[[ Line: 230 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v45 = p43.ParticleTrees
    local v46 = u7.new
    local v47 = p43.RootPart
    local v48 = p43.Settings.Gravity
    table.insert(v45, v46(p44, v47, v48))
end
function u17.AppendParticles(p49, p50, p51, p52, p53) --[[ Line: 234 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u12
        [3] = u13
        [4] = u10
    --]]
    local v54 = p49.Settings
    local v55 = u8.new(p51, p50.Root, p49.RootPart, v54)
    local v56 = p51.WorldPosition
    local v57 = p51.WorldPosition
    v55.Position = v56
    v55.LastPosition = v57
    v55.ParentIndex = p52
    v55.BoneLength = p53
    v55.HeirarchyLength = 0
    if u12 then
        v55.DebugPart = Instance.new("Part")
        v55.DebugPart.Size = Vector3.new(0.1, 0.1, 0.1)
        v55.DebugPart.Anchored = true
        v55.DebugPart.CanCollide = false
        v55.DebugPart.CastShadow = false
        v55.DebugPart.CanTouch = false
        v55.DebugPart.CanQuery = false
        v55.DebugPart.Color = Color3.new(1, 0, 0)
        v55.DebugPart.Parent = u13
    end
    if p52 >= 1 then
        p53 = (p50.Particles[p52].Bone.WorldPosition - v55.Position).Magnitude
        v55.BoneLength = p53
        v55.Weight = p53 * 0.7
        local v58 = u10.GetHierarchyLength(p51, p50.Root)
        if v58 then
            v55.HeirarchyLength = v58
        end
    end
    if v55.HeirarchyLength <= v54.AnchorDepth then
        v55.Anchored = true
    end
    local v59 = p50.Particles
    table.insert(v59, v55)
    local v60 = #p50.Particles
    for _, v61 in p51:GetChildren() do
        if v61:IsA("Bone") then
            p49:AppendParticles(p50, v61, v60, p53)
        end
    end
end
function u17.UpdateParameters(p62, p63, p64) --[[ Line: 278 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    if p62.Settings[p63] then
        local v65 = p62.Settings
        if u9[p63] then
            p64 = u9[p63](p64)
        end
        v65[p63] = p64
    end
end
function u17.PreUpdate(_, p66) --[[ Line: 283 ]]
    local v67 = p66.RootPart
    local v68 = p66.Root
    p66.ObjectMove = v67.Position - p66.ObjectPreviousPosition
    p66.ObjectPreviousPosition = v67.Position
    p66.RestGravity = v68.CFrame:PointToWorldSpace(p66.LocalGravity)
    for _, v69 in p66.Particles do
        v69.LastTransformOffset = v69.TransformOffset
        if v69.Bone == v69.Root then
            v69.TransformOffset = v67.CFrame * v69.RootTransform
        else
            v69.TransformOffset = v68.WorldCFrame * v69.Transform
        end
        v69.LocalTransformOffset = v68.CFrame * v69.LocalTransform
    end
end
function u17.UpdateParticles(p70, p71, p72, p73) --[[ Line: 304 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    local v74 = p70.Settings
    local v75 = v74.Damping
    local v76 = v74.Gravity
    local v77 = v74.Gravity.Unit
    local v78 = p71.RestGravity:Dot(v77)
    local v79 = (v76 - v77 * math.max(v78, 0) + v74.Force) * (p70.ObjectScale * p72)
    local v80 = p73 == 0 and (p71.ObjectMove or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0)
    for _, v81 in p71.Particles do
        if v81.ParentIndex >= 1 and not v81.Anchored then
            local v82
            if v74.WindInfluence > 0 then
                local v83 = p71.WindOffset + (os.clock() - v81.HeirarchyLength / 5) + (v81.TransformOffset.Position - p71.Root.WorldPosition).Magnitude / 5 * v74.WindInfluence
                local v84 = v74.WindDirection.X
                local v85 = v74.WindDirection.X
                local v86 = v83 * v74.WindSpeed
                local v87 = v84 + v85 * math.sin(v86)
                local v88 = v74.WindDirection.Y
                local v89 = v83 * v74.WindSpeed
                local v90 = v88 + math.sin(v89) * 0.05
                local v91 = v74.WindDirection.Z
                local v92 = v74.WindDirection.X
                local v93 = v83 * v74.WindSpeed
                local v94 = v91 + v92 * math.sin(v93)
                local v95 = Vector3.new(v87, v90, v94) / v81.BoneLength * v74.WindInfluence
                local v96 = v74.WindStrength / 100
                local v97 = v81.HeirarchyLength
                v82 = v95 * (v96 * (math.clamp(v97, 1, 10) / 10)) * v81.Weight
                p70.WindPreviousPosition = v82
            else
                v82 = Vector3.new(0, 0, 0)
            end
            local v98 = v81.Position - v81.LastPosition
            local v99 = v80 * v74.Inertia
            v81.LastPosition = v81.Position + v99
            v81.Position = v81.Position + (v98 * (1 - v75) + v79 + v99 + v82)
            for _, v100 in p70.BoxColliders do
                local v101, v102, v103 = u10.BoxPointIntersection(v100.CFrame, v100.Size, v81.Position)
                if v101 then
                    v81.Position = v102 + v103 * 1.25
                    break
                end
            end
        else
            v81.LastPosition = v81.TransformOffset.Position
            v81.Position = v81.TransformOffset.Position
        end
    end
end
function u17.CorrectParticles(p104, p105, p106) --[[ Line: 367 ]]
    local v107 = p104.Settings
    local v108 = v107.Stiffness
    for _, v109 in p105.Particles do
        local v110 = p105.Particles[v109.ParentIndex]
        if v110 and (v109.ParentIndex >= 1 and not v109.Anchored) then
            local v111 = (v110.TransformOffset.Position - v109.TransformOffset.Position).Magnitude
            if v108 > 0 or v107.Elasticity > 0 then
                local v112 = (CFrame.new(v110.Position) * v110.TransformOffset.Rotation * CFrame.new(v109.LocalTransformOffset.Position)).Position
                local v113 = v112 - v109.Position
                v109.Position = v109.Position + v113 * (v107.Elasticity * p106)
                if v108 > 0 then
                    local v114 = v112 - v109.Position
                    local v115 = v114.Magnitude
                    local v116 = v111 * (1 - v108) * 2
                    if v116 < v115 then
                        v109.Position = v109.Position + v114 * ((v115 - v116) / v115)
                    end
                end
            end
            local v117 = v110.Position - v109.Position
            local v118 = v117.Magnitude
            if v118 > 0 then
                v109.Position = v109.Position + v117 * ((v118 - v111) / v118)
            end
        end
    end
end
function u17.SkipUpdateParticles(p119, p120) --[[ Line: 407 ]]
    for _, v121 in p120.Particles do
        if v121.ParentIndex >= 1 and not v121.Anchored then
            v121.LastPosition = v121.LastPosition + p120.ObjectMove
            v121.Position = v121.Position + p120.ObjectMove
            local v122 = p120.Particles[v121.ParentIndex]
            local v123 = (v122.TransformOffset.Position - v121.TransformOffset.Position).Magnitude
            local v124 = p119.Settings.Stiffness
            if v124 > 0 then
                local v125 = v122.Position + CFrame.lookAt(v122.Position, v121.Position).LookVector.Unit * (v122.Position - v121.Position).Magnitude - v121.Position
                local v126 = v125.Magnitude
                local v127 = v123 * (1 - v124) * 2
                if v127 < v126 then
                    v121.Position = v121.Position + v125 * ((v126 - v127) / v126)
                end
            end
            local v128 = v122.Position - v121.Position
            local v129 = v128.Magnitude
            if v123 < v129 then
                v121.Position = v121.Position + v128 * ((v129 - v123) / v129)
            end
        else
            v121.LastPosition = v121.TransformOffset.Position
            v121.Position = v121.TransformOffset.Position
        end
    end
end
function u17.CalculateTransforms(p130, p131, p132) --[[ Line: 445 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    if p130.InRange then
        for _, v133 in p131.Particles do
            if v133.ParentIndex >= 1 and not v133.Anchored then
                local v134 = p131.Particles[v133.ParentIndex]
                local v135 = v134.Bone
                if v134 and (v135 and (v135:IsA("Bone") and v135 ~= p131.Root)) then
                    local v136 = v134.LocalTransformOffset.Position
                    local v137 = v134.TransformOffset
                    local v138 = v137:PointToObjectSpace(v136)
                    local v139 = v133.Position - v134.Position
                    local v140 = u10.GetRotationBetween(v137.UpVector, v139, v138).Rotation * v137.Rotation
                    local v141 = 1 - 0.00001 ^ p132
                    v134.CalculatedWorldCFrame = v135.WorldCFrame:Lerp(CFrame.new(v134.Position) * v140, v141)
                end
            end
        end
    end
end
function u17.TransformBones(p142, p143) --[[ Line: 473 ]]
    if p142.InRange then
        for _, v144 in p143.Particles do
            if v144.ParentIndex >= 1 and not v144.Anchored then
                local v145 = p143.Particles[v144.ParentIndex]
                local v146 = v145.Bone
                if v145 and (v146 and (v146:IsA("Bone") and v146 ~= p143.Root)) then
                    if v145.Anchored and not p142.Settings.AnchorsRotate then
                        v146.WorldCFrame = v145.TransformOffset
                    else
                        v146.WorldCFrame = v145.CalculatedWorldCFrame
                    end
                end
            end
        end
    end
end
function u17.DEBUG(_, p147) --[[ Line: 494 ]]
    for _, v148 in p147.Particles do
        if v148 then
            v148.DebugPart.CFrame = CFrame.new(v148.Position)
        end
    end
end
function u17.RunLoop(p149, p150, p151, p152) --[[ Line: 502 ]]
    local v153 = p151 * 10
    local v154
    if p152 > 0 then
        local v155 = 1 / p152
        p149.Time = p149.Time + p151
        if v155 <= p149.Time then
            p149.Time = 0
            v154 = true
        else
            v154 = false
        end
    else
        v154 = true
    end
    if v154 then
        p149:UpdateParticles(p150, v153, 0)
        p149:CorrectParticles(p150, v153)
    else
        p149:SkipUpdateParticles(p150)
    end
end
function u17.ResetParticles(_, p156) --[[ Line: 525 ]]
    for _, v157 in p156.Particles do
        v157.LastPosition = v157.TransformOffset.Position
        v157.Position = v157.TransformOffset.Position
    end
end
function u17.ResetTransforms(_, p158) --[[ Line: 532 ]]
    for _, v159 in p158.Particles do
        local v160
        if v159.Bone == v159.Root then
            v160 = p158.RootPart.CFrame * v159.RootTransform
        else
            v160 = p158.Root.WorldCFrame * v159.Transform
        end
        v159.Bone.WorldCFrame = v160
    end
end
function u17.UpdateBones(p161, p162, p163) --[[ Line: 546 ]]
    for _, v164 in p161.ParticleTrees do
        p161:PreUpdate(v164, p162)
        p161:RunLoop(v164, p162, p163)
        p161:CalculateTransforms(v164, p162)
    end
end
function u17.Start() --[[ Line: 554 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u10
        [3] = u16
        [4] = u1
        [5] = u15
    --]]
    local v165 = game:FindService("Players")
    local u166 = v165.LocalPlayer or v165.PlayerAdded:Wait()
    local u167 = Instance.new("Folder")
    u167.Name = "Actors"
    u167.Parent = u166:WaitForChild("PlayerScripts")
    local u168 = {}
    local u169 = {}
    local function v182(p170) --[[ Line: 568 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u166
            [3] = u167
            [4] = u168
            [5] = u169
            [6] = u12
        --]]
        if p170:IsA("BasePart") and (u10.WaitForChildOfClass(p170, "Bone", 10) and workspace:IsAncestorOf(p170)) then
            local v171 = u166.Character
            if v171 and p170:IsDescendantOf(v171) == false then
                return
            end
            if v171 == nil then
                return
            end
            local v172 = {}
            if p170:GetAttribute("Roots") and typeof(p170:GetAttribute("Roots")) == "string" then
                for _, v173 in string.split(p170:GetAttribute("Roots"), ",") do
                    local v174 = p170:FindFirstChild(v173, true)
                    if v174 and v174:IsA("Bone") then
                        table.insert(v172, v174)
                    else
                        warn("Missing bone from SmartBone Module: " .. v173)
                    end
                end
            end
            if #v172 > 0 then
                local u175 = Instance.new("Actor")
                local v176 = Instance.new("BindableFunction")
                v176.Name = "Event"
                v176.Parent = u175
                local v177 = script.Dependencies.ActorScript:Clone()
                v177.Name = "Runtime"
                v177.Parent = u175
                u175.Parent = u167
                v177.Enabled = true
                u168[p170] = v176:Invoke(p170, v172)
                u175.Name = p170.Name .. u168[p170].ID
                u168[p170].RemovedEvent.Event:Once(function() --[[ Line: 610 ]]
                    --[[
                    Upvalues:
                        [1] = u175
                    --]]
                    u175.Runtime.Enabled = false
                    u175:Destroy()
                end)
                local v178 = u169
                table.insert(v178, p170)
                local v179 = "Created new SmartBone Object with ID: " .. u168[p170].ID
                if u12 then
                    warn(v179)
                    return
                end
            else
                local v180 = u169
                table.insert(v180, p170)
                local v181 = "Failed to create SmartBone Object for " .. p170:GetFullName() .. "! Make sure you have defined the Root Bone(s) for this object!"
                if u12 then
                    warn(v181)
                end
            end
        end
    end
    local function v189(p183) --[[ Line: 628 ]]
        --[[
        Upvalues:
            [1] = u168
            [2] = u12
            [3] = u16
        --]]
        if u168[p183] then
            local v184 = "Removing SmartBone Object with ID: " .. u168[p183].ID
            if u12 then
                warn(v184)
            end
            for _, v185 in u168[p183].Connections do
                v185:Disconnect()
            end
            u168[p183].SimulationConnection:Disconnect()
            task.wait()
            u168[p183].RemovedEvent:Destroy()
            for _, v186 in u168[p183].ParticleTrees do
                for _, v187 in v186.Particles do
                    for _, v188 in v187.RecyclingBin do
                        v188:Destroy()
                    end
                    if v187.DebugPart then
                        v187.DebugPart:Destroy()
                        v187.DebugPart = nil
                    end
                end
            end
            task.wait()
            if u16[u168[p183].ID] then
                u16[u168[p183].ID] = nil
            end
            u168[p183].Removed = true
            u168[p183].RemovedEvent:Fire()
            u168[p183] = nil
        end
    end
    u1:GetInstanceAddedSignal("SmartBone"):Connect(v182)
    u1:GetInstanceRemovedSignal("SmartBone"):Connect(v189)
    for _, v190 in u15 do
        if not u168[v190] and (not table.find(u169, v190) and v190:IsDescendantOf(workspace)) then
            task.spawn(v182, v190)
        end
    end
end
return u17