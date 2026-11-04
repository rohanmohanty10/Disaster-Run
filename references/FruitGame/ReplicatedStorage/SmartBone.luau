 

local u1 = game:GetService("CollectionService")
local u2 = game:GetService("HttpService")
local u3 = game:GetService("Players")
local u4 = game:GetService("RunService")
local v5 = script:WaitForChild("Components")
local v6 = script:WaitForChild("Dependencies")
local u7 = require(v6:WaitForChild("Debug"):WaitForChild("ImOverlay"))
local u8 = require(v6:WaitForChild("Config"))
local u9 = require(v6:WaitForChild("Frustum"))
local u10 = require(v6:WaitForChild("Utilities"))
local u11 = nil
local u12 = require(v5:WaitForChild("Bone"))
local u13 = require(v5:WaitForChild("BoneTree"))
local u14 = require(v5:WaitForChild("Collision"):WaitForChild("ColliderObject"))
local u15 = v6:WaitForChild("Runtime")
local u16 = u10.SB_INDENT_LOG
local u17 = u10.SB_UNINDENT_LOG
local u18 = u10.SB_VERBOSE_LOG
local u19 = u10.SB_VERBOSE_WARN
local u20 = {}
u20.__index = u20
function u20.new() --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u20
    --]]
    local v21 = {
        ["ID"] = u2:GenerateGUID(false),
        ["BoneTrees"] = {},
        ["ColliderObjects"] = {},
        ["ShouldDestroy"] = false,
        ["_activeColliders"] = {}
    }
    local v22 = u20
    return setmetatable(v21, v22)
end
function u20.m_AppendBone(_, p23, p24, p25, p26) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u12
        [3] = u18
    --]]
    local v27 = u10.GatherBoneSettings(p24)
    local v28 = u12.new(p24, p23.Root, p23.RootPart)
    for v29, v31 in v27 do
        if v31 == "\194\172" or not v31 then
            local v31 = nil
        end
        v28[v29] = v31
    end
    local v32 = p23.Bones[p25]
    if p25 > 0 then
        local v33 = (v32.Position - v28.Position).Magnitude
        v28.FreeLength = v33
        v28.Weight = v33 * 0.7
        v28.HeirarchyLength = p26
        v32.HasChild = true
    end
    if p26 <= p23.Settings.AnchorDepth then
        u18("Anchoring bone")
        v28.Anchored = true
    end
    v28.ParentIndex = p25
    local v34 = #p23.Bones + 1
    p23.Bones[v34] = v28
    p23.Positions[v34] = v28.Position
    p23.LastPositions[v34] = v28.LastPosition
end
function u20.m_CreateBoneTree(u35, p36, p37) --[[ Line: 141 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u10
        [3] = u18
        [4] = u16
        [5] = u17
    --]]
    local u38 = u13.new(p37, p36, u10.GatherObjectSettings(p36))
    u18((("Creating bone tree %*; %*"):format(p36.Name, p37.Name)))
    u16()
    local function u57(p39, p40, p41) --[[ Line: 147 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u16
            [3] = u35
            [4] = u38
            [5] = u57
            [6] = u17
        --]]
        u18((("Adding bone: %*; %*; %*"):format(p39.Name, p40, p41)))
        u16()
        local v42 = false
        for _, v43 in p39:GetChildren() do
            if v43:IsA("Bone") then
                u35:m_AppendBone(u38, v43, p40, p41)
                u57(v43, #u38.Bones, p41 + 1)
                v42 = true
            end
        end
        local v44 = p39.Name
        local v45 = #p39.Name - 3
        local v46 = #p39.Name
        local v47
        if string.sub(v44, v45, v46) == "_end" then
            v47 = true
        else
            local v48 = p39.Name
            local v49 = #p39.Name - 4
            local v50 = #p39.Name
            v47 = string.sub(v48, v49, v50) == "_Tail" and true or v42
        end
        if not v47 then
            u18("Adding tail bone")
            local v51 = p39.Parent
            local v52 = v51:IsA("Bone") and v51.WorldPosition or v51.Position
            local v53 = p39.WorldCFrame + p39.WorldCFrame.UpVector.Unit * (p39.WorldPosition - v52).Magnitude
            local v54 = Instance.new("Bone")
            v54.Parent = p39
            v54.Name = p39.Name .. "_Tail"
            v54.WorldCFrame = v53
            for v55, v56 in p39:GetAttributes() do
                v54:SetAttribute(v55, v56)
            end
            u35:m_AppendBone(u38, v54, #u38.Bones, p41)
        end
        u17()
    end
    u35:m_AppendBone(u38, p37, 0, 0)
    u57(p37, 1, 1)
    u35.BoneTrees[#u35.BoneTrees + 1] = u38
    u17()
end
local u58 = {
    ["CFrame"] = CFrame.identity,
    ["Size"] = Vector3.new(0, 0, 0)
}
function u20.m_UpdateViewFrustum(p59) --[[ Line: 203 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u9
        [3] = u58
    --]]
    if shared.FrameCounter % u8.FRUSTUM_FREQ == 0 then
        local v60, v61, v62, v63, v64, v65, v66, v67, v68 = u9.GetCFrames(workspace.CurrentCamera, u8.FAR_PLANE)
        local v69 = p59.BoneTrees
        for v70 = 1, #v69 do
            local v71 = v69[v70]
            u58.CFrame = v71.BoundingBoxCFrame
            u58.Size = v71.BoundingBoxSize
            v71.InView = u9.ObjectInFrustum(u58, v60, v61, v62, v63, v64, v65, v66, v67, v68)
        end
    end
end
function u20.m_CleanColliders(p72) --[[ Line: 220 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u16
        [3] = u17
    --]]
    local v73 = p72.ColliderObjects
    local v74 = #v73
    if v74 ~= 0 then
        for v75 = v74, 1, -1 do
            local v76 = v73[v75]
            if #v76.Colliders == 0 or v76.Destroyed == true then
                u19("Deleting Collider Object")
                u16()
                v76:Destroy()
                u17()
                table.remove(v73, v75)
            end
        end
    end
end
local u77 = math.floor
function u20.m_UpdateBoneTree(p78, p79, p80, p81) --[[ Line: 251 ]]
    --[[
    Upvalues:
        [1] = u77
        [2] = u18
    --]]
    if p79.Destroyed then
        p79:Destroy()
        table.remove(p78.BoneTrees, p80)
        return
    else
        p79:PreUpdate(p81)
        if p79.InView and (u77(p79.UpdateRate) ~= 0 and p79.InWorkspace) then
            local v82 = p78.ColliderObjects
            for v83 = 1, #v82 do
                v82[v83]:Step()
            end
            local v84 = p78._activeColliders
            table.clear(v84)
            local v85 = p79.BoundingBoxCFrame.Position
            local v86 = p79.BoundingBoxSize.Magnitude * 0.5
            local v87 = 0
            for v88 = 1, #v82 do
                local v89 = v82[v88]
                if v89:CouldIntersectBounds(v85, v86) then
                    v87 = v87 + 1
                    v84[v87] = v89
                end
            end
            local v90 = 1 / p79.UpdateRate
            p79.AccumulatedDelta = p79.AccumulatedDelta + p81
            local v91 = false
            while v90 < p79.AccumulatedDelta do
                p79.AccumulatedDelta = p79.AccumulatedDelta - v90
                p79:StepPhysics(v90)
                p79:Constrain(v84, v90)
                p79:SolveTransform(v90)
                v91 = true
            end
            if v91 then
                p79:SyncBonesFromSoA()
                task.synchronize()
                p79:ApplyTransform()
            end
        else
            local v92 = p79.IsSkippingUpdates
            p79:SkipUpdate()
            if not v92 then
                task.synchronize()
                p79:ApplyTransform()
                u18((("Skipping BoneTree, InView: %*, Update Rate == 0: %*, InWorkspace: %*"):format(p79.InView, u77(p79.UpdateRate) == 0, p79.InWorkspace)))
            end
        end
    end
end
function u20.m_CheckDestroy(p93) --[[ Line: 326 ]]
    p93.ShouldDestroy = false
    if #p93.BoneTrees ~= 0 then
        return false
    end
    p93.ShouldDestroy = true
    return true
end
function u20.LoadObject(p94, p95) --[[ Line: 342 ]]
    local v96 = p95:GetAttribute("Roots")
    if v96 then
        local v97 = v96:split(",")
        local v98 = {}
        for _, v99 in p95:QueryDescendants("Bone") do
            if v98[v99.Name] then
                warn((("[SmartBone2::LoadObject] Duplicate bones of name: %* in RootPart: %*"):format(v99.Name, p95.Name)))
            else
                v98[v99.Name] = v99
            end
        end
        for _, v100 in v97 do
            local v101 = v98[v100]
            if v101 then
                p94:m_CreateBoneTree(p95, v101)
            else
                warn((("[SmartBone2::LoadObject] Couldn\'t find Root Bone of name: %* in RootPart: %*"):format(v100, p95.Name)))
            end
        end
    end
end
function u20.LoadColliderModule(p102, p103, p104) --[[ Line: 379 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u14
    --]]
    assert(p103, "[SmartBone2::LoadColliderModule] No collider module passed in")
    local v105 = u2:JSONDecode((require(p103)))
    local v106 = u14.new(v105, p104)
    p102.ColliderObjects[#p102.ColliderObjects + 1] = v106
end
function u20.LoadRawCollider(p107, p108, p109) --[[ Line: 394 ]]
    --[[
    Upvalues:
        [1] = u14
    --]]
    local v110 = u14.new(p108, p109)
    p107.ColliderObjects[#p107.ColliderObjects + 1] = v110
end
function u20.SkipUpdate(p111) --[[ Line: 402 ]]
    local v112 = p111.BoneTrees
    for v113 = 1, #v112 do
        v112[v113]:SkipUpdate()
    end
end
function u20.StepBoneTrees(p114, p115) --[[ Line: 412 ]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    if p114:m_CheckDestroy() then
        return
    elseif p115 <= 0 then
        u19("DeltaTime is zero or sub zero, not updating.")
    else
        p114:m_CleanColliders()
        p114:m_UpdateViewFrustum()
        for v116, v117 in p114.BoneTrees do
            p114:m_UpdateBoneTree(v117, v116, p115)
        end
    end
end
function u20.DrawDebug(p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, p130, p131) --[[ Line: 445 ]]
    for _, v132 in p118.BoneTrees do
        v132:DrawDebug(p120, p121, p122, p123, p124, p129, p130, p131)
    end
    if p119 then
        for _, v133 in p118.ColliderObjects do
            v133:DrawDebug(p125, p126, p127, p128)
        end
    end
end
function u20.DrawOverlay(p134, p135) --[[ Line: 484 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    if not u8.DEBUG_OVERLAY_ENABLED then
        return
    end
    local v136 = Color3.new(1, 0.431373, 0.713725)
    local v137 = Color3.new(1, 1, 1)
    local v138 = Color3.new(0.486275, 0.431373, 1)
    local v139 = Color3.new(1, 1, 1)
    p135.Begin(("SmartBone Instance ID: %*"):format(p134.ID), v136, v137)
    p135.Text((("Frame Counter: %*"):format(shared.FrameCounter)))
    if u8.DEBUG_OVERLAY_TREE then
        for v140, v141 in p134.BoneTrees do
            if u8.DEBUG_OVERLAY_MAX_TREES > 0 and u8.DEBUG_OVERLAY_TREE_OFFSET + u8.DEBUG_OVERLAY_MAX_TREES <= v140 then
                break
            end
            if v140 >= u8.DEBUG_OVERLAY_TREE_OFFSET then
                p135.Begin(("Bone Tree %*"):format(v140), v138, v139)
                v141:DrawOverlay(p135)
                p135.End()
            end
        end
    end
    p135.End()
end
function u20.Destroy(p142) --[[ Line: 520 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    u18("Deleting SmartBone Object")
    for _, v143 in p142.BoneTrees do
        v143:Destroy()
    end
    for _, v144 in p142.ColliderObjects do
        v144:Destroy()
    end
    table.clear(p142)
    setmetatable(p142, nil)
end
function u20.Start() --[[ Line: 539 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u20
        [3] = u8
        [4] = u3
        [5] = u11
        [6] = u1
        [7] = u18
        [8] = u10
        [9] = u16
        [10] = u15
        [11] = u17
        [12] = u7
    --]]
    if u4:IsClient() then
        if not u20.Running then
            if u8.STARTUP_PRINT_ENABLED or u8.LOG_VERBOSE then
                print((("SmartBone2 v%* Starting"):format(u8.VERSION)))
            end
            u20.Running = true
            local v145 = u3.LocalPlayer:WaitForChild("PlayerScripts")
            local u146 = Instance.new("Folder")
            u146.Name = "SmartBone-Actors"
            u146.Parent = v145
            local v147 = Instance.new("BindableEvent")
            v147.Name = "OverlayEvent"
            v147.Parent = script
            v147.Event:Connect(function(p148, ...) --[[ Line: 567 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u11
                --]]
                if u8.DEBUG_OVERLAY_ENABLED then
                    if p148 == "Text" then
                        u11:Text(...)
                        return
                    elseif p148 == "Begin" then
                        u11:Begin(...)
                    elseif p148 == "End" then
                        u11:End()
                    end
                else
                    return
                end
            end)
            local u149 = {}
            local u150 = {}
            local function u155() --[[ Line: 616 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u18
                    [3] = u8
                --]]
                local v151 = {
                    ["Key"] = {},
                    ["Raw"] = {}
                }
                for _, v152 in u1:GetTagged("SmartCollider") do
                    if v152:IsA("BasePart") then
                        local v153 = v152:GetAttribute("ColliderKey")
                        if v153 then
                            v153 = tostring(v153)
                            if not v151.Key[v153] then
                                v151.Key[v153] = {}
                            end
                            local v154 = v151.Key[v153]
                            v154[#v154 + 1] = v152
                        end
                        u18((("Adding collider: %*, Collider Key: %*"):format(v152.Name, v153)))
                        v151.Raw[#v151.Raw + 1] = v152
                        if u8.YIELD_ON_COLLIDER_GATHER then
                            task.wait()
                        end
                    end
                end
                return v151
            end
            local function v167(u156) --[[ Line: 651 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u18
                    [3] = u16
                    [4] = u155
                    [5] = u150
                    [6] = u15
                    [7] = u146
                    [8] = u149
                    [9] = u17
                --]]
                if u156:IsA("BasePart") then
                    if u156:IsA("BasePart") and (u10.WaitForChildOfClass(u156, "Bone", 10) and workspace:IsAncestorOf(u156)) then
                        u18((("Setup Object: %*"):format(u156.Name)))
                        u16()
                        local v157 = u155()
                        local v158 = u156:GetAttribute("ColliderKey")
                        local v159
                        if v158 then
                            v159 = v157.Key[tostring(v158)] or {}
                        else
                            v159 = v157.Raw or {}
                        end
                        local v160 = {}
                        for _, v161 in v159 do
                            v160[#v160 + 1] = { u10.GetCollider(v161), v161 }
                        end
                        local v162 = table.remove(u150) or Instance.new("Actor")
                        local v163 = u15:Clone()
                        v163.Parent = v162
                        v163.Enabled = true
                        v162.Parent = u146
                        u149[u156] = v162
                        task.wait()
                        v162:SendMessage("Setup", u156, v160, script)
                        u156:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 692 ]]
                            --[[
                            Upvalues:
                                [1] = u156
                                [2] = u149
                                [3] = u150
                            --]]
                            if u156.Parent == nil then
                                local v164 = u156
                                local v165 = u149[v164]
                                u149[v164] = nil
                                if v165 then
                                    local v166 = v165:FindFirstChild("Runtime")
                                    if v166 then
                                        v166.Enabled = false
                                        v166:Destroy()
                                    end
                                    if #u150 >= 32 then
                                        v165:Destroy()
                                    else
                                        v165.Name = "Pooled Actor"
                                        u150[#u150 + 1] = v165
                                    end
                                else
                                    return
                                end
                            else
                                return
                            end
                        end)
                        u18("Runtime Started")
                        u17()
                    end
                end
            end
            local u168 = u1:GetInstanceAddedSignal("SmartBone"):Connect(v167)
            local u172 = u1:GetInstanceRemovedSignal("SmartBone"):Connect(function(p169) --[[ Name: OnObjectFreed, Line 590 ]]
                --[[
                Upvalues:
                    [1] = u149
                    [2] = u150
                --]]
                local v170 = u149[p169]
                u149[p169] = nil
                if v170 then
                    local v171 = v170:FindFirstChild("Runtime")
                    if v171 then
                        v171.Enabled = false
                        v171:Destroy()
                    end
                    if #u150 >= 32 then
                        v170:Destroy()
                    else
                        v170.Name = "Pooled Actor"
                        u150[#u150 + 1] = v170
                    end
                else
                    return
                end
            end)
            for _, v173 in u1:GetTagged("SmartBone") do
                v167(v173)
            end
            if u8.DEBUG_OVERLAY_ENABLED then
                u11 = u7.new()
                local v174 = u3.LocalPlayer.PlayerGui
                local v175 = Instance.new("ScreenGui")
                v175.Name = "SmartBoneDebugOverlay"
                v175.IgnoreGuiInset = true
                v175.ResetOnSpawn = false
                v175.Parent = v174
                u11.BackFrame.Parent = v175
                u4.RenderStepped:Connect(function() --[[ Line: 725 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                    --]]
                    u11:Render()
                end)
            end
            return {
                ["Stop"] = function() --[[ Name: Stop, Line 731 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u168
                        [3] = u172
                        [4] = u8
                        [5] = u146
                        [6] = u150
                        [7] = u149
                    --]]
                    u20.Running = false
                    if u168 then
                        u168:Disconnect()
                    end
                    if u172 then
                        u172:Disconnect()
                    end
                    if u8.RESET_BONE_ON_DESTROY then
                        for _, v176 in u146:GetChildren() do
                            v176:SendMessage("Destroy")
                        end
                    end
                    u146:Destroy()
                    table.clear(u150)
                    table.clear(u149)
                end
            }
        end
        warn("Cannot call Smartbone.Start() multiple times")
    else
        warn("Smartbone.Start() can only be called in client context.")
    end
end
return u20