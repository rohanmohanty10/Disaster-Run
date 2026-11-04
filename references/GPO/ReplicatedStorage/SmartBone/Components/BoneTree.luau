 

local u1 = game:GetService("Lighting")
local v2 = script.Parent.Parent:WaitForChild("Dependencies")
require(script.Parent:WaitForChild("Bone"))
local u3 = require(v2:WaitForChild("Config"))
local u4 = require(v2:WaitForChild("DefaultObjectSettings"))
local u5 = require(v2:WaitForChild("Debug"):WaitForChild("Gizmo"))
local v6 = require(v2:WaitForChild("Utilities"))
local _ = math.floor
local u7 = math.clamp
local _ = math.max
local _ = math.tan
local _ = Vector3.new
local u8 = CFrame.new
local u9 = Random.new(1029410295159813)
local u10 = v6.SB_VERBOSE_LOG
local u11 = game:GetService("CollectionService")
local u12 = u4.WindDirection
local u13 = u4.WindSpeed
local u14 = u4.WindStrength
local u15 = -1
local u16 = {}
u16.__index = u16
function u16.new(p17, u18, u19) --[[ Line: 182 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u16
        [3] = u4
        [4] = u11
    --]]
    local v20 = {
        ["WindOffset"] = u9:NextNumber(0, 1000000),
        ["Root"] = p17:IsA("Bone") and p17 and p17 or nil,
        ["RootPart"] = u18,
        ["RootPartSize"] = u18.Size,
        ["Bones"] = {},
        ["Positions"] = {},
        ["LastPositions"] = {},
        ["Settings"] = u19,
        ["UpdateRate"] = 0,
        ["InView"] = true,
        ["AccumulatedDelta"] = 0,
        ["BoundingBoxCFrame"] = u18.CFrame,
        ["BoundingBoxSize"] = u18.Size,
        ["Destroyed"] = false,
        ["IsSkippingUpdates"] = false,
        ["InWorkspace"] = false,
        ["Force"] = Vector3.new(0, 0, 0),
        ["ObjectMove"] = Vector3.new(0, 0, 0),
        ["ObjectVelocity"] = Vector3.new(0, 0, 0),
        ["ObjectAcceleration"] = Vector3.new(0, 0, 0),
        ["ObjectPreviousPosition"] = u18.Position
    }
    local v21 = u16
    local u22 = setmetatable(v20, v21)
    u22.InWorkspace = u18:IsDescendantOf(workspace)
    u22.DestroyConnection = u18.AncestryChanged:ConnectParallel(function() --[[ Line: 213 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u22
        --]]
        if not u18:IsDescendantOf(game) then
            u22.Destroyed = true
        end
        u22.InWorkspace = u18:IsDescendantOf(workspace)
    end)
    u22.AttributeConnection = u18.AttributeChanged:ConnectParallel(function(p23) --[[ Line: 221 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u18
            [3] = u4
        --]]
        u19[p23] = u18:GetAttribute(p23) or u4[p23]
    end)
    u22.TagConnection = u11:GetInstanceRemovedSignal("SmartBone"):Connect(function(p24) --[[ Line: 226 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u22
        --]]
        if p24 == u18 then
            u22.Destroyed = true
        end
    end)
    return u22
end
function u16.UpdateBoundingBox(p25) --[[ Line: 261 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    if p25.InView then
        local v26 = p25.Positions
        local v27 = p25.LastPositions
        local v28 = Vector3.new(inf, inf, inf)
        local v29 = Vector3.new(-inf, -inf, -inf)
        for v30 = 1, #v26 do
            local v31 = v26[v30]
            local v32 = v31 + (v31 - v27[v30])
            v28 = v28:Min(v32)
            v29 = v29:Max(v32)
        end
        p25.BoundingBoxCFrame = u8((v28 + v29) * 0.5)
        p25.BoundingBoxSize = p25.RootPartSize:Max(v29 - v28)
    else
        p25.BoundingBoxCFrame = p25._cachedRootPartCFrame
        p25.BoundingBoxSize = p25.RootPartSize
    end
end
function u16.UpdateThrottling(p33, p34) --[[ Line: 289 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v35 = p33.Settings
    local v36 = v35.ActivationDistance
    local v37 = (p34 - workspace.CurrentCamera.CFrame.Position).Magnitude
    if v36 < v37 then
        p33.UpdateRate = 0
    else
        local v38 = v35.ThrottleDistance
        local v39 = 1 - u7((v37 - v38) / (v36 - v38) * 1 + 0, 0, 1)
        p33.UpdateRate = v35.UpdateRate * v39
    end
end
function u16.PreUpdate(p40, _) --[[ Line: 308 ]]
    local v41 = p40.RootPart.CFrame
    local v42 = v41.Position
    local v43 = p40.RootPart.Size
    p40._cachedRootPartCFrame = v41
    p40._cachedRootBoneCFrame = p40.Bones[1] and p40.Bones[1].Bone.CFrame or CFrame.identity
    local v44 = p40.ObjectVelocity
    local v45 = v42 - p40.ObjectPreviousPosition
    p40.ObjectMove = v45
    p40.ObjectVelocity = v45
    p40.ObjectAcceleration = v44 - v45
    p40.ObjectPreviousPosition = v42
    p40.RootPartSize = v43
    p40:UpdateThrottling(v42)
    p40:UpdateBoundingBox()
    local v46 = p40.Bones
    for v47 = 1, #v46 do
        v46[v47]:PreUpdate(p40)
    end
end
function u16.SyncSoAToBones(p48) --[[ Line: 340 ]]
    local v49 = p48.Positions
    local v50 = p48.LastPositions
    local v51 = p48.Bones
    for v52 = 1, #v51 do
        v51[v52].Position = v49[v52]
        v51[v52].LastPosition = v50[v52]
    end
end
function u16.SyncBonesFromSoA(p53) --[[ Line: 352 ]]
    local v54 = p53.Positions
    local v55 = p53.LastPositions
    local v56 = p53.Bones
    for v57 = 1, #v56 do
        v54[v57] = v56[v57].Position
        v55[v57] = v56[v57].LastPosition
    end
end
function u16.StepPhysics(p58, p59) --[[ Line: 362 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u12
        [3] = u1
        [4] = u4
        [5] = u13
        [6] = u14
    --]]
    local v60 = p58.Settings
    local v61 = v60.Gravity + v60.Force
    if v60.MatchWorkspaceWind == true then
        local v62 = workspace.GlobalWind
        v60.WindDirection = v62.Magnitude == 0 and Vector3.new(0, 0, 0) or v62.Unit
        v60.WindSpeed = v62.Magnitude
    else
        local v63 = shared.FrameCounter
        if u15 ~= v63 then
            u15 = v63
            u12 = u1:GetAttribute("WindDirection") or u4.WindDirection
            u13 = u1:GetAttribute("WindSpeed") or u4.WindSpeed
            u14 = u1:GetAttribute("WindStrength") or u4.WindStrength
        end
        local v64 = u12
        v60.WindDirection = v64.Magnitude == 0 and Vector3.new(0, 0, 0) or v64.Unit
        v60.WindSpeed = u13
    end
    if u15 == shared.FrameCounter then
        v60.WindStrength = u14
    else
        v60.WindStrength = u1:GetAttribute("WindStrength") or u4.WindStrength
    end
    local v65 = p58.Bones
    for v66 = 1, #v65 do
        v65[v66]:StepPhysics(p58, v61, p59)
    end
end
function u16.Constrain(p67, p68, p69) --[[ Line: 399 ]]
    local v70 = p67.Bones
    for v71 = 1, #v70 do
        v70[v71]:Constrain(p67, p68, p69)
    end
end
function u16.SkipUpdate(p72) --[[ Line: 408 ]]
    local v73 = p72.Bones
    for v74 = 1, #v73 do
        v73[v74]:SkipUpdate()
    end
    p72:SyncBonesFromSoA()
    p72.IsSkippingUpdates = true
end
function u16.SolveTransform(p75, p76) --[[ Line: 420 ]]
    local v77 = p75.Bones
    for v78 = 1, #v77 do
        v77[v78]:SolveTransform(p75, p76)
    end
    p75.IsSkippingUpdates = false
end
function u16.ApplyTransform(p79) --[[ Line: 430 ]]
    local v80 = p79.Bones
    for v81 = 1, #v80 do
        v80[v81]:ApplyTransform(p79)
    end
end
function u16.DrawDebug(p82, p83, p84, p85, p86, p87, p88, p89, p90) --[[ Line: 447 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v91 = Color3.fromRGB(248, 168, 20)
    local v92 = Color3.fromRGB(76, 208, 223)
    local v93 = Color3.fromRGB(255, 89, 89)
    local v94 = Color3.new(1, 0, 0)
    local v95 = Color3.new(0, 1, 0)
    local v96 = Color3.new(0, 0, 1)
    if p90 then
        local v97 = p82.RootPart.Position
        local v98 = p82.RootPart.Size.Y * 0.5 + 1
        local v99 = v97 + Vector3.new(0, v98, 0)
        u5.SetStyle(v94, 0, true)
        u5.Arrow:Draw(v99, v99 + p82.ObjectMove, 0.025, 0.1, 6)
        u5.SetStyle(v95, 0, true)
        u5.Arrow:Draw(v99, v99 + p82.ObjectVelocity, 0.025, 0.1, 6)
        u5.SetStyle(v96, 0, true)
        u5.Arrow:Draw(v99, v99 + p82.ObjectAcceleration, 0.025, 0.1, 6)
    end
    u5.PushProperty("AlwaysOnTop", false)
    if p88 then
        u5.PushProperty("Color3", v92)
        u5.Box:Draw(p82.BoundingBoxCFrame, p82.BoundingBoxSize, true)
    end
    if p87 then
        u5.PushProperty("Color3", v92)
        u5.Box:Draw(p82.RootPart.CFrame, p82.RootPart.Size, true)
        u5.SetStyle(v93, 0.75, false)
        u5.VolumeBox:Draw(p82.RootPart.CFrame, p82.RootPart.Size)
        u5.PushProperty("Transparency", 0)
    end
    for v100, v101 in p82.Bones do
        local v102 = v101.Bone.TransformedWorldCFrame.Position
        local v103 = p82.Bones[v101.ParentIndex]
        v101:DrawDebug(p82, p83, p84, p85, p86, p89)
        if p84 and v100 ~= 1 then
            u5.PushProperty("Color3", v91)
            u5.Ray:Draw(v103.Bone.TransformedWorldCFrame.Position, v102)
        end
    end
end
function u16.DrawOverlay(p104, p105) --[[ Line: 512 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if u3.DEBUG_OVERLAY_TREE_INFO or u3.DEBUG_OVERLAY_TREE_OBJECTS then
        p105.Text((("Root Part: %*"):format(p104.RootPart.Name)))
        p105.Text((("Root Bone: %*"):format(p104.Root.Name)))
        p105.Text((("Root Part Size: %*"):format((string.format("%.3f, %.3f, %.3f", p104.RootPart.Size.X, p104.RootPart.Size.Y, p104.RootPart.Size.Z)))))
    end
    if u3.DEBUG_OVERLAY_TREE_INFO or u3.DEBUG_OVERLAY_TREE_NUMERICS then
        p105.Text((("Update Rate: %*"):format((string.format("%.3f", p104.UpdateRate)))))
        p105.Text((("In View: %*"):format(p104.InView)))
        p105.Text((("Accumulated Delta: %*"):format((string.format("%.3f", p104.AccumulatedDelta)))))
        p105.Text((("Force: %*"):format((string.format("%.3f, %.3f, %.3f", p104.Force.X, p104.Force.Y, p104.Force.Z)))))
    end
    local v106 = Color3.new(0.486275, 0.431373, 1)
    local v107 = Color3.new(1, 1, 1)
    if u3.DEBUG_OVERLAY_BONE then
        for v108, v109 in p104.Bones do
            if u3.DEBUG_OVERLAY_MAX_BONES > 0 and u3.DEBUG_OVERLAY_BONE_OFFSET + u3.DEBUG_OVERLAY_MAX_BONES <= v108 then
                break
            end
            if v108 >= u3.DEBUG_OVERLAY_BONE_OFFSET then
                p105.Begin(("Bone %*"):format(v108), v106, v107)
                v109:DrawOverlay(p105)
                p105.End()
            end
        end
    end
end
function u16.Destroy(p110) --[[ Line: 548 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10("Destroy BoneTree")
    task.synchronize()
    p110.DestroyConnection:Disconnect()
    p110.AttributeConnection:Disconnect()
    p110.TagConnection:Disconnect()
    for _, v111 in p110.Bones do
        v111:Destroy()
    end
    table.clear(p110)
    setmetatable(p110, nil)
    task.desynchronize()
end
return u16