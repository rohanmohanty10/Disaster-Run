 

local v1 = game:GetService("ReplicatedStorage").Modules.Utils
local u2 = workspace.Camera
local u3 = script.Sounds
local u4 = script.Animations
local u5 = script.Assets
local u6 = {
    ["Forward"] = "Backward",
    ["Backward"] = "Forward"
}
local u7 = require(v1.Signal)
local u8 = require(v1.Spring)
local u9 = require(v1.Cleaner)
local u10 = {}
u10.__index = u10
function u10.new(p11, p12, p13) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u7
        [3] = u9
    --]]
    local v14 = u10
    local v15 = setmetatable({}, v14)
    v15.Destroyed = u7.new()
    v15._cleaner = u9.new()
    v15._distanceReverseThreshold = 5
    v15._start = os.clock()
    v15._character = p11
    v15._rootPart = p11.HumanoidRootPart
    v15._baseVelocity = 50
    v15._velocity = v15._baseVelocity
    v15._direction = v15:_getDirection(p12)
    v15._partData = v15:_getPartData(p12)
    v15._heightOffset = v15:_getHeightOffset(p13)
    v15._animations = v15:_getAnimations()
    v15._faceDirection = v15._rootPart.CFrame.LookVector
    v15._spring = v15:_createSpring()
    v15._sparks = v15:_createSparkVFX()
    v15._startDistance = v15:_getStartingDistance(p12)
    v15._updateCallbacks = {}
    return v15
end
function u10._getStartingDistance(p16, p17) --[[ Line: 67 ]]
    local v18 = p17.Size.Z
    local v19 = p17.CFrame * CFrame.new(0, 0, (v18 / 2 - v18) * (p16._direction == "Forward" and 1 or -1)) * CFrame.Angles(0, p16._direction == "Forward" and 0 or 3.141592653589793, 0)
    return -v19.LookVector:Dot(p16._rootPart.Position - v19.Position)
end
function u10._createSparkVFX(_) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v20 = u5.VFX:Clone()
    v20.Parent = workspace.Effects
    return v20
end
function u10._getAnimations(p21) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v22 = p21._character.Humanoid.Animator
    local v23 = u4:GetChildren()
    local v24 = {}
    for v25 = 1, #v23 do
        v24[v23[v25].Name] = v22:LoadAnimation(v23[v25])
        v24[v23[v25].Name].Priority = Enum.AnimationPriority.Action2
    end
    return v24
end
function u10._getHeightOffset(p26, p27) --[[ Line: 94 ]]
    local v28 = p26._rootPart
    local v29 = p26._character.Humanoid
    local v30 = v28.Size.Y * 0.5 + v29.HipHeight / 1.4
    return CFrame.new(0, v30 * p27, 0)
end
function u10._createSpring(p31) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v32 = u8.new(p31._rootPart.CFrame.LookVector)
    v32.Damper = 0.1
    v32.Speed = 2
    return v32
end
function u10._getPartByDistance(p33, p34) --[[ Line: 113 ]]
    local v35 = p33._partData
    local v36 = #v35
    local v37 = 1
    while v37 <= v36 do
        local v38 = (v36 + v37) / 2
        local v39 = math.floor(v38)
        local v40 = v39 == 1 and 0 or v35[v39 - 1].Distance
        if p34 <= v35[v39].Distance and v40 <= p34 then
            return v35[v39]
        end
        if p34 < v40 then
            v36 = v39 - 1
        else
            v37 = v39 + 1
        end
    end
end
function u10._getPartData(p41, p42) --[[ Line: 131 ]]
    local v43 = p41._direction
    local v44 = p42.Size.Z
    local v45 = {
        {
            ["Part"] = p42,
            ["Distance"] = v44,
            ["Length"] = p42.Size.Z
        }
    }
    while true do
        local v46 = p42:FindFirstChild(v43)
        if not v46 then
            break
        end
        p42 = v46.Value
        local v47 = p42.Size.Z
        v44 = v44 + v47
        table.insert(v45, {
            ["Part"] = p42,
            ["Distance"] = v44,
            ["Length"] = v47
        })
    end
    return v45
end
function u10._createBodyMovers(p48) --[[ Line: 161 ]]
    local v49 = p48._rootPart
    local v50 = Instance.new("BodyPosition")
    v50.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
    v50.Position = v49.Position
    v50.D = 250
    v50.P = 100000
    v50.Parent = v49
    local v51 = Instance.new("BodyGyro")
    v51.MaxTorque = Vector3.new(2000000000, 2000000000, 2000000000)
    v51.CFrame = v49.CFrame
    v51.D = 1000
    v51.P = 100000
    v51.Parent = v49
    p48._cleaner:AddTask(v50, v51)
    return {
        ["BodyPosition"] = v50,
        ["BodyGyro"] = v51
    }
end
function u10._getDirection(p52, p53) --[[ Line: 183 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
    --]]
    local _ = p52._rootPart
    local v54 = u2.CFrame.LookVector
    local v55 = -1
    local v56 = nil
    for _, v57 in p53:GetChildren() do
        local v58 = (v57.Value.Position - p53.Position).Unit
        local v59 = vector.dot(v54, v58)
        if v59 >= v55 then
            v56 = v57.Name
            v55 = v59
        end
    end
    local v60 = p52._distanceReverseThreshold
    local v61 = p53
    local v62 = 0
    while true do
        local v63 = p53:FindFirstChild(v56)
        if not v63 then
            break
        end
        p53 = v63.Value
        v62 = v62 + v61.Size.Z
    end
    if v62 < v60 then
        v56 = u6[v56] or v56
    end
    return v56
end
function u10.Update(p64, p65) --[[ Line: 218 ]]
    local v66 = (os.clock() - p64._start) * p64._velocity + p64._startDistance
    local v67 = math.max(v66, 0)
    local v68 = p64:_getPartByDistance(v67)
    if v68 then
        local v69 = p64._character
        if v69:FindFirstChild("Stun") then
            p64:Exit()
            return
        elseif v69:GetAttribute("flyMode") then
            p64:Exit()
        else
            local _ = p64._character
            local v70 = p64._character.Humanoid
            local v71 = v68.Part
            local v72 = (v68.Distance - v67) / v68.Length
            local v73 = p64._heightOffset
            local v74 = v71.CFrame * CFrame.new(0, 0, (v68.Length / 2 - v68.Length * v72) * (p64._direction == "Forward" and 1 or -1)) * CFrame.Angles(0, p64._direction == "Forward" and 3.141592653589793 or 0, 0)
            p64._spring.Target = v74.LookVector
            local v75 = v70.RootPart.CFrame:ToObjectSpace(CFrame.new(v70.RootPart.Position + p64._spring.Position))
            local v76 = v74 * CFrame.Angles(v75.Z / 2, 0, v75.X / 2)
            local v77 = v75.X
            local v78 = -math.min(v77, 0.001) * 2
            p64._animations.HoldSwayLeft:AdjustWeight(v78)
            p64._animations.GrindLeft:AdjustWeight(v78)
            local v79 = v75.X
            local v80 = math.max(v79, 0.001) * 2
            p64._animations.HoldSwayRight:AdjustWeight(v80)
            p64._animations.GrindRight:AdjustWeight(v80)
            local v81 = 1 - (v78 + v80)
            p64._animations.Grind:AdjustWeight(v81)
            p64._animations.Hold:AdjustWeight(v81)
            p64._sparks.CFrame = v76
            p64._faceDirection = p64._faceDirection:Lerp(v76.LookVector, p65 * 15)
            p64._character.PrimaryPart.CFrame = CFrame.lookAlong((v76 * v73).Position, p64._faceDirection)
            p64._character.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
            p64._character.PrimaryPart.AssemblyAngularVelocity = Vector3.new()
            p64._velocity = p64._velocity + p65 * 2
            if p64.LoopSound then
                p64.LoopSound.Pitch = p64._velocity / p64._baseVelocity
            end
            for _, v82 in p64._updateCallbacks do
                v82(v67, v76, v75)
            end
        end
    else
        p64:Exit()
        return
    end
end
function u10._createZiplineHandle(p83) --[[ Line: 288 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v84 = u5.ZiplineHandle:Clone()
    v84.Parent = workspace.Effects
    local v85 = v84:GetExtentsSize()
    for _, v86 in v84:GetDescendants() do
        if v86:IsA("BasePart") then
            v86.Anchored = true
        end
    end
    p83._heightOffset = p83._heightOffset * CFrame.new(0, -v85.Y * 0.7, 0)
    p83._cleaner:AddTask(v84)
    return v84
end
function u10.Enter(u87) --[[ Line: 305 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v88 = u87._character.Humanoid
    local v89 = u87._character
    v88.EvaluateStateMachine = false
    u87._character.Humanoid.AutoRotate = false
    local v90 = u3.ZiplineStart:Clone()
    v90.Parent = u87._rootPart
    v90:Play()
    task.delay(5, v90.Destroy, v90)
    local v91 = u3.ZiplineLoop:Clone()
    v91.Parent = u87._rootPart
    v91:Play()
    u87.LoopSound = v91
    u87._cleaner:AddTask(v91)
    _G.canuse = false
    if v89:FindFirstChild("inCombat") then
        u87._velocity = u87._baseVelocity / 2
    end
    local v92 = v89:FindFirstChild("RagdollConstraints")
    if v92 then
        for _, v93 in ipairs(v92:GetChildren()) do
            if v93:IsA("Constraint") then
                local _ = v93.Attachment1
                v93.Enabled = false
            end
        end
    end
    if u87._heightOffset.Y < 0 then
        u87._animations.Hold:Play(nil, 0.001)
        u87._animations.HoldSwayLeft:Play(nil, 0.001)
        u87._animations.HoldSwayRight:Play(nil, 0.001)
        local u94 = u87:_createZiplineHandle()
        local u95 = Instance.new("Attachment", workspace.Terrain)
        local u96 = u94:FindFirstChild("HandleAttachment", true)
        local v97 = Instance.new("IKControl")
        v97.ChainRoot = u87._character.RightUpperArm
        v97.EndEffector = u87._character.RightHand
        v97.Target = u95
        v97.Parent = u87._rootPart
        u95.WorldCFrame = u87._character.RightUpperArm.CFrame
        u87._cleaner:AddTask(u95, v97)
        local v98 = u87._updateCallbacks
        table.insert(v98, function(_, p99, _) --[[ Line: 361 ]]
            --[[
            Upvalues:
                [1] = u94
                [2] = u87
                [3] = u95
                [4] = u96
            --]]
            if p99 then
                u94:PivotTo(p99 * CFrame.Angles(3.141592653589793, u87._direction == "Forward" and 3.141592653589793 or 0, 0) * CFrame.new(0, -0.8, 0))
                u95.WorldCFrame = u96.WorldCFrame * CFrame.Angles(3.141592653589793, u87._direction == "Forward" and 3.141592653589793 or 0, 0)
            end
        end)
    else
        local v100 = u87._character
        u87._animations.Grind:Play(nil, 0.001)
        u87._animations.GrindLeft:Play(nil, 0.001)
        u87._animations.GrindRight:Play(nil, 0.001)
        local u101 = Instance.new("Attachment", workspace.Terrain)
        local u102 = Instance.new("Attachment", workspace.Terrain)
        u102.WorldCFrame = v100.RightFoot.CFrame
        u101.WorldCFrame = v100.LeftFoot.CFrame
        local v103 = Instance.new("IKControl")
        v103.ChainRoot = u87._character.LeftUpperLeg
        v103.EndEffector = u87._character.LeftFoot
        v103.Target = u101
        v103.Parent = u87._rootPart
        local v104 = Instance.new("IKControl")
        v104.ChainRoot = u87._character.RightUpperLeg
        v104.EndEffector = u87._character.RightFoot
        v104.Target = u102
        v104.Parent = u87._rootPart
        u87._cleaner:AddTask(u101, u102, v103, v104)
        local v105 = u87._updateCallbacks
        table.insert(v105, function(p106) --[[ Line: 394 ]]
            --[[
            Upvalues:
                [1] = u87
                [2] = u101
                [3] = u102
            --]]
            local v107 = p106 + 2
            local v108 = u87:_getPartByDistance(v107)
            local v109 = CFrame.new(0, -0.25, 0) * CFrame.Angles(3.141592653589793, 0, 0)
            if v108 then
                local v110 = v108.Part
                local v111 = (v108.Distance - v107) / v108.Length
                u101.WorldCFrame = v110.CFrame * CFrame.new(0, 0, (v108.Length / 2 - v108.Length * v111) * (u87._direction == "Forward" and 1 or -1)) * CFrame.Angles(3.141592653589793, u87._direction == "Forward" and 3.141592653589793 or 0, 0) * v109
            end
            local v112 = p106 - 1
            local v113 = u87:_getPartByDistance(v112)
            if v113 then
                local v114 = v113.Part
                local v115 = (v113.Distance - v112) / v113.Length
                u102.WorldCFrame = v114.CFrame * CFrame.new(0, 0, (v113.Length / 2 - v113.Length * v115) * (u87._direction == "Forward" and 1 or -1)) * CFrame.Angles(3.141592653589793, u87._direction == "Forward" and 3.141592653589793 or 0, 0) * v109
            end
        end)
    end
    for _, v116 in u87._updateCallbacks do
        v116(0)
    end
end
function u10.Exit(p117, p118) --[[ Line: 431 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    p117._character.Humanoid.EvaluateStateMachine = true
    p117._character.Humanoid.AutoRotate = true
    for _, v119 in p117._sparks:GetDescendants() do
        if v119:IsA("ParticleEmitter") then
            v119.Enabled = false
        end
    end
    task.delay(1, p117._sparks.Destroy, p117._sparks)
    for _, v120 in pairs(p117._animations) do
        v120:AdjustWeight(0.001)
        v120:Stop()
    end
    p117.LoopSound = nil
    local v121 = p117._character:FindFirstChild("RagdollConstraints")
    if v121 then
        for _, v122 in ipairs(v121:GetChildren()) do
            if v122:IsA("Constraint") then
                local _ = v122.Attachment1
                v122.Enabled = true
            end
        end
    end
    local v123 = u3.ZiplineEnd:Clone()
    v123.Parent = p117._rootPart
    v123:Play()
    task.delay(5, v123.Destroy, v123)
    if p118 then
        p117._animations.Dismount:Play()
        local v124 = u3.ZiplineJump:Clone()
        v124.Parent = p117._rootPart
        v124:Play()
        task.delay(3, v124.Destroy, v124)
        local v125 = Instance.new("BodyVelocity")
        v125.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        v125.Velocity = Vector3.new(0, 75, 0) + p117._rootPart.CFrame.LookVector * 35
        v125.Parent = p117._character.LowerTorso
        task.delay(0.1, v125.Destroy, v125)
    end
    _G.canuse = true
    p117:Destroy()
end
function u10.Destroy(p126) --[[ Line: 488 ]]
    p126._cleaner:Destroy()
    p126._rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    p126.Destroyed:Fire()
    setmetatable(p126, nil)
end
return u10